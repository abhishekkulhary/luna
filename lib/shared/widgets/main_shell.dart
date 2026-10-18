import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/luna_palette.dart';
import '../../l10n/app_localizations.dart';
import 'luna_ui.dart';

/// The persistent bottom-navigation shell hosting the four primary tabs.
///
/// The night sky is painted once here, behind every tab; the tab screens use
/// transparent scaffolds so it shows through.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Tapping the active tab returns it to its initial route.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final luna = context.luna;
    return Scaffold(
      body: LunaBackground(child: navigationShell),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.alphaBlend(luna.glassStrong, luna.skyDeep),
          border: Border(top: BorderSide(color: luna.glassBorder)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.calendar_today_outlined),
              selectedIcon: const Icon(Icons.calendar_today),
              label: l10n.navCalendar,
            ),
            NavigationDestination(
              icon: const Icon(Icons.insights_outlined),
              selectedIcon: const Icon(Icons.insights),
              label: l10n.navInsights,
            ),
            NavigationDestination(
              icon: const Icon(Icons.notifications_outlined),
              selectedIcon: const Icon(Icons.notifications),
              label: l10n.navReminders,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: l10n.navSettings,
            ),
          ],
        ),
      ),
    );
  }
}
