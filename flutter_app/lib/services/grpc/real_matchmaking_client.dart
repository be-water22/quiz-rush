import 'dart:async';
import 'package:grpc/grpc.dart';
import '../../generated/matchmaking/v1/matchmaking.pbgrpc.dart';
import '../../models/player.dart';
import 'matchmaking_client.dart';

/// Real gRPC matchmaking client that talks to the backend server.
class RealMatchmakingGrpcClient extends MatchmakingGrpcClient {
  late final MatchmakingServiceClient _stub;

  RealMatchmakingGrpcClient(ClientChannel channel) : super(channel) {
    _stub = MatchmakingServiceClient(channel);
  }

  @override
  Future<String> joinMatchmaking(Player player) async {
    final response = await _stub.joinMatchmaking(JoinRequest()
      ..userId = player.userId
      ..username = player.username
      ..rating = 1500);
    return response.ticketId;
  }

  @override
  Future<void> leaveMatchmaking(String userId, String ticketId) async {
    await _stub.leaveMatchmaking(LeaveRequest()
      ..userId = userId
      ..ticketId = ticketId);
  }

  @override
  Stream<MatchEventData> subscribeToMatch(String userId, String ticketId) async* {
    final stream = _stub.subscribeToMatch(SubscribeRequest()
      ..userId = userId
      ..ticketId = ticketId);

    await for (final event in stream) {
      if (event.hasMatchFound()) {
        final mf = event.matchFound;
        final players = mf.players.map((p) => Player(
          userId: p.userId,
          username: p.username,
        )).toList();

        yield MatchEventData.matchFound(
          roomId: mf.roomId,
          players: players,
          totalRounds: mf.totalRounds,
        );
      } else if (event.hasWaitUpdate()) {
        yield MatchEventData.waitUpdate(
          poolSize: event.waitUpdate.poolSize,
          eta: event.waitUpdate.estimatedWaitSecs,
        );
      } else if (event.hasMatchCancelled()) {
        yield MatchEventData.cancelled(event.matchCancelled.reason);
      }
    }
  }
}
