//
//  Generated code. Do not modify.
//  source: scoring/v1/scoring.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ScoreRequest extends $pb.GeneratedMessage {
  factory ScoreRequest({
    $core.String? roomId,
    $core.String? userId,
    $core.String? questionId,
    $core.int? round,
    $core.bool? correct,
    $fixnum.Int64? responseTimeMs,
    $core.String? difficulty,
    $core.int? timeLimitMs,
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
    if (round != null) {
      $result.round = round;
    }
    if (correct != null) {
      $result.correct = correct;
    }
    if (responseTimeMs != null) {
      $result.responseTimeMs = responseTimeMs;
    }
    if (difficulty != null) {
      $result.difficulty = difficulty;
    }
    if (timeLimitMs != null) {
      $result.timeLimitMs = timeLimitMs;
    }
    return $result;
  }
  ScoreRequest._() : super();
  factory ScoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScoreRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'scoring.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'questionId')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'round', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'correct')
    ..aInt64(6, _omitFieldNames ? '' : 'responseTimeMs')
    ..aOS(7, _omitFieldNames ? '' : 'difficulty')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'timeLimitMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScoreRequest clone() => ScoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScoreRequest copyWith(void Function(ScoreRequest) updates) => super.copyWith((message) => updates(message as ScoreRequest)) as ScoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScoreRequest create() => ScoreRequest._();
  ScoreRequest createEmptyInstance() => create();
  static $pb.PbList<ScoreRequest> createRepeated() => $pb.PbList<ScoreRequest>();
  @$core.pragma('dart2js:noInline')
  static ScoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScoreRequest>(create);
  static ScoreRequest? _defaultInstance;

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
  $core.int get round => $_getIZ(3);
  @$pb.TagNumber(4)
  set round($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRound() => $_has(3);
  @$pb.TagNumber(4)
  void clearRound() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get correct => $_getBF(4);
  @$pb.TagNumber(5)
  set correct($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCorrect() => $_has(4);
  @$pb.TagNumber(5)
  void clearCorrect() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get responseTimeMs => $_getI64(5);
  @$pb.TagNumber(6)
  set responseTimeMs($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasResponseTimeMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponseTimeMs() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get difficulty => $_getSZ(6);
  @$pb.TagNumber(7)
  set difficulty($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDifficulty() => $_has(6);
  @$pb.TagNumber(7)
  void clearDifficulty() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get timeLimitMs => $_getIZ(7);
  @$pb.TagNumber(8)
  set timeLimitMs($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTimeLimitMs() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimeLimitMs() => clearField(8);
}

class ScoreResponse extends $pb.GeneratedMessage {
  factory ScoreResponse({
    $core.int? pointsAwarded,
    $core.int? totalScore,
    $core.int? newRank,
  }) {
    final $result = create();
    if (pointsAwarded != null) {
      $result.pointsAwarded = pointsAwarded;
    }
    if (totalScore != null) {
      $result.totalScore = totalScore;
    }
    if (newRank != null) {
      $result.newRank = newRank;
    }
    return $result;
  }
  ScoreResponse._() : super();
  factory ScoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScoreResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'scoring.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pointsAwarded', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalScore', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'newRank', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScoreResponse clone() => ScoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScoreResponse copyWith(void Function(ScoreResponse) updates) => super.copyWith((message) => updates(message as ScoreResponse)) as ScoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScoreResponse create() => ScoreResponse._();
  ScoreResponse createEmptyInstance() => create();
  static $pb.PbList<ScoreResponse> createRepeated() => $pb.PbList<ScoreResponse>();
  @$core.pragma('dart2js:noInline')
  static ScoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScoreResponse>(create);
  static ScoreResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pointsAwarded => $_getIZ(0);
  @$pb.TagNumber(1)
  set pointsAwarded($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPointsAwarded() => $_has(0);
  @$pb.TagNumber(1)
  void clearPointsAwarded() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalScore => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalScore($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalScore() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get newRank => $_getIZ(2);
  @$pb.TagNumber(3)
  set newRank($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewRank() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewRank() => clearField(3);
}

class LeaderboardRequest extends $pb.GeneratedMessage {
  factory LeaderboardRequest({
    $core.String? roomId,
  }) {
    final $result = create();
    if (roomId != null) {
      $result.roomId = roomId;
    }
    return $result;
  }
  LeaderboardRequest._() : super();
  factory LeaderboardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'scoring.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardRequest clone() => LeaderboardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardRequest copyWith(void Function(LeaderboardRequest) updates) => super.copyWith((message) => updates(message as LeaderboardRequest)) as LeaderboardRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardRequest create() => LeaderboardRequest._();
  LeaderboardRequest createEmptyInstance() => create();
  static $pb.PbList<LeaderboardRequest> createRepeated() => $pb.PbList<LeaderboardRequest>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaderboardRequest>(create);
  static LeaderboardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

class LeaderboardResponse extends $pb.GeneratedMessage {
  factory LeaderboardResponse({
    $core.Iterable<LeaderboardEntry>? entries,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    return $result;
  }
  LeaderboardResponse._() : super();
  factory LeaderboardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'scoring.v1'), createEmptyInstance: create)
    ..pc<LeaderboardEntry>(1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: LeaderboardEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaderboardResponse clone() => LeaderboardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaderboardResponse copyWith(void Function(LeaderboardResponse) updates) => super.copyWith((message) => updates(message as LeaderboardResponse)) as LeaderboardResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaderboardResponse create() => LeaderboardResponse._();
  LeaderboardResponse createEmptyInstance() => create();
  static $pb.PbList<LeaderboardResponse> createRepeated() => $pb.PbList<LeaderboardResponse>();
  @$core.pragma('dart2js:noInline')
  static LeaderboardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaderboardResponse>(create);
  static LeaderboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LeaderboardEntry> get entries => $_getList(0);
}

class LeaderboardEntry extends $pb.GeneratedMessage {
  factory LeaderboardEntry({
    $core.String? userId,
    $core.String? username,
    $core.int? score,
    $core.int? rank,
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
    return $result;
  }
  LeaderboardEntry._() : super();
  factory LeaderboardEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaderboardEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaderboardEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'scoring.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'score', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.O3)
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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
