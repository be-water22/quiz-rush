import 'package:grpc/grpc.dart';
import '../../models/player.dart';

// Simplified client that wraps gRPC generated code
// In production, this would use the generated MatchmakingServiceClient
class MatchmakingGrpcClient {
  final ClientChannel channel;

  MatchmakingGrpcClient(this.channel);

  // Simulated for now - would use generated client
  Future<String> joinMatchmaking(Player player) async {
    // In production:
    // final client = MatchmakingServiceClient(channel);
    // final response = await client.joinMatchmaking(JoinRequest(
    //   userId: player.userId,
    //   username: player.username,
    //   rating: player.rating,
    // ));
    // return response.ticketId;
    await Future.delayed(const Duration(milliseconds: 500));
    return 'ticket-${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> leaveMatchmaking(String userId, String ticketId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // Returns a stream of match events
  Stream<MatchEventData> subscribeToMatch(String userId, String ticketId) async* {
    // Simulate finding opponents over time
    await Future.delayed(const Duration(seconds: 2));
    yield MatchEventData.waitUpdate(poolSize: 3, eta: 10);

    await Future.delayed(const Duration(seconds: 2));
    yield MatchEventData.waitUpdate(poolSize: 4, eta: 5);

    await Future.delayed(const Duration(seconds: 2));
    yield MatchEventData.matchFound(
      roomId: 'room-${DateTime.now().millisecondsSinceEpoch}',
      players: [
        const Player(userId: 'user-1', username: 'Aman', rating: 1500),
        const Player(userId: 'user-2', username: 'Priya', rating: 1450),
        const Player(userId: 'user-3', username: 'Rahul', rating: 1550),
        Player(userId: userId, username: 'You', rating: 1480),
        const Player(userId: 'user-5', username: 'Neha', rating: 1400),
      ],
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
