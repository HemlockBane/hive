import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/src/backend/storage_backend_memory.dart';
import 'package:hive/src/binary/frame.dart';

import 'common.dart';

void main() {
  group('StorageBackendMemory', () {
    test('.path is null', () {
      var backend = StorageBackendMemory(null, null);
      expect(backend.path, null);
    });

    test('.supportsCompaction is false', () {
      var backend = StorageBackendMemory(null, null);
      expect(backend.supportsCompaction, false);
    });

    group('.initialize()', () {
      test('throws if frames cannot be decoded', () {
        var bytes = Uint8List.fromList([1, 2, 3, 4]);
        var backend = StorageBackendMemory(bytes, null);
        expect(
          () => backend.initialize(null, null),
          throwsHiveError('Wrong checksum'),
        );
      });
    });

    test('.readValue() throws UnsupportedError', () {
      var backend = StorageBackendMemory(null, null);
      expect(
          () => backend.readValue(Frame('key', 'val')), throwsUnsupportedError);
    });

    test('.compact() throws UnsupportedError', () {
      var backend = StorageBackendMemory(null, null);
      expect(() => backend.compact([]), throwsUnsupportedError);
    });

    test('.deleteFromDisk() throws UnsupportedError', () {
      var backend = StorageBackendMemory(null, null);
      expect(() => backend.deleteFromDisk(), throwsUnsupportedError);
    });
  });
}
