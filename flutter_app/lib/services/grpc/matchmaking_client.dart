import 'package:grpc/grpc.dart';
import '../../models/player.dart';
import '../lobby.dart';

class MatchmakingGrpcClient {
  final ClientChannel channel;
  Player? _currentPlayer;

  MatchmakingGrpcClient(this.channel);

  Future<String> joinMatchmaking(Player player) async {
    _currentPlayer = player;
    await Future.delayed(const Duration(milliseconds: 500));
    return 'ticket-${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> leaveMatchmaking(String userId, String ticketId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Stream<MatchEventData> subscribeToMatch(String userId, String ticketId) async* {
    // Pick 4-9 random opponents (total players = 5-10 including user)
    final opponents = Lobby.pickRandomOpponents(min: 4, max: 9);

    // Simulate finding opponents over time
    await Future.delayed(const Duration(seconds: 2));
    yield MatchEventData.waitUpdate(poolSize: opponents.length ~/ 2, eta: 10);

    await Future.delayed(const Duration(seconds: 2));
    yield MatchEventData.waitUpdate(poolSize: opponents.length, eta: 5);

    await Future.delayed(const Duration(seconds: 2));

    final allPlayers = [
      Player(userId: userId, username: _currentPlayer?.username ?? 'You'),
      ...opponents,
    ];

    yield MatchEventData.matchFound(
      roomId: 'room-${DateTime.now().millisecondsSinceEpoch}',
      players: allPlayers,
      totalRounds: 5,
    );
  }
}

enum MatchEventType { waitUpdate, matchFound, cancelled }

class MatchEventData {
  final MatchEventType type;
  final int? poolSize;
  final int? eta;
  final String? roomId;
  final List<Player>? players;
  final int? totalRounds;
  final String? reason;

  const MatchEventData._({
    required this.type,
    this.poolSize,
    this.eta,
    this.roomId,
    this.players,
    this.totalRounds,
    this.reason,
  });

  factory MatchEventData.waitUpdate({required int poolSize, required int eta}) {
    return MatchEventData._(type: MatchEventType.waitUpdate, poolSize: poolSize, eta: eta);
  }

  factory MatchEventData.matchFound({
    required String roomId,
    required List<Player> players,
    required int totalRounds,
  }) {
    return MatchEventData._(
      type: MatchEventType.matchFound,
      roomId: roomId,
      players: players,
      totalRounds: totalRounds,
    );
  }

  factory MatchEventData.cancelled(String reason) {
    return MatchEventData._(type: MatchEventType.cancelled, reason: reason);
  }
}
