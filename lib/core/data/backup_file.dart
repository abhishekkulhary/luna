// Writes the backup file to a user-retrievable location. The dart:io
// implementation is used on mobile/desktop; on web (no filesystem) the stub
// throws so the caller can fall back to clipboard export.
export 'backup_file_io.dart' if (dart.library.js_interop) 'backup_file_web.dart';
