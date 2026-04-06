import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../services/grpc/matchmaking_client.dart';
import 'grpc_providers.dart';

final currentUserProvider = StateProvider<Player>((ref) {
  return const Player(userId: 'current-user', username: 'You', rating: 1480);
});

final matchmakingProvider = StateNotifierProvider<MatchmakingNotifier, MatchmakingState>((ref) {
  final client = ref.watch(matchmakingClientProvider);
  final user = ref.watch(currentUserProvider);
  return MatchmakingNotifier(client, user);
});

class MatchmakingNotifier extends StateNotifier<MatchmakingState> {
  final MatchmakingGrpcClient _client;
  final Player _user;
  StreamSubscription? _subscription;
  String? _ticketId;

  MatchmakingNotifier(this._client, this._user) : super(const MatchmakingState());

  Future<void> joinMatchmaking() async {
    state = state.copyWith(status: MatchStatus.searching, foundPlayers: [_user]);

    _ticketId = await _client.joinMatchmaking(_user);

    _subscription = _client.subscribeToMatch(_user.userId, _ticketId!).listen(
      (event) {
        switch (event.type) {
          case MatchEventType.waitUpdate:
            state = state.copyWith(
              etaSeconds: event.eta ?? 15,
            );
            break;
          case MatchEventType.matchFound:
            state = state.copyWith(
              status: MatchStatus.found,
              roomId: event.roomId,
              foundPlayers: event.players ?? [],
              totalRounds: event.totalRounds ?? 5,
            );
            break;
          case MatchEventType.cancelled:
            state = const MatchmakingState();
            break;
        }
      },
      onError: (e) {
        state = const MatchmakingState();
      },
    );
  }

  Future<void> leaveMatchmaking() async {
    _subscription?.cancel();
    if (_ticketId != null) {
      await _client.leaveMatchmaking(_user.userId, _ticketId!);
    }
    state = const MatchmakingState();
  }

  void reset() {
    _subscription?.cancel();
    state = const MatchmakingState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
