/// Web has no filesystem; the caller falls back to clipboard export.
Future<String> saveBackupFile(String fileName, String content) async {
  throw UnsupportedError('File export is unavailable on web.');
}
