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
    period: Color(0xFFE53E6B),
    periodContainer: Color(0xFFFFDCE5),
    predictedPeriod: Color(0xFFF49CB6),
    fertile: Color(0xFF2BA98F),
    fertileContainer: Color(0xFFC6EFE5),
    ovulation: Color(0xFF6C5CE7),
    pms: Color(0xFFE08A2E),
  );

  static const dark = CycleColors(
    period: Color(0xFFFF6F92),
    periodContainer: Color(0xFF5C2334),
    predictedPeriod: Color(0xFF8E4A5C),
    fertile: Color(0xFF5BD0B6),
    fertileContainer: Color(0xFF173F37),
    ovulation: Color(0xFF9B8CFF),
    pms: Color(0xFFF0A85A),
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
      fertileContainer: Color.lerp(fertileContainer, other.fertileContainer, t)!,
      ovulation: Color.lerp(ovulation, other.ovulation, t)!,
      pms: Color.lerp(pms, other.pms, t)!,
    );
  }
}

/// Convenient access: `context.cycleColors.period`.
extension CycleColorsX on BuildContext {
  CycleColors get cycleColors => Theme.of(this).extension<CycleColors>()!;
}
