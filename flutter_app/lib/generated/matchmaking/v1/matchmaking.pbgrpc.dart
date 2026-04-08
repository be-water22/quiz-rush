//
//  Generated code. Do not modify.
//  source: matchmaking/v1/matchmaking.proto
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

import 'matchmaking.pb.dart' as $0;

export 'matchmaking.pb.dart';

@$pb.GrpcServiceName('matchmaking.v1.MatchmakingService')
class MatchmakingServiceClient extends $grpc.Client {
  static final _$joinMatchmaking = $grpc.ClientMethod<$0.JoinRequest, $0.JoinResponse>(
      '/matchmaking.v1.MatchmakingService/JoinMatchmaking',
      ($0.JoinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.JoinResponse.fromBuffer(value));
  static final _$leaveMatchmaking = $grpc.ClientMethod<$0.LeaveRequest, $0.LeaveResponse>(
      '/matchmaking.v1.MatchmakingService/LeaveMatchmaking',
      ($0.LeaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LeaveResponse.fromBuffer(value));
  static final _$subscribeToMatch = $grpc.ClientMethod<$0.SubscribeRequest, $0.MatchEvent>(
      '/matchmaking.v1.MatchmakingService/SubscribeToMatch',
      ($0.SubscribeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MatchEvent.fromBuffer(value));

  MatchmakingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.JoinResponse> joinMatchmaking($0.JoinRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinMatchmaking, request, options: options);
  }

  $grpc.ResponseFuture<$0.LeaveResponse> leaveMatchmaking($0.LeaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$leaveMatchmaking, request, options: options);
  }

  $grpc.ResponseStream<$0.MatchEvent> subscribeToMatch($0.SubscribeRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeToMatch, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('matchmaking.v1.MatchmakingService')
abstract class MatchmakingServiceBase extends $grpc.Service {
  $core.String get $name => 'matchmaking.v1.MatchmakingService';

  MatchmakingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.JoinRequest, $0.JoinResponse>(
        'JoinMatchmaking',
        joinMatchmaking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JoinRequest.fromBuffer(value),
        ($0.JoinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaveRequest, $0.LeaveResponse>(
        'LeaveMatchmaking',
        leaveMatchmaking_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LeaveRequest.fromBuffer(value),
        ($0.LeaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeRequest, $0.MatchEvent>(
        'SubscribeToMatch',
        subscribeToMatch_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SubscribeRequest.fromBuffer(value),
        ($0.MatchEvent value) => value.writeToBuffer()));
  }

  $async.Future<$0.JoinResponse> joinMatchmaking_Pre($grpc.ServiceCall call, $async.Future<$0.JoinRequest> request) async {
    return joinMatchmaking(call, await request);
  }

  $async.Future<$0.LeaveResponse> leaveMatchmaking_Pre($grpc.ServiceCall call, $async.Future<$0.LeaveRequest> request) async {
    return leaveMatchmaking(call, await request);
  }

  $async.Stream<$0.MatchEvent> subscribeToMatch_Pre($grpc.ServiceCall call, $async.Future<$0.SubscribeRequest> request) async* {
    yield* subscribeToMatch(call, await request);
  }

  $async.Future<$0.JoinResponse> joinMatchmaking($grpc.ServiceCall call, $0.JoinRequest request);
  $async.Future<$0.LeaveResponse> leaveMatchmaking($grpc.ServiceCall call, $0.LeaveRequest request);
  $async.Stream<$0.MatchEvent> subscribeToMatch($grpc.ServiceCall call, $0.SubscribeRequest request);
}
