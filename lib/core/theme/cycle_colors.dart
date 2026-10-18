import 'package:flutter/material.dart';

/// Semantic colors for the menstrual-cycle phases, exposed as a [ThemeExtension]
/// so calendar, insights and chips share one consistent color language across
/// light and dark themes.
@immutable
class CycleColors extends ThemeExtension<CycleColors> {
  const CycleColors({
    required this.period,
    required this.periodContainer,
    required this.predictedPeriod,
    required this.fertile,
    required this.fertileContainer,
    required this.ovulation,
    required this.pms,
  });

  /// Logged / actual menstruation days.
  final Color period;

  /// Soft fill behind period days.
  final Color periodContainer;

  /// Forecasted (not yet logged) period days.
  final Color predictedPeriod;

  /// Fertile-window days.
  final Color fertile;

  /// Soft fill behind fertile days.
  final Color fertileContainer;

  /// The single predicted ovulation day.
  final Color ovulation;

  /// Pre-menstrual days.
  final Color pms;

  static const light = CycleColors(
    period: Color(0xFFE2457A),
    periodContainer: Color(0xFFFFDDE8),
    predictedPeriod: Color(0xFFEE8FB3),
    fertile: Color(0xFF16A386),
    fertileContainer: Color(0xFFCDF3E9),
    ovulation: Color(0xFF7A5CF0),
    pms: Color(0xFFE5892E),
  );

  static const dark = CycleColors(
    period: Color(0xFFFF6B9D),
    periodContainer: Color(0xFF4A1C37),
    predictedPeriod: Color(0xFFD27AA0),
    fertile: Color(0xFF5EE3C3),
    fertileContainer: Color(0xFF123B39),
    ovulation: Color(0xFFAE8EFF),
    pms: Color(0xFFFFB86B),
  );

  @override
  CycleColors copyWith({
    Color? period,
    Color? periodContainer,
    Color? predictedPeriod,
    Color? fertile,
    Color? fertileContainer,
    Color? ovulation,
    Color? pms,
  }) {
    return CycleColors(
      period: period ?? this.period,
      periodContainer: periodContainer ?? this.periodContainer,
      predictedPeriod: predictedPeriod ?? this.predictedPeriod,
      fertile: fertile ?? this.fertile,
      fertileContainer: fertileContainer ?? this.fertileContainer,
      ovulation: ovulation ?? this.ovulation,
      pms: pms ?? this.pms,
    );
  }

  @override
  CycleColors lerp(ThemeExtension<CycleColors>? other, double t) {
    if (other is! CycleColors) return this;
    return CycleColors(
      period: Color.lerp(period, other.period, t)!,
      periodContainer: Color.lerp(periodContainer, other.periodContainer, t)!,
      predictedPeriod: Color.lerp(predictedPeriod, other.predictedPeriod, t)!,
      fertile: Color.lerp(fertile, other.fertile, t)!,
      fertileContainer: Color.lerp(
        fertileContainer,
        other.fertileContainer,
        t,
      )!,
      ovulation: Color.lerp(ovulation, other.ovulation, t)!,
      pms: Color.lerp(pms, other.pms, t)!,
    );
  }
}

/// Convenient access: `context.cycleColors.period`.
extension CycleColorsX on BuildContext {
  CycleColors get cycleColors => Theme.of(this).extension<CycleColors>()!;
}
