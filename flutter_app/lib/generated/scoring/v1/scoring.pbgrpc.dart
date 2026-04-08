//
//  Generated code. Do not modify.
//  source: scoring/v1/scoring.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'scoring.pb.dart' as $0;

export 'scoring.pb.dart';

@$pb.GrpcServiceName('scoring.v1.ScoringService')
class ScoringServiceClient extends $grpc.Client {
  static final _$calculateScore = $grpc.ClientMethod<$0.ScoreRequest, $0.ScoreResponse>(
      '/scoring.v1.ScoringService/CalculateScore',
      ($0.ScoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ScoreResponse.fromBuffer(value));
  static final _$getLeaderboard = $grpc.ClientMethod<$0.LeaderboardRequest, $0.LeaderboardResponse>(
      '/scoring.v1.ScoringService/GetLeaderboard',
      ($0.LeaderboardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LeaderboardResponse.fromBuffer(value));

  ScoringServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ScoreResponse> calculateScore($0.ScoreRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateScore, request, options: options);
  }

  $grpc.ResponseFuture<$0.LeaderboardResponse> getLeaderboard($0.LeaderboardRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLeaderboard, request, options: options);
  }
}

@$pb.GrpcServiceName('scoring.v1.ScoringService')
abstract class ScoringServiceBase extends $grpc.Service {
  $core.String get $name => 'scoring.v1.ScoringService';

  ScoringServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ScoreRequest, $0.ScoreResponse>(
        'CalculateScore',
        calculateScore_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ScoreRequest.fromBuffer(value),
        ($0.ScoreResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaderboardRequest, $0.LeaderboardResponse>(
        'GetLeaderboard',
        getLeaderboard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LeaderboardRequest.fromBuffer(value),
        ($0.LeaderboardResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ScoreResponse> calculateScore_Pre($grpc.ServiceCall call, $async.Future<$0.ScoreRequest> request) async {
    return calculateScore(call, await request);
  }

  $async.Future<$0.LeaderboardResponse> getLeaderboard_Pre($grpc.ServiceCall call, $async.Future<$0.LeaderboardRequest> request) async {
    return getLeaderboard(call, await request);
  }

  $async.Future<$0.ScoreResponse> calculateScore($grpc.ServiceCall call, $0.ScoreRequest request);
  $async.Future<$0.LeaderboardResponse> getLeaderboard($grpc.ServiceCall call, $0.LeaderboardRequest request);
}
