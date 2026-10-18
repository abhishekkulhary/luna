import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/cycle/cycle_forecast.dart';
import '../../core/cycle/cycle_models.dart';
import '../../core/theme/luna_palette.dart';
import '../../core/utils/date_helpers.dart';

/// A ring of the current cycle, one segment per day, coloured by phase.
/// Days already lived are lit; upcoming days are dimmed; a glowing dot marks
/// today. [child] sits in the centre.
class CycleRing extends StatelessWidget {
  const CycleRing({
    super.key,
    required this.forecast,
    required this.colorFor,
    required this.child,
    this.size = 128,
    this.stroke = 11,
  });

  final CycleForecast forecast;
  final Color Function(CyclePhase phase) colorFor;
  final Widget child;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    final start = forecast.lastPeriodStart!;
    final length = forecast.cycleLength;
    final colors = [
      for (var i = 0; i < length; i++)
        colorFor(forecast.phaseOn(addDays(start, i)) ?? CyclePhase.follicular),
    ];
    // Past the forecast length (late period) the whole ring is lit.
    final day = (forecast.currentCycleDay(today()) ?? 1).clamp(1, length);
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _RingPainter(
          colors: colors,
          todayIndex: day - 1,
          stroke: stroke,
          track: context.luna.glassStrong,
          marker: Theme.of(context).colorScheme.onSurface,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.colors,
    required this.todayIndex,
    required this.stroke,
    required this.track,
    required this.marker,
  });

  final List<Color> colors;
  final int todayIndex;
  final double stroke;
  final Color track;
  final Color marker;

  @override
  void paint(Canvas canvas, Size size) {
    final n = colors.length;
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - stroke / 2 - 4;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweep = 2 * math.pi / n;
    final gap = math.min(sweep * 0.22, 0.05);
    const top = -math.pi / 2;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = track,
    );

    for (var i = 0; i < n; i++) {
      final lit = i <= todayIndex;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = lit ? stroke : stroke * 0.62
        ..strokeCap = StrokeCap.butt
        ..color = colors[i].withValues(alpha: lit ? 1 : 0.55);
      canvas.drawArc(
        rect,
        top + i * sweep + gap / 2,
        sweep - gap,
        false,
        paint,
      );
    }

    // Today: a soft halo plus a bright dot centred on the day's segment.
    final a = top + (todayIndex + 0.5) * sweep;
    final p = center + Offset(math.cos(a), math.sin(a)) * radius;
    final c = colors[todayIndex];
    canvas.drawCircle(
      p,
      stroke * 1.25,
      Paint()
        ..color = c.withValues(alpha: 0.55)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(p, stroke * 0.72, Paint()..color = marker);
    canvas.drawCircle(p, stroke * 0.42, Paint()..color = c);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.todayIndex != todayIndex ||
      old.stroke != stroke ||
      old.track != track ||
      old.marker != marker ||
      !_sameColors(old.colors, colors);

  static bool _sameColors(List<Color> a, List<Color> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
