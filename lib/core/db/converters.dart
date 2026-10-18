import 'package:drift/drift.dart';

import '../models/enums.dart';

/// Stores a list of [Symptom] as a comma-separated string of enum names.
class SymptomListConverter extends TypeConverter<List<Symptom>, String> {
  const SymptomListConverter();

  @override
  List<Symptom> fromSql(String fromDb) => _decode(fromDb, Symptom.values);

  @override
  String toSql(List<Symptom> value) => value.map((e) => e.name).join(',');
}

/// Stores a list of [Mood] as a comma-separated string of enum names.
class MoodListConverter extends TypeConverter<List<Mood>, String> {
  const MoodListConverter();

  @override
  List<Mood> fromSql(String fromDb) => _decode(fromDb, Mood.values);

  @override
  String toSql(List<Mood> value) => value.map((e) => e.name).join(',');
}

/// Decodes a comma-separated name list, silently dropping unknown names so an
/// older/newer enum set never crashes the read path.
List<T> _decode<T extends Enum>(String raw, List<T> values) {
  if (raw.isEmpty) return <T>[];
  final byName = {for (final v in values) v.name: v};
  return raw
      .split(',')
      .map((n) => byName[n.trim()])
      .whereType<T>()
      .toList(growable: false);
}
