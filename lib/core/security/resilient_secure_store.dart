import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Key/value secret storage that prefers the OS secure store (Keychain /
/// Keystore) and transparently falls back to a file in the app's private,
/// sandboxed support directory when the secure store is unavailable.
///
/// The fallback matters on unsigned desktop builds where the data-protection
/// Keychain requires a development certificate (error -34018). On signed
/// iOS/Android/macOS builds the OS secure store is used and the file is unused.
class ResilientSecureStore {
  ResilientSecureStore._();

  static const _storage = FlutterSecureStorage();
  static const _fileName = 'secure_fallback.json';

  static Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (_) {
      final map = await _readFile();
      return map[key] as String?;
    }
  }

  static Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (_) {
      final map = await _readFile();
      map[key] = value;
      await _writeFile(map);
    }
  }

  static Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (_) {
      // ignore secure-store failures during delete
    }
    try {
      final map = await _readFile();
      if (map.remove(key) != null) await _writeFile(map);
    } catch (_) {
      // ignore file failures during delete
    }
  }

  static Future<File> _file() async {
    final dir = await getApplicationSupportDirectory();
    return File(p.join(dir.path, _fileName));
  }

  static Future<Map<String, dynamic>> _readFile() async {
    try {
      final file = await _file();
      if (!file.existsSync()) return {};
      return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  static Future<void> _writeFile(Map<String, dynamic> map) async {
    final file = await _file();
    await file.writeAsString(jsonEncode(map), flush: true);
  }
}
