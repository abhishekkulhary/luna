/// Date helpers for day-granular cycle math. All cycle data is day-based, so we
/// consistently strip the time component and compare whole days.
library;

/// Returns a new [DateTime] at local midnight of [d].
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Whole days from [a] to [b] (b - a), ignoring time-of-day. Can be negative.
///
/// Computed in UTC so a daylight-saving transition between the two dates never
/// shifts the result by an hour (which would truncate to an off-by-one day).
int daysBetween(DateTime a, DateTime b) {
  final aUtc = DateTime.utc(a.year, a.month, a.day);
  final bUtc = DateTime.utc(b.year, b.month, b.day);
  return bUtc.difference(aUtc).inDays;
}

/// True when [a] and [b] fall on the same calendar day.
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Adds [days] to [d], returning a midnight-normalized date.
DateTime addDays(DateTime d, int days) =>
    DateTime(d.year, d.month, d.day + days);

/// Today at local midnight.
DateTime today() => dateOnly(DateTime.now());
