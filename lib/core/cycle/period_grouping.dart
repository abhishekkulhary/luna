import '../utils/date_helpers.dart';
import 'cycle_models.dart';

/// Groups individual bleeding days into contiguous period spans.
///
/// Daily logs are the single source of truth for menstruation: any day with
/// logged flow is a bleeding day, and runs of consecutive days form one period.
/// A gap of more than one day starts a new period.
List<PeriodInput> groupBleedingDays(Iterable<DateTime> bleedingDays) {
  final days = bleedingDays.map(dateOnly).toSet().toList()..sort();
  if (days.isEmpty) return const [];

  final spans = <PeriodInput>[];
  var start = days.first;
  var prev = days.first;
  for (var i = 1; i < days.length; i++) {
    final d = days[i];
    if (daysBetween(prev, d) == 1) {
      prev = d; // still contiguous
    } else {
      spans.add(PeriodInput(start, prev));
      start = d;
      prev = d;
    }
  }
  spans.add(PeriodInput(start, prev));
  return spans;
}
