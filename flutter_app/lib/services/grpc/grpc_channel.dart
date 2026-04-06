import 'package:grpc/grpc.dart';

class GrpcChannelService {
  static const String _defaultHost = 'localhost';
  static const int _matchmakingPort = 50051;
  static const int _quizPort = 50052;
  static const int _scoringPort = 50053;

  late final ClientChannel matchmakingChannel;
  late final ClientChannel quizChannel;
  late final ClientChannel scoringChannel;

  GrpcChannelService({String host = _defaultHost}) {
    matchmakingChannel = _createChannel(host, _matchmakingPort);
    quizChannel = _createChannel(host, _quizPort);
    scoringChannel = _createChannel(host, _scoringPort);
  }

  ClientChannel _createChannel(String host, int port) {
    return ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
        idleTimeout: Duration(minutes: 5),
      ),
    );
  }

  Future<void> dispose() async {
    await matchmakingChannel.shutdown();
    await quizChannel.shutdown();
    await scoringChannel.shutdown();
  }
}
