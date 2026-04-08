import 'dart:async';
import 'dart:math';
import 'package:grpc/grpc.dart';
import '../../models/question.dart';
import '../../models/leaderboard_entry.dart';
import '../../models/game_state.dart';

// Scoring formula:
// Wrong answer = 0 points
// Correct answer = base + speedBonus
//   base: easy=100, medium=200, hard=300
//   speedBonus = base * 0.5 * max(0, 1 - responseTimeSecs / timeLimitSecs)
// So fastest correct answer on hard = 300 + 150 = 450 pts

int calculateScore({
  required bool correct,
  required String difficulty,
  required double responseTimeSecs,
  required int timeLimitSecs,
}) {
  if (!correct) return 0;

  final base = switch (difficulty) {
    'easy' => 100,
    'medium' => 200,
    'hard' => 300,
    _ => 100,
  };

  final timeRatio = max(0.0, 1.0 - responseTimeSecs / timeLimitSecs);
  final speedBonus = (base * 0.5 * timeRatio).floor();

  return base + speedBonus;
}

class _OpponentProfile {
  final String userId;
  final String username;
  final double accuracy; // 0.0 - 1.0 chance of getting correct
  final double speedFactor; // fraction of time limit used (lower = faster)

  const _OpponentProfile({
    required this.userId,
    required this.username,
    required this.accuracy,
    required this.speedFactor,
  });
}

class QuizGrpcClient {
  final ClientChannel channel;
  final _random = Random();

  // Track user answers per round: round -> {selectedIndex, responseTimeMs}
  final Map<int, _UserAnswer> _userAnswers = {};
  // Cumulative scores: userId -> total score
  final Map<String, int> _scores = {};
  // Correct answer counts
  final Map<String, int> _correctCounts = {};
  // Total response times
  final Map<String, int> _totalResponseMs = {};

  // Dynamically set opponents from matchmaking
  List<_OpponentProfile> _opponents = [];

  QuizGrpcClient(this.channel);

  /// Call before streaming to set the opponents for this match.
  void setOpponents(List<String> opponentIds, List<String> opponentNames) {
    _opponents = List.generate(opponentIds.length, (i) {
      // Random accuracy 50-85%, random speed factor 0.3-0.7
      final accuracy = 0.50 + _random.nextDouble() * 0.35;
      final speed = 0.30 + _random.nextDouble() * 0.40;
      return _OpponentProfile(
        userId: opponentIds[i],
        username: opponentNames[i],
        accuracy: accuracy,
        speedFactor: speed,
      );
    });
  }

  Future<bool> submitAnswer({
    required String roomId,
    required String userId,
    required int selectedIndex,
    required int responseTimeMs,
    required int round,
    required String questionId,
  }) async {
    _userAnswers[round] = _UserAnswer(
      selectedIndex: selectedIndex,
      responseTimeMs: responseTimeMs,
    );
    return true;
  }

  Stream<GameEventData> streamGameEvents(String roomId, String userId) async* {
    _userAnswers.clear();
    _scores.clear();
    _correctCounts.clear();
    _totalResponseMs.clear();

    // Initialize scores
    _scores[userId] = 0;
    _correctCounts[userId] = 0;
    _totalResponseMs[userId] = 0;
    for (final opp in _opponents) {
      _scores[opp.userId] = 0;
      _correctCounts[opp.userId] = 0;
      _totalResponseMs[opp.userId] = 0;
    }

    final questions = _allQuestions()..shuffle(_random);
    final selected = questions.take(5).toList();
    // Assign difficulties: 2 easy, 2 medium, 1 hard
    final difficulties = ['easy', 'easy', 'medium', 'medium', 'hard'];
    for (int i = 0; i < selected.length; i++) {
      selected[i] = _QuestionData(
        id: 'q${i + 1}',
        text: selected[i].text,
        options: selected[i].options,
        correctIndex: selected[i].correctIndex,
        difficulty: difficulties[i],
      );
    }

    for (int round = 1; round <= 5; round++) {
      final q = selected[round - 1];
      final question = Question(
        questionId: q.id,
        text: q.text,
        options: q.options,
        difficulty: q.difficulty,
        timeLimitSecs: 15,
        round: round,
      );

      yield GameEventData.questionBroadcast(question);

      // Timer countdown - wait for user answer
      for (int remaining = 14; remaining >= 0; remaining--) {
        await Future.delayed(const Duration(seconds: 1));
        yield GameEventData.timerSync(round: round, remainingSecs: remaining);
      }

      // Score the user for this round
      final userAnswer = _userAnswers[round];
      if (userAnswer != null) {
        final correct = userAnswer.selectedIndex == q.correctIndex;
        final responseTimeSecs = userAnswer.responseTimeMs / 1000.0;
        final pts = calculateScore(
          correct: correct,
          difficulty: q.difficulty,
          responseTimeSecs: responseTimeSecs,
          timeLimitSecs: 15,
        );
        _scores[userId] = (_scores[userId] ?? 0) + pts;
        if (correct) {
          _correctCounts[userId] = (_correctCounts[userId] ?? 0) + 1;
        }
        _totalResponseMs[userId] =
            (_totalResponseMs[userId] ?? 0) + userAnswer.responseTimeMs;
      } else {
        // No answer submitted = 0 points, count full time
        _totalResponseMs[userId] = (_totalResponseMs[userId] ?? 0) + 15000;
      }

      // Score opponents for this round
      for (final opp in _opponents) {
        final correct = _random.nextDouble() < opp.accuracy;
        // Response time: speedFactor * timeLimit + some randomness
        final baseTime = opp.speedFactor * 15.0;
        final jitter = (_random.nextDouble() - 0.5) * 4.0;
        final responseTime = (baseTime + jitter).clamp(1.0, 14.5);

        final pts = calculateScore(
          correct: correct,
          difficulty: q.difficulty,
          responseTimeSecs: responseTime,
          timeLimitSecs: 15,
        );
        _scores[opp.userId] = (_scores[opp.userId] ?? 0) + pts;
        if (correct) {
          _correctCounts[opp.userId] = (_correctCounts[opp.userId] ?? 0) + 1;
        }
        _totalResponseMs[opp.userId] =
            (_totalResponseMs[opp.userId] ?? 0) + (responseTime * 1000).round();
      }

      // Round result
      yield GameEventData.roundResult(
        round: round,
        correctIndex: q.correctIndex,
      );

      // Build leaderboard sorted by score descending
      yield GameEventData.leaderboardUpdate(
        entries: _buildLeaderboard(userId),
        afterRound: round,
      );

      if (round < 5) {
        await Future.delayed(const Duration(seconds: 5));
      }
    }

    // Match end - build final standings
    final standings = _buildFinalStandings(userId);
    final winner = standings.first;

    yield GameEventData.matchEnd(
      roomId: roomId,
      winnerUserId: winner.userId,
      winnerUsername: winner.username,
      standings: standings,
    );
  }

  List<LeaderboardEntry> _buildLeaderboard(String userId) {
    final allPlayers = <MapEntry<String, String>>[
      MapEntry(userId, 'You'),
      ...(_opponents.map((o) => MapEntry(o.userId, o.username))),
    ];

    allPlayers.sort((a, b) =>
        (_scores[b.key] ?? 0).compareTo(_scores[a.key] ?? 0));

    return List.generate(allPlayers.length, (i) {
      final p = allPlayers[i];
      return LeaderboardEntry(
        userId: p.key,
        username: p.value,
        score: _scores[p.key] ?? 0,
        rank: i + 1,
      );
    });
  }

  List<FinalStanding> _buildFinalStandings(String userId) {
    final allPlayers = <MapEntry<String, String>>[
      MapEntry(userId, 'You'),
      ...(_opponents.map((o) => MapEntry(o.userId, o.username))),
    ];

    allPlayers.sort((a, b) =>
        (_scores[b.key] ?? 0).compareTo(_scores[a.key] ?? 0));

    return List.generate(allPlayers.length, (i) {
      final p = allPlayers[i];
      final rounds = 5;
      final correct = _correctCounts[p.key] ?? 0;
      final totalMs = _totalResponseMs[p.key] ?? 0;
      final avgMs = rounds > 0 ? totalMs ~/ rounds : 0;

      return FinalStanding(
        userId: p.key,
        username: p.value,
        finalScore: _scores[p.key] ?? 0,
        rank: i + 1,
        correctAnswers: correct,
        avgResponseTimeMs: avgMs,
      );
    });
  }

  List<_QuestionData> _allQuestions() {
    return [
      _QuestionData(id: 'q1', text: 'What is the capital of Japan?', options: ['Beijing', 'Seoul', 'Tokyo', 'Bangkok'], correctIndex: 2, difficulty: 'easy'),
      _QuestionData(id: 'q2', text: 'Which planet is closest to the Sun?', options: ['Venus', 'Mercury', 'Mars', 'Earth'], correctIndex: 1, difficulty: 'easy'),
      _QuestionData(id: 'q3', text: 'How many continents are there on Earth?', options: ['5', '6', '7', '8'], correctIndex: 2, difficulty: 'easy'),
      _QuestionData(id: 'q4', text: 'What gas do humans breathe in to survive?', options: ['Nitrogen', 'Carbon Dioxide', 'Oxygen', 'Hydrogen'], correctIndex: 2, difficulty: 'easy'),
      _QuestionData(id: 'q5', text: 'Which animal is known as the King of the Jungle?', options: ['Tiger', 'Elephant', 'Lion', 'Bear'], correctIndex: 2, difficulty: 'easy'),
      _QuestionData(id: 'q6', text: 'What is the largest ocean on Earth?', options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'], correctIndex: 3, difficulty: 'easy'),
      _QuestionData(id: 'q7', text: 'How many colors are in a rainbow?', options: ['5', '6', '7', '8'], correctIndex: 2, difficulty: 'easy'),
      _QuestionData(id: 'q8', text: 'What is the boiling point of water in Celsius?', options: ['90', '100', '110', '120'], correctIndex: 1, difficulty: 'easy'),
      _QuestionData(id: 'q9', text: 'Who wrote the play "Romeo and Juliet"?', options: ['Charles Dickens', 'William Shakespeare', 'Mark Twain', 'Jane Austen'], correctIndex: 1, difficulty: 'medium'),
      _QuestionData(id: 'q10', text: 'What is the chemical symbol for Gold?', options: ['Go', 'Gd', 'Au', 'Ag'], correctIndex: 2, difficulty: 'medium'),
      _QuestionData(id: 'q11', text: 'Which country gifted the Statue of Liberty to the USA?', options: ['England', 'Spain', 'France', 'Germany'], correctIndex: 2, difficulty: 'medium'),
      _QuestionData(id: 'q12', text: 'What is the hardest natural substance on Earth?', options: ['Gold', 'Iron', 'Diamond', 'Platinum'], correctIndex: 2, difficulty: 'medium'),
      _QuestionData(id: 'q13', text: 'How many bones does an adult human body have?', options: ['186', '206', '226', '246'], correctIndex: 1, difficulty: 'medium'),
      _QuestionData(id: 'q14', text: 'Which planet is known as the Morning Star?', options: ['Mars', 'Jupiter', 'Venus', 'Saturn'], correctIndex: 2, difficulty: 'medium'),
      _QuestionData(id: 'q15', text: 'What is the largest desert in the world?', options: ['Sahara', 'Gobi', 'Antarctic', 'Arabian'], correctIndex: 2, difficulty: 'medium'),
      _QuestionData(id: 'q16', text: 'In which year did the Titanic sink?', options: ['1905', '1912', '1918', '1923'], correctIndex: 1, difficulty: 'medium'),
      _QuestionData(id: 'q17', text: 'What is the speed of light approximately in km/s?', options: ['100,000', '200,000', '300,000', '400,000'], correctIndex: 2, difficulty: 'hard'),
      _QuestionData(id: 'q18', text: 'Which element has the highest melting point?', options: ['Iron', 'Tungsten', 'Titanium', 'Platinum'], correctIndex: 1, difficulty: 'hard'),
      _QuestionData(id: 'q19', text: 'What is the half-life of Carbon-14 approximately?', options: ['1,000 years', '5,730 years', '10,000 years', '50,000 years'], correctIndex: 1, difficulty: 'hard'),
      _QuestionData(id: 'q20', text: 'Which mathematician is known for his incompleteness theorems?', options: ['Euler', 'Gauss', 'Godel', 'Turing'], correctIndex: 2, difficulty: 'hard'),
      _QuestionData(id: 'q21', text: 'What is the currency of South Korea?', options: ['Yen', 'Yuan', 'Won', 'Baht'], correctIndex: 2, difficulty: 'medium'),
      _QuestionData(id: 'q22', text: 'Which blood type is known as the universal donor?', options: ['A+', 'B+', 'AB+', 'O-'], correctIndex: 3, difficulty: 'medium'),
      _QuestionData(id: 'q23', text: 'What is the smallest country in the world by area?', options: ['Monaco', 'Vatican City', 'San Marino', 'Malta'], correctIndex: 1, difficulty: 'hard'),
      _QuestionData(id: 'q24', text: 'Who discovered penicillin?', options: ['Louis Pasteur', 'Alexander Fleming', 'Joseph Lister', 'Robert Koch'], correctIndex: 1, difficulty: 'medium'),
      _QuestionData(id: 'q25', text: 'What is the longest river in the world?', options: ['Amazon', 'Nile', 'Yangtze', 'Mississippi'], correctIndex: 1, difficulty: 'hard'),
    ];
  }
}

class _UserAnswer {
  final int selectedIndex;
  final int responseTimeMs;
  _UserAnswer({required this.selectedIndex, required this.responseTimeMs});
}

class _QuestionData {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String difficulty;

  _QuestionData({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.difficulty,
  });
}

enum GameEventType { questionBroadcast, leaderboardUpdate, roundResult, matchEnd, playerJoined, timerSync }

class GameEventData {
  final GameEventType type;
  final Question? question;
  final List<LeaderboardEntry>? leaderboardEntries;
  final int? afterRound;
  final int? round;
  final int? correctIndex;
  final int? remainingSecs;
  final String? roomId;
  final String? winnerUserId;
  final String? winnerUsername;
  final List<FinalStanding>? standings;

  const GameEventData._({
    required this.type,
    this.question,
    this.leaderboardEntries,
    this.afterRound,
    this.round,
    this.correctIndex,
    this.remainingSecs,
    this.roomId,
    this.winnerUserId,
    this.winnerUsername,
    this.standings,
  });

  factory GameEventData.questionBroadcast(Question question) {
    return GameEventData._(type: GameEventType.questionBroadcast, question: question, round: question.round);
  }

  factory GameEventData.leaderboardUpdate({required List<LeaderboardEntry> entries, required int afterRound}) {
    return GameEventData._(type: GameEventType.leaderboardUpdate, leaderboardEntries: entries, afterRound: afterRound);
  }

  factory GameEventData.roundResult({required int round, required int correctIndex}) {
    return GameEventData._(type: GameEventType.roundResult, round: round, correctIndex: correctIndex);
  }

  factory GameEventData.matchEnd({
    required String roomId,
    required String winnerUserId,
    required String winnerUsername,
    required List<FinalStanding> standings,
  }) {
    return GameEventData._(
      type: GameEventType.matchEnd,
      roomId: roomId,
      winnerUserId: winnerUserId,
      winnerUsername: winnerUsername,
      standings: standings,
    );
  }

  factory GameEventData.timerSync({required int round, required int remainingSecs}) {
    return GameEventData._(type: GameEventType.timerSync, round: round, remainingSecs: remainingSecs);
  }
}
