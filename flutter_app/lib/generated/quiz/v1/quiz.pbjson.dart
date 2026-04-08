//
//  Generated code. Do not modify.
//  source: quiz/v1/quiz.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use roomRequestDescriptor instead')
const RoomRequest$json = {
  '1': 'RoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `RoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomRequestDescriptor = $convert.base64Decode(
    'CgtSb29tUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use questionsResponseDescriptor instead')
const QuestionsResponse$json = {
  '1': 'QuestionsResponse',
  '2': [
    {'1': 'questions', '3': 1, '4': 3, '5': 11, '6': '.quiz.v1.Question', '10': 'questions'},
  ],
};

/// Descriptor for `QuestionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionsResponseDescriptor = $convert.base64Decode(
    'ChFRdWVzdGlvbnNSZXNwb25zZRIvCglxdWVzdGlvbnMYASADKAsyES5xdWl6LnYxLlF1ZXN0aW'
    '9uUglxdWVzdGlvbnM=');

@$core.Deprecated('Use questionDescriptor instead')
const Question$json = {
  '1': 'Question',
  '2': [
    {'1': 'question_id', '3': 1, '4': 1, '5': 9, '10': 'questionId'},
    {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    {'1': 'options', '3': 3, '4': 3, '5': 9, '10': 'options'},
    {'1': 'difficulty', '3': 4, '4': 1, '5': 9, '10': 'difficulty'},
    {'1': 'topic', '3': 5, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'time_limit_secs', '3': 6, '4': 1, '5': 5, '10': 'timeLimitSecs'},
  ],
};

/// Descriptor for `Question`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionDescriptor = $convert.base64Decode(
    'CghRdWVzdGlvbhIfCgtxdWVzdGlvbl9pZBgBIAEoCVIKcXVlc3Rpb25JZBISCgR0ZXh0GAIgAS'
    'gJUgR0ZXh0EhgKB29wdGlvbnMYAyADKAlSB29wdGlvbnMSHgoKZGlmZmljdWx0eRgEIAEoCVIK'
    'ZGlmZmljdWx0eRIUCgV0b3BpYxgFIAEoCVIFdG9waWMSJgoPdGltZV9saW1pdF9zZWNzGAYgAS'
    'gFUg10aW1lTGltaXRTZWNz');

@$core.Deprecated('Use answerRequestDescriptor instead')
const AnswerRequest$json = {
  '1': 'AnswerRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'question_id', '3': 3, '4': 1, '5': 9, '10': 'questionId'},
    {'1': 'selected_index', '3': 4, '4': 1, '5': 5, '10': 'selectedIndex'},
    {'1': 'response_time_ms', '3': 5, '4': 1, '5': 3, '10': 'responseTimeMs'},
    {'1': 'round', '3': 6, '4': 1, '5': 5, '10': 'round'},
  ],
};

/// Descriptor for `AnswerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List answerRequestDescriptor = $convert.base64Decode(
    'Cg1BbnN3ZXJSZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAIgAS'
    'gJUgZ1c2VySWQSHwoLcXVlc3Rpb25faWQYAyABKAlSCnF1ZXN0aW9uSWQSJQoOc2VsZWN0ZWRf'
    'aW5kZXgYBCABKAVSDXNlbGVjdGVkSW5kZXgSKAoQcmVzcG9uc2VfdGltZV9tcxgFIAEoA1IOcm'
    'VzcG9uc2VUaW1lTXMSFAoFcm91bmQYBiABKAVSBXJvdW5k');

@$core.Deprecated('Use answerAckDescriptor instead')
const AnswerAck$json = {
  '1': 'AnswerAck',
  '2': [
    {'1': 'accepted', '3': 1, '4': 1, '5': 8, '10': 'accepted'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AnswerAck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List answerAckDescriptor = $convert.base64Decode(
    'CglBbnN3ZXJBY2sSGgoIYWNjZXB0ZWQYASABKAhSCGFjY2VwdGVkEhYKBnJlYXNvbhgCIAEoCV'
    'IGcmVhc29u');

@$core.Deprecated('Use streamRequestDescriptor instead')
const StreamRequest$json = {
  '1': 'StreamRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'last_seen_round', '3': 3, '4': 1, '5': 5, '10': 'lastSeenRound'},
  ],
};

/// Descriptor for `StreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamRequestDescriptor = $convert.base64Decode(
    'Cg1TdHJlYW1SZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAIgAS'
    'gJUgZ1c2VySWQSJgoPbGFzdF9zZWVuX3JvdW5kGAMgASgFUg1sYXN0U2VlblJvdW5k');

@$core.Deprecated('Use gameEventDescriptor instead')
const GameEvent$json = {
  '1': 'GameEvent',
  '2': [
    {'1': 'question', '3': 1, '4': 1, '5': 11, '6': '.quiz.v1.QuestionBroadcast', '9': 0, '10': 'question'},
    {'1': 'leaderboard', '3': 2, '4': 1, '5': 11, '6': '.quiz.v1.LeaderboardUpdate', '9': 0, '10': 'leaderboard'},
    {'1': 'round_result', '3': 3, '4': 1, '5': 11, '6': '.quiz.v1.RoundResult', '9': 0, '10': 'roundResult'},
    {'1': 'match_end', '3': 4, '4': 1, '5': 11, '6': '.quiz.v1.MatchEnd', '9': 0, '10': 'matchEnd'},
    {'1': 'player_joined', '3': 5, '4': 1, '5': 11, '6': '.quiz.v1.PlayerJoined', '9': 0, '10': 'playerJoined'},
    {'1': 'timer_sync', '3': 6, '4': 1, '5': 11, '6': '.quiz.v1.TimerSync', '9': 0, '10': 'timerSync'},
  ],
  '8': [
    {'1': 'event'},
  ],
};

/// Descriptor for `GameEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameEventDescriptor = $convert.base64Decode(
    'CglHYW1lRXZlbnQSOAoIcXVlc3Rpb24YASABKAsyGi5xdWl6LnYxLlF1ZXN0aW9uQnJvYWRjYX'
    'N0SABSCHF1ZXN0aW9uEj4KC2xlYWRlcmJvYXJkGAIgASgLMhoucXVpei52MS5MZWFkZXJib2Fy'
    'ZFVwZGF0ZUgAUgtsZWFkZXJib2FyZBI5Cgxyb3VuZF9yZXN1bHQYAyABKAsyFC5xdWl6LnYxLl'
    'JvdW5kUmVzdWx0SABSC3JvdW5kUmVzdWx0EjAKCW1hdGNoX2VuZBgEIAEoCzIRLnF1aXoudjEu'
    'TWF0Y2hFbmRIAFIIbWF0Y2hFbmQSPAoNcGxheWVyX2pvaW5lZBgFIAEoCzIVLnF1aXoudjEuUG'
    'xheWVySm9pbmVkSABSDHBsYXllckpvaW5lZBIzCgp0aW1lcl9zeW5jGAYgASgLMhIucXVpei52'
    'MS5UaW1lclN5bmNIAFIJdGltZXJTeW5jQgcKBWV2ZW50');

@$core.Deprecated('Use questionBroadcastDescriptor instead')
const QuestionBroadcast$json = {
  '1': 'QuestionBroadcast',
  '2': [
    {'1': 'round', '3': 1, '4': 1, '5': 5, '10': 'round'},
    {'1': 'question_id', '3': 2, '4': 1, '5': 9, '10': 'questionId'},
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
    {'1': 'options', '3': 4, '4': 3, '5': 9, '10': 'options'},
    {'1': 'difficulty', '3': 5, '4': 1, '5': 9, '10': 'difficulty'},
    {'1': 'time_limit_secs', '3': 6, '4': 1, '5': 5, '10': 'timeLimitSecs'},
    {'1': 'deadline', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deadline'},
  ],
};

/// Descriptor for `QuestionBroadcast`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionBroadcastDescriptor = $convert.base64Decode(
    'ChFRdWVzdGlvbkJyb2FkY2FzdBIUCgVyb3VuZBgBIAEoBVIFcm91bmQSHwoLcXVlc3Rpb25faW'
    'QYAiABKAlSCnF1ZXN0aW9uSWQSEgoEdGV4dBgDIAEoCVIEdGV4dBIYCgdvcHRpb25zGAQgAygJ'
    'UgdvcHRpb25zEh4KCmRpZmZpY3VsdHkYBSABKAlSCmRpZmZpY3VsdHkSJgoPdGltZV9saW1pdF'
    '9zZWNzGAYgASgFUg10aW1lTGltaXRTZWNzEjYKCGRlYWRsaW5lGAcgASgLMhouZ29vZ2xlLnBy'
    'b3RvYnVmLlRpbWVzdGFtcFIIZGVhZGxpbmU=');

@$core.Deprecated('Use leaderboardUpdateDescriptor instead')
const LeaderboardUpdate$json = {
  '1': 'LeaderboardUpdate',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.quiz.v1.LeaderboardEntry', '10': 'entries'},
    {'1': 'after_round', '3': 2, '4': 1, '5': 5, '10': 'afterRound'},
  ],
};

/// Descriptor for `LeaderboardUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardUpdateDescriptor = $convert.base64Decode(
    'ChFMZWFkZXJib2FyZFVwZGF0ZRIzCgdlbnRyaWVzGAEgAygLMhkucXVpei52MS5MZWFkZXJib2'
    'FyZEVudHJ5UgdlbnRyaWVzEh8KC2FmdGVyX3JvdW5kGAIgASgFUgphZnRlclJvdW5k');

@$core.Deprecated('Use leaderboardEntryDescriptor instead')
const LeaderboardEntry$json = {
  '1': 'LeaderboardEntry',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
    {'1': 'rank', '3': 4, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'rank_change', '3': 5, '4': 1, '5': 5, '10': 'rankChange'},
  ],
};

/// Descriptor for `LeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardEntryDescriptor = $convert.base64Decode(
    'ChBMZWFkZXJib2FyZEVudHJ5EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZR'
    'gCIAEoCVIIdXNlcm5hbWUSFAoFc2NvcmUYAyABKAVSBXNjb3JlEhIKBHJhbmsYBCABKAVSBHJh'
    'bmsSHwoLcmFua19jaGFuZ2UYBSABKAVSCnJhbmtDaGFuZ2U=');

@$core.Deprecated('Use roundResultDescriptor instead')
const RoundResult$json = {
  '1': 'RoundResult',
  '2': [
    {'1': 'round', '3': 1, '4': 1, '5': 5, '10': 'round'},
    {'1': 'correct_option_index', '3': 2, '4': 1, '5': 5, '10': 'correctOptionIndex'},
    {'1': 'player_results', '3': 3, '4': 3, '5': 11, '6': '.quiz.v1.PlayerRoundResult', '10': 'playerResults'},
  ],
};

/// Descriptor for `RoundResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roundResultDescriptor = $convert.base64Decode(
    'CgtSb3VuZFJlc3VsdBIUCgVyb3VuZBgBIAEoBVIFcm91bmQSMAoUY29ycmVjdF9vcHRpb25faW'
    '5kZXgYAiABKAVSEmNvcnJlY3RPcHRpb25JbmRleBJBCg5wbGF5ZXJfcmVzdWx0cxgDIAMoCzIa'
    'LnF1aXoudjEuUGxheWVyUm91bmRSZXN1bHRSDXBsYXllclJlc3VsdHM=');

@$core.Deprecated('Use playerRoundResultDescriptor instead')
const PlayerRoundResult$json = {
  '1': 'PlayerRoundResult',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'correct', '3': 2, '4': 1, '5': 8, '10': 'correct'},
    {'1': 'points_earned', '3': 3, '4': 1, '5': 5, '10': 'pointsEarned'},
    {'1': 'response_time_ms', '3': 4, '4': 1, '5': 3, '10': 'responseTimeMs'},
  ],
};

/// Descriptor for `PlayerRoundResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerRoundResultDescriptor = $convert.base64Decode(
    'ChFQbGF5ZXJSb3VuZFJlc3VsdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGAoHY29ycmVjdB'
    'gCIAEoCFIHY29ycmVjdBIjCg1wb2ludHNfZWFybmVkGAMgASgFUgxwb2ludHNFYXJuZWQSKAoQ'
    'cmVzcG9uc2VfdGltZV9tcxgEIAEoA1IOcmVzcG9uc2VUaW1lTXM=');

@$core.Deprecated('Use matchEndDescriptor instead')
const MatchEnd$json = {
  '1': 'MatchEnd',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'winner_user_id', '3': 2, '4': 1, '5': 9, '10': 'winnerUserId'},
    {'1': 'winner_username', '3': 3, '4': 1, '5': 9, '10': 'winnerUsername'},
    {'1': 'standings', '3': 4, '4': 3, '5': 11, '6': '.quiz.v1.FinalStanding', '10': 'standings'},
  ],
};

/// Descriptor for `MatchEnd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchEndDescriptor = $convert.base64Decode(
    'CghNYXRjaEVuZBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSJAoOd2lubmVyX3VzZXJfaWQYAi'
    'ABKAlSDHdpbm5lclVzZXJJZBInCg93aW5uZXJfdXNlcm5hbWUYAyABKAlSDndpbm5lclVzZXJu'
    'YW1lEjQKCXN0YW5kaW5ncxgEIAMoCzIWLnF1aXoudjEuRmluYWxTdGFuZGluZ1IJc3RhbmRpbm'
    'dz');

@$core.Deprecated('Use finalStandingDescriptor instead')
const FinalStanding$json = {
  '1': 'FinalStanding',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'final_score', '3': 3, '4': 1, '5': 5, '10': 'finalScore'},
    {'1': 'rank', '3': 4, '4': 1, '5': 5, '10': 'rank'},
    {'1': 'correct_answers', '3': 5, '4': 1, '5': 5, '10': 'correctAnswers'},
    {'1': 'avg_response_time_ms', '3': 6, '4': 1, '5': 3, '10': 'avgResponseTimeMs'},
  ],
};

/// Descriptor for `FinalStanding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalStandingDescriptor = $convert.base64Decode(
    'Cg1GaW5hbFN0YW5kaW5nEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgCIA'
    'EoCVIIdXNlcm5hbWUSHwoLZmluYWxfc2NvcmUYAyABKAVSCmZpbmFsU2NvcmUSEgoEcmFuaxgE'
    'IAEoBVIEcmFuaxInCg9jb3JyZWN0X2Fuc3dlcnMYBSABKAVSDmNvcnJlY3RBbnN3ZXJzEi8KFG'
    'F2Z19yZXNwb25zZV90aW1lX21zGAYgASgDUhFhdmdSZXNwb25zZVRpbWVNcw==');

@$core.Deprecated('Use playerJoinedDescriptor instead')
const PlayerJoined$json = {
  '1': 'PlayerJoined',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'current_player_count', '3': 3, '4': 1, '5': 5, '10': 'currentPlayerCount'},
  ],
};

/// Descriptor for `PlayerJoined`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerJoinedDescriptor = $convert.base64Decode(
    'CgxQbGF5ZXJKb2luZWQSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhoKCHVzZXJuYW1lGAIgAS'
    'gJUgh1c2VybmFtZRIwChRjdXJyZW50X3BsYXllcl9jb3VudBgDIAEoBVISY3VycmVudFBsYXll'
    'ckNvdW50');

@$core.Deprecated('Use timerSyncDescriptor instead')
const TimerSync$json = {
  '1': 'TimerSync',
  '2': [
    {'1': 'round', '3': 1, '4': 1, '5': 5, '10': 'round'},
    {'1': 'remaining_secs', '3': 2, '4': 1, '5': 5, '10': 'remainingSecs'},
    {'1': 'server_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'serverTime'},
  ],
};

/// Descriptor for `TimerSync`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timerSyncDescriptor = $convert.base64Decode(
    'CglUaW1lclN5bmMSFAoFcm91bmQYASABKAVSBXJvdW5kEiUKDnJlbWFpbmluZ19zZWNzGAIgAS'
    'gFUg1yZW1haW5pbmdTZWNzEjsKC3NlcnZlcl90aW1lGAMgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIKc2VydmVyVGltZQ==');

