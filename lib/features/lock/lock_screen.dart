import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/enums.dart';
import '../../core/security/lock_providers.dart';
import '../../core/theme/luna_palette.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/luna_ui.dart';
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
    final luna = context.luna;
    return Scaffold(
      body: LunaBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: luna.accent,
                    boxShadow: [
                      BoxShadow(
                        color: luna.accentStart.withValues(alpha: 0.5),
                        blurRadius: 30,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 34,
                    color: luna.onAccent,
                  ),
                ),
                const SizedBox(height: 28),
                PinPad(
                  title: l10n.enterPin,
                  subtitle: l10n.dataLocked,
                  onBiometric: showBiometric ? _tryBiometric : null,
                  onSubmit: (pin) async {
                    final ok = await ref
                        .read(secureStoreProvider)
                        .verifyPin(pin);
                    if (ok) _unlock();
                    return ok;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
