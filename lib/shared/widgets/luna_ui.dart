import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/luna_palette.dart';

/// The night-sky backdrop: a vertical sky gradient, two soft glows and a
/// sparse, fixed star field. Painted once and cached behind [child].
class LunaBackground extends StatelessWidget {
  const LunaBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final luna = context.luna;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(child: CustomPaint(painter: _SkyPainter(luna, isDark))),
        child,
      ],
    );
  }
}

class _SkyPainter extends CustomPainter {
  _SkyPainter(this.luna, this.isDark);

  final LunaPalette luna;
  final bool isDark;

  // Fixed seed so the stars never jump between frames or rebuilds.
  static final List<(double, double, double, double)> _stars = () {
    final r = math.Random(7);
    return List.generate(
      70,
      (_) => (
        r.nextDouble(),
        r.nextDouble(),
        0.5 + r.nextDouble() * 1.2,
        0.15 + r.nextDouble() * 0.6,
      ),
    );
  }();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          colors: [luna.sky, luna.skyDeep],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect),
    );

    void glow(Offset center, double radius, Color color, double alpha) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withValues(alpha: alpha),
              color.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }

    final m = math.max(size.width, 420.0);
    glow(
      Offset(size.width * 0.95, size.height * 0.02),
      m * 0.75,
      luna.glowRose,
      isDark ? 0.30 : 0.38,
    );
    glow(
      Offset(size.width * 0.0, size.height * 0.62),
      m * 0.85,
      luna.glowViolet,
      isDark ? 0.26 : 0.30,
    );

    final starPaint = Paint();
    for (final (x, y, r, a) in _stars) {
      starPaint.color = luna.star.withValues(alpha: isDark ? a : a * 0.35);
      canvas.drawCircle(Offset(x * size.width, y * size.height), r, starPaint);
    }
  }

  @override
  bool shouldRepaint(_SkyPainter old) =>
      old.luna != luna || old.isDark != isDark;
}

/// A frosted panel with a hairline border; optionally tinted by [tint] and
/// tappable.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin = EdgeInsets.zero,
    this.tint,
    this.radius = 24,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? tint;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final luna = context.luna;
    final border = BorderRadius.circular(radius);
    return Padding(
      padding: margin,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: luna.glass,
            borderRadius: border,
            border: Border.all(color: luna.glassBorder),
            gradient: tint == null
                ? null
                : LinearGradient(
                    colors: [
                      tint!.withValues(alpha: 0.26),
                      tint!.withValues(alpha: 0.04),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: InkWell(
            borderRadius: border,
            onTap: onTap,
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}

/// Text painted with the rose → lavender accent gradient.
class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, this.style, this.gradient});

  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final g = gradient ?? context.luna.accent;
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => g.createShader(Offset.zero & bounds.size),
      child: Text(text, style: style),
    );
  }
}

/// A glowing gradient pill — the app's primary call to action and FAB.
class GlowButton extends StatelessWidget {
  const GlowButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  /// Stretch to the available width (forms, sheets).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final luna = context.luna;
    final enabled = onPressed != null;
    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: luna.onAccent, size: 20),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: luna.onAccent,
              fontWeight: FontWeight.w800,
              fontSize: 15.5,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ],
    );
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: luna.accent,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: luna.accentStart.withValues(alpha: 0.45),
              blurRadius: 24,
              spreadRadius: -6,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const StadiumBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

/// Small, spaced, uppercase section label.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.padding});

  final String text;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(6, 22, 6, 10),
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.6,
        ),
      ),
    );
  }
}
