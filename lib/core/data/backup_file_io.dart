import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

const _channel = MethodChannel('luna/backup');

/// Writes [content] and returns a human-readable location.
///
/// On Android it saves into the public **Downloads** folder via MediaStore (no
/// permission needed), so it's easy to find in any file manager. On other
/// platforms (or if that fails) it writes to `<documents>/LunaBackups/`.
Future<String> saveBackupFile(String fileName, String content) async {
  if (Platform.isAndroid) {
    try {
      final saved = await _channel.invokeMethod<String>('saveToDownloads', {
        'fileName': fileName,
        'content': content,
      });
      if (saved != null) return saved;
    } catch (_) {
      // Fall through to the documents-dir path below.
    }
  }

  final dir = await getApplicationDocumentsDirectory();
  final folder = Directory('${dir.path}/LunaBackups');
  if (!await folder.exists()) await folder.create(recursive: true);
  final file = File('${folder.path}/$fileName');
  await file.writeAsString(content, flush: true);
  return file.path;
}
