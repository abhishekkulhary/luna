import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'biometric_auth.dart';
import 'secure_store.dart';

final secureStoreProvider = Provider<SecureStore>((ref) => const SecureStore());

final biometricAuthProvider = Provider<BiometricAuth>((ref) => BiometricAuth());

/// Whether the app is currently locked. Starts locked; the lock gate clears it
/// after a successful unlock, and re-sets it when the app is backgrounded.
class LockNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void lock() => state = true;
  void unlock() => state = false;
}

final isLockedProvider =
    NotifierProvider<LockNotifier, bool>(LockNotifier.new);

/// Whether biometric unlock is available on this device.
final biometricAvailableProvider = FutureProvider<bool>(
  (ref) => ref.watch(biometricAuthProvider).isAvailable(),
);
