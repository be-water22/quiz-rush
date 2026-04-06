import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/grpc/grpc_channel.dart';
import '../services/grpc/matchmaking_client.dart';
import '../services/grpc/quiz_client.dart';

final grpcChannelProvider = Provider<GrpcChannelService>((ref) {
  final service = GrpcChannelService(host: '10.0.2.2'); // Android emulator localhost
  ref.onDispose(() => service.dispose());
  return service;
});

final matchmakingClientProvider = Provider<MatchmakingGrpcClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return MatchmakingGrpcClient(channel.matchmakingChannel);
});

final quizClientProvider = Provider<QuizGrpcClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return QuizGrpcClient(channel.quizChannel);
});
