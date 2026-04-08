//
//  Generated code. Do not modify.
//  source: matchmaking/v1/matchmaking.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class JoinRequest extends $pb.GeneratedMessage {
  factory JoinRequest({
    $core.String? userId,
    $core.String? username,
    $core.int? rating,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (rating != null) {
      $result.rating = rating;
    }
    return $result;
  }
  JoinRequest._() : super();
  factory JoinRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinRequest clone() => JoinRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinRequest copyWith(void Function(JoinRequest) updates) => super.copyWith((message) => updates(message as JoinRequest)) as JoinRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinRequest create() => JoinRequest._();
  JoinRequest createEmptyInstance() => create();
  static $pb.PbList<JoinRequest> createRepeated() => $pb.PbList<JoinRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinRequest>(create);
  static JoinRequest? _defaultInstance;

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
  $core.int get rating => $_getIZ(2);
  @$pb.TagNumber(3)
  set rating($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRating() => $_has(2);
  @$pb.TagNumber(3)
  void clearRating() => clearField(3);
}

class JoinResponse extends $pb.GeneratedMessage {
  factory JoinResponse({
    $core.String? ticketId,
    $core.int? estimatedWaitSecs,
    $core.int? poolSize,
  }) {
    final $result = create();
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    if (estimatedWaitSecs != null) {
      $result.estimatedWaitSecs = estimatedWaitSecs;
    }
    if (poolSize != null) {
      $result.poolSize = poolSize;
    }
    return $result;
  }
  JoinResponse._() : super();
  factory JoinResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'estimatedWaitSecs', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'poolSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinResponse clone() => JoinResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinResponse copyWith(void Function(JoinResponse) updates) => super.copyWith((message) => updates(message as JoinResponse)) as JoinResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinResponse create() => JoinResponse._();
  JoinResponse createEmptyInstance() => create();
  static $pb.PbList<JoinResponse> createRepeated() => $pb.PbList<JoinResponse>();
  @$core.pragma('dart2js:noInline')
  static JoinResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinResponse>(create);
  static JoinResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get estimatedWaitSecs => $_getIZ(1);
  @$pb.TagNumber(2)
  set estimatedWaitSecs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEstimatedWaitSecs() => $_has(1);
  @$pb.TagNumber(2)
  void clearEstimatedWaitSecs() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get poolSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set poolSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPoolSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPoolSize() => clearField(3);
}

class LeaveRequest extends $pb.GeneratedMessage {
  factory LeaveRequest({
    $core.String? userId,
    $core.String? ticketId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    return $result;
  }
  LeaveRequest._() : super();
  factory LeaveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaveRequest clone() => LeaveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaveRequest copyWith(void Function(LeaveRequest) updates) => super.copyWith((message) => updates(message as LeaveRequest)) as LeaveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveRequest create() => LeaveRequest._();
  LeaveRequest createEmptyInstance() => create();
  static $pb.PbList<LeaveRequest> createRepeated() => $pb.PbList<LeaveRequest>();
  @$core.pragma('dart2js:noInline')
  static LeaveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveRequest>(create);
  static LeaveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticketId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTicketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicketId() => clearField(2);
}

class LeaveResponse extends $pb.GeneratedMessage {
  factory LeaveResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  LeaveResponse._() : super();
  factory LeaveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaveResponse clone() => LeaveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaveResponse copyWith(void Function(LeaveResponse) updates) => super.copyWith((message) => updates(message as LeaveResponse)) as LeaveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveResponse create() => LeaveResponse._();
  LeaveResponse createEmptyInstance() => create();
  static $pb.PbList<LeaveResponse> createRepeated() => $pb.PbList<LeaveResponse>();
  @$core.pragma('dart2js:noInline')
  static LeaveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveResponse>(create);
  static LeaveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class SubscribeRequest extends $pb.GeneratedMessage {
  factory SubscribeRequest({
    $core.String? userId,
    $core.String? ticketId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (ticketId != null) {
      $result.ticketId = ticketId;
    }
    return $result;
  }
  SubscribeRequest._() : super();
  factory SubscribeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeRequest clone() => SubscribeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeRequest copyWith(void Function(SubscribeRequest) updates) => super.copyWith((message) => updates(message as SubscribeRequest)) as SubscribeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeRequest create() => SubscribeRequest._();
  SubscribeRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeRequest> createRepeated() => $pb.PbList<SubscribeRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeRequest>(create);
  static SubscribeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ticketId => $_getSZ(1);
  @$pb.TagNumber(2)
  set ticketId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTicketId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicketId() => clearField(2);
}

enum MatchEvent_Event {
  matchFound, 
  waitUpdate, 
  matchCancelled, 
  notSet
}

class MatchEvent extends $pb.GeneratedMessage {
  factory MatchEvent({
    MatchFound? matchFound,
    WaitUpdate? waitUpdate,
    MatchCancelled? matchCancelled,
  }) {
    final $result = create();
    if (matchFound != null) {
      $result.matchFound = matchFound;
    }
    if (waitUpdate != null) {
      $result.waitUpdate = waitUpdate;
    }
    if (matchCancelled != null) {
      $result.matchCancelled = matchCancelled;
    }
    return $result;
  }
  MatchEvent._() : super();
  factory MatchEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MatchEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, MatchEvent_Event> _MatchEvent_EventByTag = {
    1 : MatchEvent_Event.matchFound,
    2 : MatchEvent_Event.waitUpdate,
    3 : MatchEvent_Event.matchCancelled,
    0 : MatchEvent_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MatchEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<MatchFound>(1, _omitFieldNames ? '' : 'matchFound', subBuilder: MatchFound.create)
    ..aOM<WaitUpdate>(2, _omitFieldNames ? '' : 'waitUpdate', subBuilder: WaitUpdate.create)
    ..aOM<MatchCancelled>(3, _omitFieldNames ? '' : 'matchCancelled', subBuilder: MatchCancelled.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MatchEvent clone() => MatchEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MatchEvent copyWith(void Function(MatchEvent) updates) => super.copyWith((message) => updates(message as MatchEvent)) as MatchEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchEvent create() => MatchEvent._();
  MatchEvent createEmptyInstance() => create();
  static $pb.PbList<MatchEvent> createRepeated() => $pb.PbList<MatchEvent>();
  @$core.pragma('dart2js:noInline')
  static MatchEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MatchEvent>(create);
  static MatchEvent? _defaultInstance;

  MatchEvent_Event whichEvent() => _MatchEvent_EventByTag[$_whichOneof(0)]!;
  void clearEvent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  MatchFound get matchFound => $_getN(0);
  @$pb.TagNumber(1)
  set matchFound(MatchFound v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMatchFound() => $_has(0);
  @$pb.TagNumber(1)
  void clearMatchFound() => clearField(1);
  @$pb.TagNumber(1)
  MatchFound ensureMatchFound() => $_ensure(0);

  @$pb.TagNumber(2)
  WaitUpdate get waitUpdate => $_getN(1);
  @$pb.TagNumber(2)
  set waitUpdate(WaitUpdate v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasWaitUpdate() => $_has(1);
  @$pb.TagNumber(2)
  void clearWaitUpdate() => clearField(2);
  @$pb.TagNumber(2)
  WaitUpdate ensureWaitUpdate() => $_ensure(1);

  @$pb.TagNumber(3)
  MatchCancelled get matchCancelled => $_getN(2);
  @$pb.TagNumber(3)
  set matchCancelled(MatchCancelled v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMatchCancelled() => $_has(2);
  @$pb.TagNumber(3)
  void clearMatchCancelled() => clearField(3);
  @$pb.TagNumber(3)
  MatchCancelled ensureMatchCancelled() => $_ensure(2);
}

class MatchFound extends $pb.GeneratedMessage {
  factory MatchFound({
    $core.String? roomId,
    $core.Iterable<PlayerInfo>? players,
    $core.int? totalRounds,
  }) {
    final $result = create();
    if (roomId != null) {
      $result.roomId = roomId;
    }
    if (players != null) {
      $result.players.addAll(players);
    }
    if (totalRounds != null) {
      $result.totalRounds = totalRounds;
    }
    return $result;
  }
  MatchFound._() : super();
  factory MatchFound.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MatchFound.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MatchFound', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..pc<PlayerInfo>(2, _omitFieldNames ? '' : 'players', $pb.PbFieldType.PM, subBuilder: PlayerInfo.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalRounds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MatchFound clone() => MatchFound()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MatchFound copyWith(void Function(MatchFound) updates) => super.copyWith((message) => updates(message as MatchFound)) as MatchFound;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchFound create() => MatchFound._();
  MatchFound createEmptyInstance() => create();
  static $pb.PbList<MatchFound> createRepeated() => $pb.PbList<MatchFound>();
  @$core.pragma('dart2js:noInline')
  static MatchFound getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MatchFound>(create);
  static MatchFound? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<PlayerInfo> get players => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get totalRounds => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalRounds($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalRounds() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalRounds() => clearField(3);
}

class WaitUpdate extends $pb.GeneratedMessage {
  factory WaitUpdate({
    $core.int? poolSize,
    $core.int? estimatedWaitSecs,
  }) {
    final $result = create();
    if (poolSize != null) {
      $result.poolSize = poolSize;
    }
    if (estimatedWaitSecs != null) {
      $result.estimatedWaitSecs = estimatedWaitSecs;
    }
    return $result;
  }
  WaitUpdate._() : super();
  factory WaitUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WaitUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WaitUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'poolSize', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'estimatedWaitSecs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WaitUpdate clone() => WaitUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WaitUpdate copyWith(void Function(WaitUpdate) updates) => super.copyWith((message) => updates(message as WaitUpdate)) as WaitUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WaitUpdate create() => WaitUpdate._();
  WaitUpdate createEmptyInstance() => create();
  static $pb.PbList<WaitUpdate> createRepeated() => $pb.PbList<WaitUpdate>();
  @$core.pragma('dart2js:noInline')
  static WaitUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WaitUpdate>(create);
  static WaitUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get poolSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set poolSize($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPoolSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPoolSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get estimatedWaitSecs => $_getIZ(1);
  @$pb.TagNumber(2)
  set estimatedWaitSecs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEstimatedWaitSecs() => $_has(1);
  @$pb.TagNumber(2)
  void clearEstimatedWaitSecs() => clearField(2);
}

class MatchCancelled extends $pb.GeneratedMessage {
  factory MatchCancelled({
    $core.String? reason,
  }) {
    final $result = create();
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  MatchCancelled._() : super();
  factory MatchCancelled.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MatchCancelled.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MatchCancelled', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MatchCancelled clone() => MatchCancelled()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MatchCancelled copyWith(void Function(MatchCancelled) updates) => super.copyWith((message) => updates(message as MatchCancelled)) as MatchCancelled;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchCancelled create() => MatchCancelled._();
  MatchCancelled createEmptyInstance() => create();
  static $pb.PbList<MatchCancelled> createRepeated() => $pb.PbList<MatchCancelled>();
  @$core.pragma('dart2js:noInline')
  static MatchCancelled getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MatchCancelled>(create);
  static MatchCancelled? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reason => $_getSZ(0);
  @$pb.TagNumber(1)
  set reason($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => clearField(1);
}

class PlayerInfo extends $pb.GeneratedMessage {
  factory PlayerInfo({
    $core.String? userId,
    $core.String? username,
    $core.int? rating,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (username != null) {
      $result.username = username;
    }
    if (rating != null) {
      $result.rating = rating;
    }
    return $result;
  }
  PlayerInfo._() : super();
  factory PlayerInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'matchmaking.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'rating', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerInfo clone() => PlayerInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerInfo copyWith(void Function(PlayerInfo) updates) => super.copyWith((message) => updates(message as PlayerInfo)) as PlayerInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerInfo create() => PlayerInfo._();
  PlayerInfo createEmptyInstance() => create();
  static $pb.PbList<PlayerInfo> createRepeated() => $pb.PbList<PlayerInfo>();
  @$core.pragma('dart2js:noInline')
  static PlayerInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerInfo>(create);
  static PlayerInfo? _defaultInstance;

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
  $core.int get rating => $_getIZ(2);
  @$pb.TagNumber(3)
  set rating($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRating() => $_has(2);
  @$pb.TagNumber(3)
  void clearRating() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
