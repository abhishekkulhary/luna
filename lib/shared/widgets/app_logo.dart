import 'package:flutter/material.dart';

/// The app's launcher icon, for in-app branding (About, splash, onboarding).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: Image.asset(
        'assets/icon/icon.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => Icon(
          Icons.nightlight_round,
          size: size * 0.7,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
