import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database_key.dart';

/// Opens the encrypted local database on mobile/desktop.
///
/// The native library is the SQLite3 Multiple Ciphers build (selected via the
/// `hooks.user_defines` in pubspec.yaml). `PRAGMA key` encrypts the database at
/// rest with a random 256-bit key kept in the platform secure store. The file
/// also lives in the app's private, OS-sandboxed documents directory.
QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'period_tracker.sqlite'));
    final key = await DatabaseKey.getOrCreate();
    final escapedKey = key.replaceAll("'", "''");

    return NativeDatabase.createInBackground(
      file,
      setup: (raw) {
        // Unlock/encrypt the database before any other statement runs.
        raw.execute("PRAGMA key = '$escapedKey';");
        raw.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}
