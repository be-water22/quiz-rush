//
//  Generated code. Do not modify.
//  source: quiz/v1/quiz.proto
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

import 'quiz.pb.dart' as $0;

export 'quiz.pb.dart';

@$pb.GrpcServiceName('quiz.v1.QuizService')
class QuizServiceClient extends $grpc.Client {
  static final _$getRoomQuestions = $grpc.ClientMethod<$0.RoomRequest, $0.QuestionsResponse>(
      '/quiz.v1.QuizService/GetRoomQuestions',
      ($0.RoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.QuestionsResponse.fromBuffer(value));
  static final _$submitAnswer = $grpc.ClientMethod<$0.AnswerRequest, $0.AnswerAck>(
      '/quiz.v1.QuizService/SubmitAnswer',
      ($0.AnswerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AnswerAck.fromBuffer(value));
  static final _$streamGameEvents = $grpc.ClientMethod<$0.StreamRequest, $0.GameEvent>(
      '/quiz.v1.QuizService/StreamGameEvents',
      ($0.StreamRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GameEvent.fromBuffer(value));

  QuizServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.QuestionsResponse> getRoomQuestions($0.RoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRoomQuestions, request, options: options);
  }

  $grpc.ResponseFuture<$0.AnswerAck> submitAnswer($0.AnswerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitAnswer, request, options: options);
  }

  $grpc.ResponseStream<$0.GameEvent> streamGameEvents($0.StreamRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamGameEvents, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('quiz.v1.QuizService')
abstract class QuizServiceBase extends $grpc.Service {
  $core.String get $name => 'quiz.v1.QuizService';

  QuizServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RoomRequest, $0.QuestionsResponse>(
        'GetRoomQuestions',
        getRoomQuestions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RoomRequest.fromBuffer(value),
        ($0.QuestionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AnswerRequest, $0.AnswerAck>(
        'SubmitAnswer',
        submitAnswer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AnswerRequest.fromBuffer(value),
        ($0.AnswerAck value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StreamRequest, $0.GameEvent>(
        'StreamGameEvents',
        streamGameEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StreamRequest.fromBuffer(value),
        ($0.GameEvent value) => value.writeToBuffer()));
  }

  $async.Future<$0.QuestionsResponse> getRoomQuestions_Pre($grpc.ServiceCall call, $async.Future<$0.RoomRequest> request) async {
    return getRoomQuestions(call, await request);
  }

  $async.Future<$0.AnswerAck> submitAnswer_Pre($grpc.ServiceCall call, $async.Future<$0.AnswerRequest> request) async {
    return submitAnswer(call, await request);
  }

  $async.Stream<$0.GameEvent> streamGameEvents_Pre($grpc.ServiceCall call, $async.Future<$0.StreamRequest> request) async* {
    yield* streamGameEvents(call, await request);
  }

  $async.Future<$0.QuestionsResponse> getRoomQuestions($grpc.ServiceCall call, $0.RoomRequest request);
  $async.Future<$0.AnswerAck> submitAnswer($grpc.ServiceCall call, $0.AnswerRequest request);
  $async.Stream<$0.GameEvent> streamGameEvents($grpc.ServiceCall call, $0.StreamRequest request);
}
