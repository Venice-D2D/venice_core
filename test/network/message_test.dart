import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:venice_core/network/message.dart';

void main() {
  group('VeniceMessage', () {
    group('.fromBytes', () {
      test('should build an instance', () {
        int messageId = 42;
        Uint8List rawData = Uint8List.fromList([messageId.toUnsigned(32), 0x01, 0x00]);
        VeniceMessage message = VeniceMessage.fromBytes(rawData);
        expect(message.messageId, messageId);
      });
    });
  });
}