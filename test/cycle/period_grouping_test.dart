import 'package:flutter_test/flutter_test.dart';
import 'package:luna/core/cycle/period_grouping.dart';

void main() {
  test('empty input yields no spans', () {
    expect(groupBleedingDays(const []), isEmpty);
  });

  test('consecutive days form one span', () {
    final spans = groupBleedingDays([
      DateTime(2026, 6, 1),
      DateTime(2026, 6, 2),
      DateTime(2026, 6, 3),
    ]);
    expect(spans, hasLength(1));
    expect(spans.single.start, DateTime(2026, 6, 1));
    expect(spans.single.end, DateTime(2026, 6, 3));
  });

  test('a gap of more than one day splits into separate spans', () {
    final spans = groupBleedingDays([
      DateTime(2026, 6, 1),
      DateTime(2026, 6, 2),
      // gap (June 3 missing)
      DateTime(2026, 6, 28),
      DateTime(2026, 6, 29),
    ]);
    expect(spans, hasLength(2));
    expect(spans[0].end, DateTime(2026, 6, 2));
    expect(spans[1].start, DateTime(2026, 6, 28));
  });

  test('unsorted and duplicate days are normalized', () {
    final spans = groupBleedingDays([
      DateTime(2026, 6, 3, 10),
      DateTime(2026, 6, 1),
      DateTime(2026, 6, 2),
      DateTime(2026, 6, 2, 23), // duplicate day, different time
    ]);
    expect(spans, hasLength(1));
    expect(spans.single.start, DateTime(2026, 6, 1));
    expect(spans.single.end, DateTime(2026, 6, 3));
  });
}
