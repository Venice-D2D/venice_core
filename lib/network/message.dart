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
  late final int size;

  final Uint8List data;

  VeniceMessage(this.messageId, this.ack, this.data) {
    size = data.length;
  }

  factory VeniceMessage.acknowledgement(int messageId) {
    return VeniceMessage(messageId, true, Uint8List(0));
  }

  factory VeniceMessage.fromBytes(Uint8List bytes) {
    ByteDataReader reader = ByteDataReader();
    reader.add(bytes);

    int id = reader.readUint32();
    bool ack = reader.readUint8() == 1;
    int size = reader.readUint32();

    return VeniceMessage(id, ack, reader.read(size));
  }

  Uint8List toBytes() {
    ByteDataWriter writer = ByteDataWriter(bufferLength: 32 + 1 + 32 + data.length);

    writer.writeUint32(messageId);
    writer.writeUint8(ack ? 1 : 0);
    writer.writeUint32(size);
    writer.write(data);

    return writer.toBytes();
  }
}
