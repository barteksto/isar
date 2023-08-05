import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_test/log_entity.dart';
import 'package:isar_test/my_app.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final db = await Isar.open(
    [LogEntitySchema],
    directory: dir.path,
    name: 'app_db',
  );

  Logger.root.onRecord.listen(
    (logRecord) {
      db.writeTxn(() async {
        await db.logs.put(LogEntity(message: logRecord.message));
      });

      developer.log(
        logRecord.message,
        time: logRecord.time,
        sequenceNumber: logRecord.sequenceNumber,
        level: logRecord.level.value,
        name: logRecord.loggerName,
        zone: logRecord.zone,
        error: logRecord.error,
        stackTrace: logRecord.stackTrace,
      );
    },
  );

  runApp(const MyApp());
}
