import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive/src/box/box_base.dart';
import 'package:hive/src/hive_impl.dart';

import '../common.dart';

Future<Box> openBox(bool lazy, [HiveInterface hive]) async {
  hive ??= HiveImpl();
  if (!isBrowser) {
    var dir = await getTempDir();
    hive.init(dir.path);
  }
  var id = Random().nextInt(99999999);
  return await hive.openBox('box$id', lazy: lazy, crashRecovery: false);
}

Future<Box> reopenBox(Box box) async {
  await box.close();
  var hive = (box as BoxBase).hive;
  return await hive.openBox(box.name, lazy: box.lazy, crashRecovery: false);
}

const longTimeout = Timeout(Duration(minutes: 2));
