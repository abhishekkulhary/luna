import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/enums.dart';
import '../../core/security/lock_providers.dart';
import '../../l10n/app_localizations.dart';
import 'pin_pad.dart';

/// Full-screen gate shown when the app is locked. Offers PIN entry and, when
/// configured, biometric unlock.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key, required this.lockType});

  final AppLockType lockType;

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.lockType == AppLockType.biometric) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
    }
  }

  Future<void> _tryBiometric() async {
    final ok = await ref.read(biometricAuthProvider).authenticate();
    if (ok) _unlock();
  }

  void _unlock() => ref.read(isLockedProvider.notifier).unlock();

  @override
  Widget build(BuildContext context) {
    final showBiometric = widget.lockType == AppLockType.biometric;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline,
                  size: 48, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              PinPad(
                title: l10n.enterPin,
                subtitle: l10n.dataLocked,
                onBiometric: showBiometric ? _tryBiometric : null,
                onSubmit: (pin) async {
                  final ok = await ref.read(secureStoreProvider).verifyPin(pin);
                  if (ok) _unlock();
                  return ok;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
