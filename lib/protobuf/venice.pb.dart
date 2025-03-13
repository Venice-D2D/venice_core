//
//  Generated code. Do not modify.
//  source: venice.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class VeniceMessageProto extends $pb.GeneratedMessage {
  factory VeniceMessageProto({
    $core.int? messageId,
    $core.bool? ack,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (messageId != null) {
      $result.messageId = messageId;
    }
    if (ack != null) {
      $result.ack = ack;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  VeniceMessageProto._() : super();
  factory VeniceMessageProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VeniceMessageProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VeniceMessageProto', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'messageId', $pb.PbFieldType.O3, protoName: 'messageId')
    ..aOB(2, _omitFieldNames ? '' : 'ack')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VeniceMessageProto clone() => VeniceMessageProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VeniceMessageProto copyWith(void Function(VeniceMessageProto) updates) => super.copyWith((message) => updates(message as VeniceMessageProto)) as VeniceMessageProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VeniceMessageProto create() => VeniceMessageProto._();
  VeniceMessageProto createEmptyInstance() => create();
  static $pb.PbList<VeniceMessageProto> createRepeated() => $pb.PbList<VeniceMessageProto>();
  @$core.pragma('dart2js:noInline')
  static VeniceMessageProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VeniceMessageProto>(create);
  static VeniceMessageProto? _defaultInstance;

  /// The message identifier
  @$pb.TagNumber(1)
  $core.int get messageId => $_getIZ(0);
  @$pb.TagNumber(1)
  set messageId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => clearField(1);

  /// Indicates if it is an acknowledgment message
  @$pb.TagNumber(2)
  $core.bool get ack => $_getBF(1);
  @$pb.TagNumber(2)
  set ack($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAck() => $_has(1);
  @$pb.TagNumber(2)
  void clearAck() => clearField(2);

  /// The message data
  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
