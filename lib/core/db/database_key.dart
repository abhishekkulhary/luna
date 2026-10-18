import 'dart:convert';
import 'dart:math';

import '../security/resilient_secure_store.dart';

/// Generates and persists the database encryption key in the platform secure
/// store (falling back to a sandboxed file where the Keychain is unavailable,
/// e.g. unsigned desktop builds). The key never leaves the device.
class DatabaseKey {
  DatabaseKey._();

  static const _keyName = 'db_cipher_key_v1';

  /// Returns the existing key, creating a random 256-bit key on first run.
  static Future<String> getOrCreate() async {
    final existing = await ResilientSecureStore.read(_keyName);
    if (existing != null && existing.isNotEmpty) return existing;

    final rng = Random.secure();
    final bytes = List<int>.generate(32, (_) => rng.nextInt(256));
    final key = base64UrlEncode(bytes);
    await ResilientSecureStore.write(_keyName, key);
    return key;
  }
}
