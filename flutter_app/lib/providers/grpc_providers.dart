import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/grpc/grpc_channel.dart';
import '../services/grpc/matchmaking_client.dart';
import '../services/grpc/quiz_client.dart';
import '../services/grpc/real_matchmaking_client.dart';
import '../services/grpc/real_quiz_client.dart';

/// Set to true to use real backend, false for simulated demo mode.
/// To use real backend, start services with: docker-compose up --build
const bool useRealBackend = false;

final grpcChannelProvider = Provider<GrpcChannelService>((ref) {
  final service = GrpcChannelService(host: 'localhost');
  ref.onDispose(() => service.dispose());
  return service;
});

final matchmakingClientProvider = Provider<MatchmakingGrpcClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  if (useRealBackend) {
    return RealMatchmakingGrpcClient(channel.matchmakingChannel);
  }
  return MatchmakingGrpcClient(channel.matchmakingChannel);
});

final quizClientProvider = Provider<QuizGrpcClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  if (useRealBackend) {
    return RealQuizGrpcClient(channel.quizChannel);
  }
  return QuizGrpcClient(channel.quizChannel);
});
