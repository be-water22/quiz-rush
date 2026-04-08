//
//  Generated code. Do not modify.
//  source: scoring/v1/scoring.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use scoreRequestDescriptor instead')
const ScoreRequest$json = {
  '1': 'ScoreRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'question_id', '3': 3, '4': 1, '5': 9, '10': 'questionId'},
    {'1': 'round', '3': 4, '4': 1, '5': 5, '10': 'round'},
    {'1': 'correct', '3': 5, '4': 1, '5': 8, '10': 'correct'},
    {'1': 'response_time_ms', '3': 6, '4': 1, '5': 3, '10': 'responseTimeMs'},
    {'1': 'difficulty', '3': 7, '4': 1, '5': 9, '10': 'difficulty'},
    {'1': 'time_limit_ms', '3': 8, '4': 1, '5': 5, '10': 'timeLimitMs'},
  ],
};

/// Descriptor for `ScoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreRequestDescriptor = $convert.base64Decode(
    'CgxTY29yZVJlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEhcKB3VzZXJfaWQYAiABKA'
    'lSBnVzZXJJZBIfCgtxdWVzdGlvbl9pZBgDIAEoCVIKcXVlc3Rpb25JZBIUCgVyb3VuZBgEIAEo'
    'BVIFcm91bmQSGAoHY29ycmVjdBgFIAEoCFIHY29ycmVjdBIoChByZXNwb25zZV90aW1lX21zGA'
    'YgASgDUg5yZXNwb25zZVRpbWVNcxIeCgpkaWZmaWN1bHR5GAcgASgJUgpkaWZmaWN1bHR5EiIK'
    'DXRpbWVfbGltaXRfbXMYCCABKAVSC3RpbWVMaW1pdE1z');

@$core.Deprecated('Use scoreResponseDescriptor instead')
const ScoreResponse$json = {
  '1': 'ScoreResponse',
  '2': [
    {'1': 'points_awarded', '3': 1, '4': 1, '5': 5, '10': 'pointsAwarded'},
    {'1': 'total_score', '3': 2, '4': 1, '5': 5, '10': 'totalScore'},
    {'1': 'new_rank', '3': 3, '4': 1, '5': 5, '10': 'newRank'},
  ],
};

/// Descriptor for `ScoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreResponseDescriptor = $convert.base64Decode(
    'Cg1TY29yZVJlc3BvbnNlEiUKDnBvaW50c19hd2FyZGVkGAEgASgFUg1wb2ludHNBd2FyZGVkEh'
    '8KC3RvdGFsX3Njb3JlGAIgASgFUgp0b3RhbFNjb3JlEhkKCG5ld19yYW5rGAMgASgFUgduZXdS'
    'YW5r');

@$core.Deprecated('Use leaderboardRequestDescriptor instead')
const LeaderboardRequest$json = {
  '1': 'LeaderboardRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `LeaderboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardRequestDescriptor = $convert.base64Decode(
    'ChJMZWFkZXJib2FyZFJlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlk');

@$core.Deprecated('Use leaderboardResponseDescriptor instead')
const LeaderboardResponse$json = {
  '1': 'LeaderboardResponse',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.scoring.v1.LeaderboardEntry', '10': 'entries'},
  ],
};

/// Descriptor for `LeaderboardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardResponseDescriptor = $convert.base64Decode(
    'ChNMZWFkZXJib2FyZFJlc3BvbnNlEjYKB2VudHJpZXMYASADKAsyHC5zY29yaW5nLnYxLkxlYW'
    'RlcmJvYXJkRW50cnlSB2VudHJpZXM=');

@$core.Deprecated('Use leaderboardEntryDescriptor instead')
const LeaderboardEntry$json = {
  '1': 'LeaderboardEntry',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
    {'1': 'rank', '3': 4, '4': 1, '5': 5, '10': 'rank'},
  ],
};

/// Descriptor for `LeaderboardEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaderboardEntryDescriptor = $convert.base64Decode(
    'ChBMZWFkZXJib2FyZEVudHJ5EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZR'
    'gCIAEoCVIIdXNlcm5hbWUSFAoFc2NvcmUYAyABKAVSBXNjb3JlEhIKBHJhbmsYBCABKAVSBHJh'
    'bms=');

