import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/providers.dart';
import 'onboarding_screen.dart';

/// Shows the onboarding flow until the user completes it, then the app content.
class OnboardingGate extends ConsumerWidget {
  const OnboardingGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return settings.maybeWhen(
      // Onboarding is shown above the router's Navigator (in the MaterialApp
      // builder), so host it in its own Navigator — otherwise its date picker
      // and dialogs have no Navigator ancestor.
      data: (s) => s.onboardingComplete
          ? child
          : Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => const OnboardingScreen(),
              ),
            ),
      orElse: () => child,
    );
  }
}
