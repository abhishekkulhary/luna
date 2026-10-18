import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

/// Wraps local_auth for biometric / device-credential unlock. All calls fail
/// gracefully (return false) where biometrics aren't available.
class BiometricAuth {
  BiometricAuth();

  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isAvailable() async {
    if (kIsWeb) return false;
    try {
      return await _auth.isDeviceSupported() && await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    if (kIsWeb) return false;
    try {
      return await _auth.authenticate(
        localizedReason: 'Unlock Luna to view your cycle data',
        persistAcrossBackgrounding: true,
        biometricOnly: false,
      );
    } catch (_) {
      return false;
    }
  }
}
