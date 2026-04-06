import 'dart:async';
import 'package:grpc/grpc.dart';
import '../../models/question.dart';
import '../../models/leaderboard_entry.dart';
import '../../models/game_state.dart';

class QuizGrpcClient {
  final ClientChannel channel;

  QuizGrpcClient(this.channel);

  Future<bool> submitAnswer({
    required String roomId,
    required String userId,
    required String questionId,
    required int selectedIndex,
    required int responseTimeMs,
    required int round,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  // Simulated game event stream
  Stream<GameEventData> streamGameEvents(String roomId, String userId) async* {
    final questions = _sampleQuestions();

    for (int round = 1; round <= 5; round++) {
      // Broadcast question
      yield GameEventData.questionBroadcast(questions[round - 1]);

      // Timer syncs
      for (int remaining = 14; remaining >= 0; remaining--) {
        await Future.delayed(const Duration(seconds: 1));
        yield GameEventData.timerSync(round: round, remainingSecs: remaining);
      }

      // Round result
      yield GameEventData.roundResult(
        round: round,
        correctIndex: _correctAnswers[round - 1],
      );

      // Leaderboard update
      yield GameEventData.leaderboardUpdate(
        entries: _generateLeaderboard(round),
        afterRound: round,
      );

      if (round < 5) {
        // Wait before next round
        await Future.delayed(const Duration(seconds: 5));
      }
    }

    // Match end
    yield GameEventData.matchEnd(
      roomId: roomId,
      winnerUserId: 'user-1',
      winnerUsername: 'Aman',
      standings: [
        const FinalStanding(userId: 'user-1', username: 'Aman', finalScore: 520, rank: 1, correctAnswers: 4),
        const FinalStanding(userId: 'user-2', username: 'Priya', finalScore: 480, rank: 2, correctAnswers: 4),
        const FinalStanding(userId: 'user-3', username: 'Rahul', finalScore: 410, rank: 3, correctAnswers: 3),
        FinalStanding(userId: userId, username: 'You', finalScore: 340, rank: 4, correctAnswers: 3),
        const FinalStanding(userId: 'user-5', username: 'Neha', finalScore: 280, rank: 5, correctAnswers: 2),
      ],
    );
  }

  static final _correctAnswers = [1, 1, 2, 2, 3];

  List<Question> _sampleQuestions() {
    return const [
      Question(questionId: 'q1', text: 'What planet is known as the Red Planet?', options: ['Venus', 'Mars', 'Jupiter', 'Saturn'], difficulty: 'easy', round: 1),
      Question(questionId: 'q2', text: 'What is the chemical symbol for water?', options: ['CO2', 'H2O', 'NaCl', 'O2'], difficulty: 'easy', round: 2),
      Question(questionId: 'q3', text: 'What is the powerhouse of the cell?', options: ['Nucleus', 'Ribosome', 'Mitochondria', 'Golgi'], difficulty: 'medium', round: 3),
      Question(questionId: 'q4', text: 'Which element has atomic number 79?', options: ['Silver', 'Platinum', 'Gold', 'Iron'], difficulty: 'medium', round: 4),
      Question(questionId: 'q5', text: 'What is the most abundant element in the universe?', options: ['Oxygen', 'Carbon', 'Helium', 'Hydrogen'], difficulty: 'hard', round: 5),
    ];
  }

  List<LeaderboardEntry> _generateLeaderboard(int afterRound) {
    final baseScores = [120, 100, 90, 70, 50];
    return [
      LeaderboardEntry(userId: 'user-1', username: 'Aman', score: baseScores[0] * afterRound, rank: 1),
      LeaderboardEntry(userId: 'user-2', username: 'Priya', score: baseScores[1] * afterRound, rank: 2),
      LeaderboardEntry(userId: 'user-3', username: 'Rahul', score: baseScores[2] * afterRound, rank: 3),
      LeaderboardEntry(userId: 'current-user', username: 'You', score: baseScores[3] * afterRound, rank: 4),
      LeaderboardEntry(userId: 'user-5', username: 'Neha', score: baseScores[4] * afterRound, rank: 5),
    ];
  }
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
