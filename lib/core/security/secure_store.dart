import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'resilient_secure_store.dart';

/// Stores the app-lock PIN as a salted SHA-256 hash in the platform secure
/// store (with a sandboxed-file fallback). The raw PIN is never persisted.
class SecureStore {
  const SecureStore();

  static const _pinHashKey = 'app_pin_hash_v1';
  static const _pinSaltKey = 'app_pin_salt_v1';

  Future<bool> hasPin() async =>
      (await ResilientSecureStore.read(_pinHashKey)) != null;

  Future<void> setPin(String pin) async {
    final salt = _randomSalt();
    await ResilientSecureStore.write(_pinSaltKey, salt);
    await ResilientSecureStore.write(_pinHashKey, _hash(pin, salt));
  }

  Future<bool> verifyPin(String pin) async {
    final salt = await ResilientSecureStore.read(_pinSaltKey);
    final hash = await ResilientSecureStore.read(_pinHashKey);
    if (salt == null || hash == null) return false;
    return _constantTimeEquals(_hash(pin, salt), hash);
  }

  Future<void> clearPin() async {
    await ResilientSecureStore.delete(_pinHashKey);
    await ResilientSecureStore.delete(_pinSaltKey);
  }

  String _hash(String pin, String salt) =>
      sha256.convert(utf8.encode('$salt::$pin')).toString();

  String _randomSalt() {
    final rng = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => rng.nextInt(256)));
  }

  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
