import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venice_core/network/message.dart';

void main() {
  group('VeniceMessage', () {
    group('.fromBytes', () {
      test('should build an instance', () {
        int messageId = 15369742;
        bool isAcknowledgement = false;
        int size = 256;

        ByteDataWriter writer = ByteDataWriter(bufferLength: 32 + 1 + 32);
        writer.writeUint32(messageId);
        writer.writeUint8(isAcknowledgement ? 1 : 0);
        writer.writeUint32(size);

        VeniceMessage message = VeniceMessage.fromBytes(writer.toBytes());
        expect(message.messageId, messageId);
        expect(message.ack, isAcknowledgement);
        expect(message.size, size);
      });
    });

    group('.toBytes', () {
      test('should return an array of bytes', () {
        int messageId = 42;
        bool ack = false;
        int size = 0;

        VeniceMessage message = VeniceMessage(messageId, ack, size, Uint8List(0));
        Uint8List bytes = message.toBytes();

        ByteDataReader reader = ByteDataReader();
        reader.add(bytes);
        int mId = reader.readUint32();
        expect(mId, messageId);
        bool mAck = reader.readUint8() == 1;
        expect(mAck, ack);
        int mSize = reader.readUint32();
        expect(mSize, size);
      });
    });
  });
}