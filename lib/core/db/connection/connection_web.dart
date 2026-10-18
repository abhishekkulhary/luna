import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Opens a WASM-backed SQLite database on web.
///
/// Web has no SQLCipher backend, so at-rest encryption is not applied here;
/// data lives in browser-sandboxed (origin-isolated) storage. Requires
/// `web/sqlite3.wasm` and `web/drift_worker.js` to be present.
QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'period_tracker',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return result.resolvedExecutor;
  });
}
