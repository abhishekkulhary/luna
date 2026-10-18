import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/security/lock_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/luna_ui.dart';
import 'pin_pad.dart';

/// Runs the create-and-confirm PIN flow. Returns true if a PIN was set.
Future<bool> showPinSetup(BuildContext context) async {
  final result = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const _PinSetupScreen(),
    ),
  );
  return result ?? false;
}

class _PinSetupScreen extends ConsumerStatefulWidget {
  const _PinSetupScreen();

  @override
  ConsumerState<_PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<_PinSetupScreen> {
  String? _first;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(leading: const CloseButton(), title: Text(l10n.setAppPin)),
      body: LunaBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: PinPad(
              key: ValueKey(_first == null ? 'create' : 'confirm'),
              title: _first == null ? l10n.createPin : l10n.confirmPin,
              subtitle: _first == null ? l10n.choosePinHint : l10n.reenterPin,
              onSubmit: (pin) async {
                if (_first == null) {
                  setState(() => _first = pin);
                  return true;
                }
                if (pin == _first) {
                  final navigator = Navigator.of(context);
                  await ref.read(secureStoreProvider).setPin(pin);
                  if (mounted) navigator.pop(true);
                  return true;
                }
                setState(() => _first = null); // mismatch: start over
                return false;
              },
            ),
          ),
        ),
      ),
    );
  }
}
