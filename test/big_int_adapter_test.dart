import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/src/adapters/big_int_adapter.dart';
import 'package:hive/src/binary/binary_reader_impl.dart';
import 'package:hive/src/binary/binary_writer_impl.dart';

void main() {
  group('BigIntAdapter', () {
    group('reads', () {
      test('positive BigInts', () {
        var numberStr = '123456789123456789';
        var bytes =
            Uint8List.fromList([numberStr.length, ...numberStr.codeUnits]);
        var reader = BinaryReaderImpl(bytes, null);
        expect(BigIntAdapter().read(reader), BigInt.parse(numberStr));
      });

      test('negative BigInts', () {
        var numberStr = '-123456789123456789';
        var bytes =
            Uint8List.fromList([numberStr.length, ...numberStr.codeUnits]);
        var reader = BinaryReaderImpl(bytes, null);
        expect(BigIntAdapter().read(reader), BigInt.parse(numberStr));
      });
    });

    test('writes BigInts', () {
      var numberStr = '123456789123456789';
      var writer = BinaryWriterImpl(null);
      BigIntAdapter().write(writer, BigInt.parse(numberStr));
      expect(writer.toBytes(), [numberStr.length, ...numberStr.codeUnits]);
    });
  });
}
