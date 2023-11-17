import 'dart:ffi';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:flutter/material.dart';

/// This class represents metadata coming with each chunk sent on the network
/// through a channel.
class VeniceMessage {
  final int messageId;

  final bool ack;

  // 2^18 = 256kB according to BitTorrent BEP3 : http://www.bittorrent.org/beps/bep_0003.html
  final int size;

  final Uint8List data;

  VeniceMessage(this.messageId, this.ack, this.size, this.data);

  factory VeniceMessage.acknowledgement(int messageId) {
    return VeniceMessage(messageId, true, 0, Uint8List(0));
  }

  factory VeniceMessage.fromBytes(Uint8List bytes) {
    ByteDataReader reader = ByteDataReader();
    reader.add(bytes);

    int id = reader.readUint32();
    bool ack = reader.readUint8() == 1;
    int size = reader.readUint32();

    return VeniceMessage(id, ack, size, Uint8List(0));
  }

  Uint8List toBytes() {
    throw UnimplementedError();
  }
}
