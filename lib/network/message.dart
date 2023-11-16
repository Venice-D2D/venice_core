import 'dart:ffi';
import 'dart:typed_data';

/// This class represents metadata coming with each chunk sent on the network
/// through a channel.
class VeniceMessage {
  final int messageId;

  final bool ack;

  // 2^18 = 256kB according to BitTorrent BEP3 : http://www.bittorrent.org/beps/bep_0003.html
  final int size;

  final List<Uint8> data;

  VeniceMessage(this.messageId, this.ack, this.size, this.data);

  factory VeniceMessage.fromBytes(Uint8List bytes) {
    throw UnimplementedError();
  }

  Uint8List toBytes() {
    throw UnimplementedError();
  }
}
