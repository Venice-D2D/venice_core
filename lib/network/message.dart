import 'dart:ffi';

/// This class represents metadata coming with each chunk sent on the network
/// through a channel.
class VeniceMessage {
  final Uint32 messageId;

  final bool ack;

  // 2^18 = 256kB according to BitTorrent BEP3 : http://www.bittorrent.org/beps/bep_0003.html
  final Uint32 size;

  final List<Uint8> data;

  VeniceMessage(this.messageId, this.ack, this.size, this.data);

  factory VeniceMessage.fromBytes(List<Uint8> bytes) {
    throw UnimplementedError();
  }

  List<Uint8> toBytes() {
    throw UnimplementedError();
  }
}
