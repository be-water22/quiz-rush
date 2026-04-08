//
//  Generated code. Do not modify.
//  source: quiz/v1/quiz.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $1;

class RoomRequest extends $pb.GeneratedMessage {
  factory RoomRequest({
    $core.String? roomId,
  }) {
    final $result = create();
    if (roomId != null) {
      $result.roomId = roomId;
    }
    return $result;
  }
  RoomRequest._() : super();
  factory RoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoomRequest clone() => RoomRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoomRequest copyWith(void Function(RoomRequest) updates) => super.copyWith((message) => updates(message as RoomRequest)) as RoomRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomRequest create() => RoomRequest._();
  RoomRequest createEmptyInstance() => create();
  static $pb.PbList<RoomRequest> createRepeated() => $pb.PbList<RoomRequest>();
  @$core.pragma('dart2js:noInline')
  static RoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomRequest>(create);
  static RoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

class QuestionsResponse extends $pb.GeneratedMessage {
  factory QuestionsResponse({
    $core.Iterable<Question>? questions,
  }) {
    final $result = create();
    if (questions != null) {
      $result.questions.addAll(questions);
    }
    return $result;
  }
  QuestionsResponse._() : super();
  factory QuestionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuestionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QuestionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..pc<Question>(1, _omitFieldNames ? '' : 'questions', $pb.PbFieldType.PM, subBuilder: Question.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuestionsResponse clone() => QuestionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuestionsResponse copyWith(void Function(QuestionsResponse) updates) => super.copyWith((message) => updates(message as QuestionsResponse)) as QuestionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuestionsResponse create() => QuestionsResponse._();
  QuestionsResponse createEmptyInstance() => create();
  static $pb.PbList<QuestionsResponse> createRepeated() => $pb.PbList<QuestionsResponse>();
  @$core.pragma('dart2js:noInline')
  static QuestionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuestionsResponse>(create);
  static QuestionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Question> get questions => $_getList(0);
}

class Question extends $pb.GeneratedMessage {
  factory Question({
    $core.String? questionId,
    $core.String? text,
    $core.Iterable<$core.String>? options,
    $core.String? difficulty,
    $core.String? topic,
    $core.int? timeLimitSecs,
  }) {
    final $result = create();
    if (questionId != null) {
      $result.questionId = questionId;
    }
    if (text != null) {
      $result.text = text;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (difficulty != null) {
      $result.difficulty = difficulty;
    }
    if (topic != null) {
      $result.topic = topic;
    }
    if (timeLimitSecs != null) {
      $result.timeLimitSecs = timeLimitSecs;
    }
    return $result;
  }
  Question._() : super();
  factory Question.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Question.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Question', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'questionId')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..pPS(3, _omitFieldNames ? '' : 'options')
    ..aOS(4, _omitFieldNames ? '' : 'difficulty')
    ..aOS(5, _omitFieldNames ? '' : 'topic')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'timeLimitSecs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Question clone() => Question()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Question copyWith(void Function(Question) updates) => super.copyWith((message) => updates(message as Question)) as Question;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Question create() => Question._();
  Question createEmptyInstance() => create();
  static $pb.PbList<Question> createRepeated() => $pb.PbList<Question>();
  @$core.pragma('dart2js:noInline')
  static Question getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Question>(create);
  static Question? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get questionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set questionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuestionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuestionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get options => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get difficulty => $_getSZ(3);
  @$pb.TagNumber(4)
  set difficulty($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDifficulty() => $_has(3);
  @$pb.TagNumber(4)
  void clearDifficulty() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get topic => $_getSZ(4);
  @$pb.TagNumber(5)
  set topic($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTopic() => $_has(4);
  @$pb.TagNumber(5)
  void clearTopic() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get timeLimitSecs => $_getIZ(5);
  @$pb.TagNumber(6)
  set timeLimitSecs($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimeLimitSecs() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimeLimitSecs() => clearField(6);
}

class AnswerRequest extends $pb.GeneratedMessage {
  factory AnswerRequest({
    $core.String? roomId,
    $core.String? userId,
    $core.String? questionId,
    $core.int? selectedIndex,
    $fixnum.Int64? responseTimeMs,
    $core.int? round,
  }) {
    final $result = create();
    if (roomId != null) {
      $result.roomId = roomId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (questionId != null) {
      $result.questionId = questionId;
    }
    if (selectedIndex != null) {
      $result.selectedIndex = selectedIndex;
    }
    if (responseTimeMs != null) {
      $result.responseTimeMs = responseTimeMs;
    }
    if (round != null) {
      $result.round = round;
    }
    return $result;
  }
  AnswerRequest._() : super();
  factory AnswerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnswerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AnswerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'questionId')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'selectedIndex', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'responseTimeMs')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'round', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnswerRequest clone() => AnswerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnswerRequest copyWith(void Function(AnswerRequest) updates) => super.copyWith((message) => updates(message as AnswerRequest)) as AnswerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnswerRequest create() => AnswerRequest._();
  AnswerRequest createEmptyInstance() => create();
  static $pb.PbList<AnswerRequest> createRepeated() => $pb.PbList<AnswerRequest>();
  @$core.pragma('dart2js:noInline')
  static AnswerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnswerRequest>(create);
  static AnswerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get questionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set questionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuestionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuestionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get selectedIndex => $_getIZ(3);
  @$pb.TagNumber(4)
  set selectedIndex($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelectedIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelectedIndex() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get responseTimeMs => $_getI64(4);
  @$pb.TagNumber(5)
  set responseTimeMs($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasResponseTimeMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponseTimeMs() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get round => $_getIZ(5);
  @$pb.TagNumber(6)
  set round($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRound() => $_has(5);
  @$pb.TagNumber(6)
  void clearRound() => clearField(6);
}

class AnswerAck extends $pb.GeneratedMessage {
  factory AnswerAck({
    $core.bool? accepted,
    $core.String? reason,
  }) {
    final $result = create();
    if (accepted != null) {
      $result.accepted = accepted;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  AnswerAck._() : super();
  factory AnswerAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnswerAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AnswerAck', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'accepted')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnswerAck clone() => AnswerAck()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnswerAck copyWith(void Function(AnswerAck) updates) => super.copyWith((message) => updates(message as AnswerAck)) as AnswerAck;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnswerAck create() => AnswerAck._();
  AnswerAck createEmptyInstance() => create();
  static $pb.PbList<AnswerAck> createRepeated() => $pb.PbList<AnswerAck>();
  @$core.pragma('dart2js:noInline')
  static AnswerAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnswerAck>(create);
  static AnswerAck? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get accepted => $_getBF(0);
  @$pb.TagNumber(1)
  set accepted($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccepted() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccepted() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class StreamRequest extends $pb.GeneratedMessage {
  factory StreamRequest({
    $core.String? roomId,
    $core.String? userId,
    $core.int? lastSeenRound,
  }) {
    final $result = create();
    if (roomId != null) {
      $result.roomId = roomId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (lastSeenRound != null) {
      $result.lastSeenRound = lastSeenRound;
    }
    return $result;
  }
  StreamRequest._() : super();
  factory StreamRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StreamRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'lastSeenRound', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StreamRequest clone() => StreamRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StreamRequest copyWith(void Function(StreamRequest) updates) => super.copyWith((message) => updates(message as StreamRequest)) as StreamRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamRequest create() => StreamRequest._();
  StreamRequest createEmptyInstance() => create();
  static $pb.PbList<StreamRequest> createRepeated() => $pb.PbList<StreamRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamRequest>(create);
  static StreamRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get lastSeenRound => $_getIZ(2);
  @$pb.TagNumber(3)
  set lastSeenRound($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastSeenRound() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastSeenRound() => clearField(3);
}

enum GameEvent_Event {
  question, 
  leaderboard, 
  roundResult, 
  matchEnd, 
  playerJoined, 
  timerSync, 
  notSet
}

class GameEvent extends $pb.GeneratedMessage {
  factory GameEvent({
    QuestionBroadcast? question,
    LeaderboardUpdate? leaderboard,
    RoundResult? roundResult,
    MatchEnd? matchEnd,
    PlayerJoined? playerJoined,
    TimerSync? timerSync,
  }) {
    final $result = create();
    if (question != null) {
      $result.question = question;
    }
    if (leaderboard != null) {
      $result.leaderboard = leaderboard;
    }
    if (roundResult != null) {
      $result.roundResult = roundResult;
    }
    if (matchEnd != null) {
      $result.matchEnd = matchEnd;
    }
    if (playerJoined != null) {
      $result.playerJoined = playerJoined;
    }
    if (timerSync != null) {
      $result.timerSync = timerSync;
    }
    return $result;
  }
  GameEvent._() : super();
  factory GameEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, GameEvent_Event> _GameEvent_EventByTag = {
    1 : GameEvent_Event.question,
    2 : GameEvent_Event.leaderboard,
    3 : GameEvent_Event.roundResult,
    4 : GameEvent_Event.matchEnd,
    5 : GameEvent_Event.playerJoined,
    6 : GameEvent_Event.timerSync,
    0 : GameEvent_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOM<QuestionBroadcast>(1, _omitFieldNames ? '' : 'question', subBuilder: QuestionBroadcast.create)
    ..aOM<LeaderboardUpdate>(2, _omitFieldNames ? '' : 'leaderboard', subBuilder: LeaderboardUpdate.create)
    ..aOM<RoundResult>(3, _omitFieldNames ? '' : 'roundResult', subBuilder: RoundResult.create)
    ..aOM<MatchEnd>(4, _omitFieldNames ? '' : 'matchEnd', subBuilder: MatchEnd.create)
    ..aOM<PlayerJoined>(5, _omitFieldNames ? '' : 'playerJoined', subBuilder: PlayerJoined.create)
    ..aOM<TimerSync>(6, _omitFieldNames ? '' : 'timerSync', subBuilder: TimerSync.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameEvent clone() => GameEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameEvent copyWith(void Function(GameEvent) updates) => super.copyWith((message) => updates(message as GameEvent)) as GameEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameEvent create() => GameEvent._();
  GameEvent createEmptyInstance() => create();
  static $pb.PbList<GameEvent> createRepeated() => $pb.PbList<GameEvent>();
  @$core.pragma('dart2js:noInline')
  static GameEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameEvent>(create);
  static GameEvent? _defaultInstance;

  GameEvent_Event whichEvent() => _GameEvent_EventByTag[$_whichOneof(0)]!;
  void clearEvent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  QuestionBroadcast get question => $_getN(0);
  @$pb.TagNumber(1)
  set question(QuestionBroadcast v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuestion() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuestion() => clearField(1);
  @$pb.TagNumber(1)
  QuestionBroadcast ensureQuestion() => $_ensure(0);

  @$pb.TagNumber(2)
  LeaderboardUpdate get leaderboard => $_getN(1);
  @$pb.TagNumber(2)
  set leaderboard(LeaderboardUpdate v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLeaderboard() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeaderboard() => clearField(2);
  @$pb.TagNumber(2)
  LeaderboardUpdate ensureLeaderboard() => $_ensure(1);

  @$pb.TagNumber(3)
  RoundResult get roundResult => $_getN(2);
  @$pb.TagNumber(3)
  set roundResult(RoundResult v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoundResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoundResult() => clearField(3);
  @$pb.TagNumber(3)
  RoundResult ensureRoundResult() => $_ensure(2);

  @$pb.TagNumber(4)
  MatchEnd get matchEnd => $_getN(3);
  @$pb.TagNumber(4)
  set matchEnd(MatchEnd v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMatchEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatchEnd() => clearField(4);
  @$pb.TagNumber(4)
  MatchEnd ensureMatchEnd() => $_ensure(3);

  @$pb.TagNumber(5)
  PlayerJoined get playerJoined => $_getN(4);
  @$pb.TagNumber(5)
  set playerJoined(PlayerJoined v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlayerJoined() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlayerJoined() => clearField(5);
  @$pb.TagNumber(5)
  PlayerJoined ensurePlayerJoined() => $_ensure(4);

  @$pb.TagNumber(6)
  TimerSync get timerSync => $_getN(5);
  @$pb.TagNumber(6)
  set timerSync(TimerSync v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimerSync() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimerSync() => clearField(6);
  @$pb.TagNumber(6)
  TimerSync ensureTimerSync() => $_ensure(5);
}

class QuestionBroadcast extends $pb.GeneratedMessage {
  factory QuestionBroadcast({
    $core.int? round,
    $core.String? questionId,
    $core.String? text,
    $core.Iterable<$core.String>? options,
    $core.String? difficulty,
    $core.int? timeLimitSecs,
    $1.Timestamp? deadline,
  }) {
    final $result = create();
    if (round != null) {
      $result.round = round;
    }
    if (questionId != null) {
      $result.questionId = questionId;
    }
    if (text != null) {
      $result.text = text;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (difficulty != null) {
      $result.difficulty = difficulty;
    }
    if (timeLimitSecs != null) {
      $result.timeLimitSecs = timeLimitSecs;
    }
    if (deadline != null) {
      $result.deadline = deadline;
    }
    return $result;
  }
  QuestionBroadcast._() : super();
  factory QuestionBroadcast.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuestionBroadcast.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QuestionBroadcast', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'round', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'questionId')
    ..aOS(3, _omitFieldNames ? '' : 'text')
    ..pPS(4, _omitFieldNames ? '' : 'options')
    ..aOS(5, _omitFieldNames ? '' : 'difficulty')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'timeLimitSecs', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'deadline', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuestionBroadcast clone() => QuestionBroadcast()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuestionBroadcast copyWith(void Function(QuestionBroadcast) updates) => super.copyWith((message) => updates(message as QuestionBroadcast)) as QuestionBroadcast;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuestionBroadcast create() => QuestionBroadcast._();
  QuestionBroadcast createEmptyInstance() => create();
  static $pb.PbList<QuestionBroadcast> createRepeated() => $pb.PbList<QuestionBroadcast>();
  @$core.pragma('dart2js:noInline')
  static QuestionBroadcast getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuestionBroadcast>(create);
  static QuestionBroadcast? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get round => $_getIZ(0);
  @$pb.TagNumber(1)
  set round($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRound() => $_has(0);
  @$pb.TagNumber(1)
  void clearRound() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get questionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set questionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuestionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuestionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get text => $_getSZ(2);
  @$pb.TagNumber(3)
  set text($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(2);
  @$pb.TagNumber(3)
  void clearText() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get options => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get difficulty => $_getSZ(4);
  @$pb.TagNumber(5)
  set difficulty($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDifficulty() => $_has(4);
  @$pb.TagNumber(5)
  void clearDifficulty() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get timeLimitSecs => $_getIZ(5);
  @$pb.TagNumber(6)
  set timeLimitSecs($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimeLimitSecs() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimeLimitSecs() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get deadline => $_getN(6);
  @$pb.TagNumber(7)
  set deadline($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeadline() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeadline() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDeadline() => $_ensure(6);
}

class LeaderboardUpdate extends $pb.GeneratedMessage {
  factory LeaderboardUpdate({
    $core.Iterable<LeaderboardEntry>? entries,
    $core.int? afterRound,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    if (afterRound != null) {
      $result.afterRound = afterRound;
    }
    return $result;
  }
  LeaderboardUpdate._() : super();
  factory LeaderboardUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..pc<LeaderboardEntry>(1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: LeaderboardEntry.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'afterRound', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardUpdate clone() => LeaderboardUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardUpdate copyWith(void Function(LeaderboardUpdate) updates) => super.copyWith((message) => updates(message as LeaderboardUpdate)) as LeaderboardUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardUpdate create() => LeaderboardUpdate._();
  LeaderboardUpdate createEmptyInstance() => create();
  static $pb.PbList<LeaderboardUpdate> createRepeated() => $pb.PbList<LeaderboardUpdate>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaderboardUpdate>(create);
  static LeaderboardUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LeaderboardEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get afterRound => $_getIZ(1);
  @$pb.TagNumber(2)
  set afterRound($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAfterRound() => $_has(1);
  @$pb.TagNumber(2)
  void clearAfterRound() => clearField(2);
}

class LeaderboardEntry extends $pb.GeneratedMessage {
  factory LeaderboardEntry({
    $core.String? userId,
    $core.String? username,
    $core.int? score,
    $core.int? rank,
    $core.int? rankChange,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (score != null) {
      $result.score = score;
    }
    if (rank != null) {
      $result.rank = rank;
    }
    if (rankChange != null) {
      $result.rankChange = rankChange;
    }
    return $result;
  }
  LeaderboardEntry._() : super();
  factory LeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'score', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'rankChange', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardEntry clone() => LeaderboardEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardEntry copyWith(void Function(LeaderboardEntry) updates) => super.copyWith((message) => updates(message as LeaderboardEntry)) as LeaderboardEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardEntry create() => LeaderboardEntry._();
  LeaderboardEntry createEmptyInstance() => create();
  static $pb.PbList<LeaderboardEntry> createRepeated() => $pb.PbList<LeaderboardEntry>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaderboardEntry>(create);
  static LeaderboardEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get score => $_getIZ(2);
  @$pb.TagNumber(3)
  set score($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get rank => $_getIZ(3);
  @$pb.TagNumber(4)
  set rank($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRank() => $_has(3);
  @$pb.TagNumber(4)
  void clearRank() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get rankChange => $_getIZ(4);
  @$pb.TagNumber(5)
  set rankChange($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRankChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearRankChange() => clearField(5);
}

class RoundResult extends $pb.GeneratedMessage {
  factory RoundResult({
    $core.int? round,
    $core.int? correctOptionIndex,
    $core.Iterable<PlayerRoundResult>? playerResults,
  }) {
    final $result = create();
    if (round != null) {
      $result.round = round;
    }
    if (correctOptionIndex != null) {
      $result.correctOptionIndex = correctOptionIndex;
    }
    if (playerResults != null) {
      $result.playerResults.addAll(playerResults);
    }
    return $result;
  }
  RoundResult._() : super();
  factory RoundResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoundResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoundResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'round', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'correctOptionIndex', $pb.PbFieldType.O3)
    ..pc<PlayerRoundResult>(3, _omitFieldNames ? '' : 'playerResults', $pb.PbFieldType.PM, subBuilder: PlayerRoundResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoundResult clone() => RoundResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoundResult copyWith(void Function(RoundResult) updates) => super.copyWith((message) => updates(message as RoundResult)) as RoundResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoundResult create() => RoundResult._();
  RoundResult createEmptyInstance() => create();
  static $pb.PbList<RoundResult> createRepeated() => $pb.PbList<RoundResult>();
  @$core.pragma('dart2js:noInline')
  static RoundResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoundResult>(create);
  static RoundResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get round => $_getIZ(0);
  @$pb.TagNumber(1)
  set round($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRound() => $_has(0);
  @$pb.TagNumber(1)
  void clearRound() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get correctOptionIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set correctOptionIndex($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCorrectOptionIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorrectOptionIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<PlayerRoundResult> get playerResults => $_getList(2);
}

class PlayerRoundResult extends $pb.GeneratedMessage {
  factory PlayerRoundResult({
    $core.String? userId,
    $core.bool? correct,
    $core.int? pointsEarned,
    $fixnum.Int64? responseTimeMs,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (correct != null) {
      $result.correct = correct;
    }
    if (pointsEarned != null) {
      $result.pointsEarned = pointsEarned;
    }
    if (responseTimeMs != null) {
      $result.responseTimeMs = responseTimeMs;
    }
    return $result;
  }
  PlayerRoundResult._() : super();
  factory PlayerRoundResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerRoundResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerRoundResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'correct')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pointsEarned', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'responseTimeMs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerRoundResult clone() => PlayerRoundResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerRoundResult copyWith(void Function(PlayerRoundResult) updates) => super.copyWith((message) => updates(message as PlayerRoundResult)) as PlayerRoundResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerRoundResult create() => PlayerRoundResult._();
  PlayerRoundResult createEmptyInstance() => create();
  static $pb.PbList<PlayerRoundResult> createRepeated() => $pb.PbList<PlayerRoundResult>();
  @$core.pragma('dart2js:noInline')
  static PlayerRoundResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerRoundResult>(create);
  static PlayerRoundResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get correct => $_getBF(1);
  @$pb.TagNumber(2)
  set correct($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCorrect() => $_has(1);
  @$pb.TagNumber(2)
  void clearCorrect() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pointsEarned => $_getIZ(2);
  @$pb.TagNumber(3)
  set pointsEarned($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPointsEarned() => $_has(2);
  @$pb.TagNumber(3)
  void clearPointsEarned() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get responseTimeMs => $_getI64(3);
  @$pb.TagNumber(4)
  set responseTimeMs($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponseTimeMs() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseTimeMs() => clearField(4);
}

class MatchEnd extends $pb.GeneratedMessage {
  factory MatchEnd({
    $core.String? roomId,
    $core.String? winnerUserId,
    $core.String? winnerUsername,
    $core.Iterable<FinalStanding>? standings,
  }) {
    final $result = create();
    if (roomId != null) {
      $result.roomId = roomId;
    }
    if (winnerUserId != null) {
      $result.winnerUserId = winnerUserId;
    }
    if (winnerUsername != null) {
      $result.winnerUsername = winnerUsername;
    }
    if (standings != null) {
      $result.standings.addAll(standings);
    }
    return $result;
  }
  MatchEnd._() : super();
  factory MatchEnd.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MatchEnd.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MatchEnd', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'winnerUserId')
    ..aOS(3, _omitFieldNames ? '' : 'winnerUsername')
    ..pc<FinalStanding>(4, _omitFieldNames ? '' : 'standings', $pb.PbFieldType.PM, subBuilder: FinalStanding.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MatchEnd clone() => MatchEnd()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MatchEnd copyWith(void Function(MatchEnd) updates) => super.copyWith((message) => updates(message as MatchEnd)) as MatchEnd;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchEnd create() => MatchEnd._();
  MatchEnd createEmptyInstance() => create();
  static $pb.PbList<MatchEnd> createRepeated() => $pb.PbList<MatchEnd>();
  @$core.pragma('dart2js:noInline')
  static MatchEnd getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MatchEnd>(create);
  static MatchEnd? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get winnerUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set winnerUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWinnerUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWinnerUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get winnerUsername => $_getSZ(2);
  @$pb.TagNumber(3)
  set winnerUsername($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWinnerUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearWinnerUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<FinalStanding> get standings => $_getList(3);
}

class FinalStanding extends $pb.GeneratedMessage {
  factory FinalStanding({
    $core.String? userId,
    $core.String? username,
    $core.int? finalScore,
    $core.int? rank,
    $core.int? correctAnswers,
    $fixnum.Int64? avgResponseTimeMs,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (finalScore != null) {
      $result.finalScore = finalScore;
    }
    if (rank != null) {
      $result.rank = rank;
    }
    if (correctAnswers != null) {
      $result.correctAnswers = correctAnswers;
    }
    if (avgResponseTimeMs != null) {
      $result.avgResponseTimeMs = avgResponseTimeMs;
    }
    return $result;
  }
  FinalStanding._() : super();
  factory FinalStanding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinalStanding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FinalStanding', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'finalScore', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'correctAnswers', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'avgResponseTimeMs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinalStanding clone() => FinalStanding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinalStanding copyWith(void Function(FinalStanding) updates) => super.copyWith((message) => updates(message as FinalStanding)) as FinalStanding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinalStanding create() => FinalStanding._();
  FinalStanding createEmptyInstance() => create();
  static $pb.PbList<FinalStanding> createRepeated() => $pb.PbList<FinalStanding>();
  @$core.pragma('dart2js:noInline')
  static FinalStanding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinalStanding>(create);
  static FinalStanding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get finalScore => $_getIZ(2);
  @$pb.TagNumber(3)
  set finalScore($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFinalScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinalScore() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get rank => $_getIZ(3);
  @$pb.TagNumber(4)
  set rank($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRank() => $_has(3);
  @$pb.TagNumber(4)
  void clearRank() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get correctAnswers => $_getIZ(4);
  @$pb.TagNumber(5)
  set correctAnswers($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCorrectAnswers() => $_has(4);
  @$pb.TagNumber(5)
  void clearCorrectAnswers() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get avgResponseTimeMs => $_getI64(5);
  @$pb.TagNumber(6)
  set avgResponseTimeMs($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAvgResponseTimeMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvgResponseTimeMs() => clearField(6);
}

class PlayerJoined extends $pb.GeneratedMessage {
  factory PlayerJoined({
    $core.String? userId,
    $core.String? username,
    $core.int? currentPlayerCount,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (currentPlayerCount != null) {
      $result.currentPlayerCount = currentPlayerCount;
    }
    return $result;
  }
  PlayerJoined._() : super();
  factory PlayerJoined.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerJoined.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerJoined', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'currentPlayerCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerJoined clone() => PlayerJoined()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerJoined copyWith(void Function(PlayerJoined) updates) => super.copyWith((message) => updates(message as PlayerJoined)) as PlayerJoined;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerJoined create() => PlayerJoined._();
  PlayerJoined createEmptyInstance() => create();
  static $pb.PbList<PlayerJoined> createRepeated() => $pb.PbList<PlayerJoined>();
  @$core.pragma('dart2js:noInline')
  static PlayerJoined getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerJoined>(create);
  static PlayerJoined? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get currentPlayerCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentPlayerCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentPlayerCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentPlayerCount() => clearField(3);
}

class TimerSync extends $pb.GeneratedMessage {
  factory TimerSync({
    $core.int? round,
    $core.int? remainingSecs,
    $1.Timestamp? serverTime,
  }) {
    final $result = create();
    if (round != null) {
      $result.round = round;
    }
    if (remainingSecs != null) {
      $result.remainingSecs = remainingSecs;
    }
    if (serverTime != null) {
      $result.serverTime = serverTime;
    }
    return $result;
  }
  TimerSync._() : super();
  factory TimerSync.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimerSync.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimerSync', package: const $pb.PackageName(_omitMessageNames ? '' : 'quiz.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'round', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'remainingSecs', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'serverTime', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimerSync clone() => TimerSync()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimerSync copyWith(void Function(TimerSync) updates) => super.copyWith((message) => updates(message as TimerSync)) as TimerSync;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimerSync create() => TimerSync._();
  TimerSync createEmptyInstance() => create();
  static $pb.PbList<TimerSync> createRepeated() => $pb.PbList<TimerSync>();
  @$core.pragma('dart2js:noInline')
  static TimerSync getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimerSync>(create);
  static TimerSync? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get round => $_getIZ(0);
  @$pb.TagNumber(1)
  set round($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRound() => $_has(0);
  @$pb.TagNumber(1)
  void clearRound() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get remainingSecs => $_getIZ(1);
  @$pb.TagNumber(2)
  set remainingSecs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRemainingSecs() => $_has(1);
  @$pb.TagNumber(2)
  void clearRemainingSecs() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get serverTime => $_getN(2);
  @$pb.TagNumber(3)
  set serverTime($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasServerTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerTime() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureServerTime() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
