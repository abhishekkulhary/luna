import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/providers.dart';
import '../../core/models/enums.dart';
import '../../core/security/lock_providers.dart';
import '../../shared/widgets/app_logo.dart';
import '../../shared/widgets/luna_ui.dart';
import 'lock_screen.dart';

/// Wraps the app content and overlays the [LockScreen] whenever a lock is
/// configured and the app is currently locked. Re-locks on backgrounding.
class LockGate extends ConsumerStatefulWidget {
  const LockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<LockGate> createState() => _LockGateState();
}

class _LockGateState extends ConsumerState<LockGate>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      final type = ref.read(settingsProvider).value?.lockType;
      if (type != null && type != AppLockType.none) {
        ref.read(isLockedProvider.notifier).lock();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return settings.when(
      loading: () => const _LockSplash(),
      error: (_, _) => widget.child,
      data: (s) {
        if (s.lockType == AppLockType.none) return widget.child;
        final locked = ref.watch(isLockedProvider);
        if (!locked) return widget.child;
        // Host the lock screen in its own Navigator (it sits above the router's
        // Navigator) so any future dialogs have a Navigator ancestor.
        return Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => LockScreen(lockType: s.lockType),
          ),
        );
      },
    );
  }
}

class _LockSplash extends StatelessWidget {
  const _LockSplash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LunaBackground(child: Center(child: AppLogo(size: 72))),
    );
  }
}
