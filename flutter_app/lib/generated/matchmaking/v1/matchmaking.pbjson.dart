//
//  Generated code. Do not modify.
//  source: matchmaking/v1/matchmaking.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use joinRequestDescriptor instead')
const JoinRequest$json = {
  '1': 'JoinRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'rating', '3': 3, '4': 1, '5': 5, '10': 'rating'},
  ],
};

/// Descriptor for `JoinRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRequestDescriptor = $convert.base64Decode(
    'CgtKb2luUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGgoIdXNlcm5hbWUYAiABKA'
    'lSCHVzZXJuYW1lEhYKBnJhdGluZxgDIAEoBVIGcmF0aW5n');

@$core.Deprecated('Use joinResponseDescriptor instead')
const JoinResponse$json = {
  '1': 'JoinResponse',
  '2': [
    {'1': 'ticket_id', '3': 1, '4': 1, '5': 9, '10': 'ticketId'},
    {'1': 'estimated_wait_secs', '3': 2, '4': 1, '5': 5, '10': 'estimatedWaitSecs'},
    {'1': 'pool_size', '3': 3, '4': 1, '5': 5, '10': 'poolSize'},
  ],
};

/// Descriptor for `JoinResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinResponseDescriptor = $convert.base64Decode(
    'CgxKb2luUmVzcG9uc2USGwoJdGlja2V0X2lkGAEgASgJUgh0aWNrZXRJZBIuChNlc3RpbWF0ZW'
    'Rfd2FpdF9zZWNzGAIgASgFUhFlc3RpbWF0ZWRXYWl0U2VjcxIbCglwb29sX3NpemUYAyABKAVS'
    'CHBvb2xTaXpl');

@$core.Deprecated('Use leaveRequestDescriptor instead')
const LeaveRequest$json = {
  '1': 'LeaveRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'ticket_id', '3': 2, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `LeaveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveRequestDescriptor = $convert.base64Decode(
    'CgxMZWF2ZVJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhsKCXRpY2tldF9pZBgCIA'
    'EoCVIIdGlja2V0SWQ=');

@$core.Deprecated('Use leaveResponseDescriptor instead')
const LeaveResponse$json = {
  '1': 'LeaveResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `LeaveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveResponseDescriptor = $convert.base64Decode(
    'Cg1MZWF2ZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use subscribeRequestDescriptor instead')
const SubscribeRequest$json = {
  '1': 'SubscribeRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'ticket_id', '3': 2, '4': 1, '5': 9, '10': 'ticketId'},
  ],
};

/// Descriptor for `SubscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeRequestDescriptor = $convert.base64Decode(
    'ChBTdWJzY3JpYmVSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgl0aWNrZXRfaW'
    'QYAiABKAlSCHRpY2tldElk');

@$core.Deprecated('Use matchEventDescriptor instead')
const MatchEvent$json = {
  '1': 'MatchEvent',
  '2': [
    {'1': 'match_found', '3': 1, '4': 1, '5': 11, '6': '.matchmaking.v1.MatchFound', '9': 0, '10': 'matchFound'},
    {'1': 'wait_update', '3': 2, '4': 1, '5': 11, '6': '.matchmaking.v1.WaitUpdate', '9': 0, '10': 'waitUpdate'},
    {'1': 'match_cancelled', '3': 3, '4': 1, '5': 11, '6': '.matchmaking.v1.MatchCancelled', '9': 0, '10': 'matchCancelled'},
  ],
  '8': [
    {'1': 'event'},
  ],
};

/// Descriptor for `MatchEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchEventDescriptor = $convert.base64Decode(
    'CgpNYXRjaEV2ZW50Ej0KC21hdGNoX2ZvdW5kGAEgASgLMhoubWF0Y2htYWtpbmcudjEuTWF0Y2'
    'hGb3VuZEgAUgptYXRjaEZvdW5kEj0KC3dhaXRfdXBkYXRlGAIgASgLMhoubWF0Y2htYWtpbmcu'
    'djEuV2FpdFVwZGF0ZUgAUgp3YWl0VXBkYXRlEkkKD21hdGNoX2NhbmNlbGxlZBgDIAEoCzIeLm'
    '1hdGNobWFraW5nLnYxLk1hdGNoQ2FuY2VsbGVkSABSDm1hdGNoQ2FuY2VsbGVkQgcKBWV2ZW50');

@$core.Deprecated('Use matchFoundDescriptor instead')
const MatchFound$json = {
  '1': 'MatchFound',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'players', '3': 2, '4': 3, '5': 11, '6': '.matchmaking.v1.PlayerInfo', '10': 'players'},
    {'1': 'total_rounds', '3': 3, '4': 1, '5': 5, '10': 'totalRounds'},
  ],
};

/// Descriptor for `MatchFound`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchFoundDescriptor = $convert.base64Decode(
    'CgpNYXRjaEZvdW5kEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBI0CgdwbGF5ZXJzGAIgAygLMh'
    'oubWF0Y2htYWtpbmcudjEuUGxheWVySW5mb1IHcGxheWVycxIhCgx0b3RhbF9yb3VuZHMYAyAB'
    'KAVSC3RvdGFsUm91bmRz');

@$core.Deprecated('Use waitUpdateDescriptor instead')
const WaitUpdate$json = {
  '1': 'WaitUpdate',
  '2': [
    {'1': 'pool_size', '3': 1, '4': 1, '5': 5, '10': 'poolSize'},
    {'1': 'estimated_wait_secs', '3': 2, '4': 1, '5': 5, '10': 'estimatedWaitSecs'},
  ],
};

/// Descriptor for `WaitUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List waitUpdateDescriptor = $convert.base64Decode(
    'CgpXYWl0VXBkYXRlEhsKCXBvb2xfc2l6ZRgBIAEoBVIIcG9vbFNpemUSLgoTZXN0aW1hdGVkX3'
    'dhaXRfc2VjcxgCIAEoBVIRZXN0aW1hdGVkV2FpdFNlY3M=');

@$core.Deprecated('Use matchCancelledDescriptor instead')
const MatchCancelled$json = {
  '1': 'MatchCancelled',
  '2': [
    {'1': 'reason', '3': 1, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `MatchCancelled`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchCancelledDescriptor = $convert.base64Decode(
    'Cg5NYXRjaENhbmNlbGxlZBIWCgZyZWFzb24YASABKAlSBnJlYXNvbg==');

@$core.Deprecated('Use playerInfoDescriptor instead')
const PlayerInfo$json = {
  '1': 'PlayerInfo',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'rating', '3': 3, '4': 1, '5': 5, '10': 'rating'},
  ],
};

/// Descriptor for `PlayerInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerInfoDescriptor = $convert.base64Decode(
    'CgpQbGF5ZXJJbmZvEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIaCgh1c2VybmFtZRgCIAEoCV'
    'IIdXNlcm5hbWUSFgoGcmF0aW5nGAMgASgFUgZyYXRpbmc=');

