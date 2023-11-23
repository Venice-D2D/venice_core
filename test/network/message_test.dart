import 'dart:convert';
import 'dart:typed_data';
import 'package:buffer/buffer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venice_core/network/message.dart';

void main() {
  group('VeniceMessage', () {
    group('.fromBytes', () {
      test('should build an instance', () {
        int messageId = 15369742;
        bool isAcknowledgement = false;
        int size = 0;

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

        VeniceMessage message = VeniceMessage(messageId, ack, Uint8List(size));
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

    test('should preserve data after serialization + deserialization', () {
      String msg = "Hello there!";
      Uint8List msgBytes = utf8.encode(msg);

      // Serialization + deserialization
      VeniceMessage message = VeniceMessage(42, false, msgBytes);
      Uint8List newBytes = message.toBytes();
      VeniceMessage newMessage = VeniceMessage.fromBytes(newBytes);

      String received = utf8.decode(newMessage.data);
      expect(received, msg);
    });
  });
}