import 'dart:typed_data';
import 'package:buffer/buffer.dart';

/// This class represents metadata coming with each chunk sent on the network
/// through a channel.
class VeniceMessage {
  final int messageId;

  final bool ack;

  final Uint8List data;

  int get size {
    return data.length;
  }

  VeniceMessage(this.messageId, this.ack, this.data);

  factory VeniceMessage.acknowledgement(int messageId) {
    return VeniceMessage(messageId, true, Uint8List(0));
  }

  factory VeniceMessage.data(int messageId, Uint8List data) {
    return VeniceMessage(messageId, false, data);
  }

  factory VeniceMessage.fromBytes(Uint8List bytes) {
    ByteDataReader reader = ByteDataReader();
    reader.add(bytes);

    int id = reader.readUint32();
    bool ack = reader.readUint8() == 1;
    int size = reader.readUint32();

    return VeniceMessage(id, ack, reader.read(size));
  }

  // 2^18 = 256kB according to BitTorrent BEP3 : http://www.bittorrent.org/beps/bep_0003.html
  Uint8List toBytes() {
    ByteDataWriter writer = ByteDataWriter(bufferLength: 32 + 1 + 32 + size);

    writer.writeUint32(messageId);
    writer.writeUint8(ack ? 1 : 0);
    writer.writeUint32(size);
    writer.write(data);

    return writer.toBytes();
  }
}
