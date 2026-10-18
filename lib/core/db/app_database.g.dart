// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DailyLogsTable extends DailyLogs
    with TableInfo<$DailyLogsTable, DailyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FlowIntensity, String> flow =
      GeneratedColumn<String>(
        'flow',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(FlowIntensity.none.name),
      ).withConverter<FlowIntensity>($DailyLogsTable.$converterflow);
  @override
  late final GeneratedColumnWithTypeConverter<List<Symptom>, String> symptoms =
      GeneratedColumn<String>(
        'symptoms',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      ).withConverter<List<Symptom>>($DailyLogsTable.$convertersymptoms);
  @override
  late final GeneratedColumnWithTypeConverter<List<Mood>, String> moods =
      GeneratedColumn<String>(
        'moods',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      ).withConverter<List<Mood>>($DailyLogsTable.$convertermoods);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intimacyMeta = const VerificationMeta(
    'intimacy',
  );
  @override
  late final GeneratedColumn<bool> intimacy = GeneratedColumn<bool>(
    'intimacy',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("intimacy" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    flow,
    symptoms,
    moods,
    notes,
    temperature,
    intimacy,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('intimacy')) {
      context.handle(
        _intimacyMeta,
        intimacy.isAcceptableOrUnknown(data['intimacy']!, _intimacyMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLog(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      flow: $DailyLogsTable.$converterflow.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}flow'],
        )!,
      ),
      symptoms: $DailyLogsTable.$convertersymptoms.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}symptoms'],
        )!,
      ),
      moods: $DailyLogsTable.$convertermoods.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}moods'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      intimacy: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}intimacy'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyLogsTable createAlias(String alias) {
    return $DailyLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FlowIntensity, String, String> $converterflow =
      const EnumNameConverter<FlowIntensity>(FlowIntensity.values);
  static TypeConverter<List<Symptom>, String> $convertersymptoms =
      const SymptomListConverter();
  static TypeConverter<List<Mood>, String> $convertermoods =
      const MoodListConverter();
}

class DailyLog extends DataClass implements Insertable<DailyLog> {
  final DateTime date;
  final FlowIntensity flow;
  final List<Symptom> symptoms;
  final List<Mood> moods;
  final String? notes;
  final double? temperature;
  final bool intimacy;
  final DateTime updatedAt;
  const DailyLog({
    required this.date,
    required this.flow,
    required this.symptoms,
    required this.moods,
    this.notes,
    this.temperature,
    required this.intimacy,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    {
      map['flow'] = Variable<String>(
        $DailyLogsTable.$converterflow.toSql(flow),
      );
    }
    {
      map['symptoms'] = Variable<String>(
        $DailyLogsTable.$convertersymptoms.toSql(symptoms),
      );
    }
    {
      map['moods'] = Variable<String>(
        $DailyLogsTable.$convertermoods.toSql(moods),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    map['intimacy'] = Variable<bool>(intimacy);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyLogsCompanion(
      date: Value(date),
      flow: Value(flow),
      symptoms: Value(symptoms),
      moods: Value(moods),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      intimacy: Value(intimacy),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLog(
      date: serializer.fromJson<DateTime>(json['date']),
      flow: $DailyLogsTable.$converterflow.fromJson(
        serializer.fromJson<String>(json['flow']),
      ),
      symptoms: serializer.fromJson<List<Symptom>>(json['symptoms']),
      moods: serializer.fromJson<List<Mood>>(json['moods']),
      notes: serializer.fromJson<String?>(json['notes']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      intimacy: serializer.fromJson<bool>(json['intimacy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'flow': serializer.toJson<String>(
        $DailyLogsTable.$converterflow.toJson(flow),
      ),
      'symptoms': serializer.toJson<List<Symptom>>(symptoms),
      'moods': serializer.toJson<List<Mood>>(moods),
      'notes': serializer.toJson<String?>(notes),
      'temperature': serializer.toJson<double?>(temperature),
      'intimacy': serializer.toJson<bool>(intimacy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyLog copyWith({
    DateTime? date,
    FlowIntensity? flow,
    List<Symptom>? symptoms,
    List<Mood>? moods,
    Value<String?> notes = const Value.absent(),
    Value<double?> temperature = const Value.absent(),
    bool? intimacy,
    DateTime? updatedAt,
  }) => DailyLog(
    date: date ?? this.date,
    flow: flow ?? this.flow,
    symptoms: symptoms ?? this.symptoms,
    moods: moods ?? this.moods,
    notes: notes.present ? notes.value : this.notes,
    temperature: temperature.present ? temperature.value : this.temperature,
    intimacy: intimacy ?? this.intimacy,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyLog copyWithCompanion(DailyLogsCompanion data) {
    return DailyLog(
      date: data.date.present ? data.date.value : this.date,
      flow: data.flow.present ? data.flow.value : this.flow,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      moods: data.moods.present ? data.moods.value : this.moods,
      notes: data.notes.present ? data.notes.value : this.notes,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      intimacy: data.intimacy.present ? data.intimacy.value : this.intimacy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLog(')
          ..write('date: $date, ')
          ..write('flow: $flow, ')
          ..write('symptoms: $symptoms, ')
          ..write('moods: $moods, ')
          ..write('notes: $notes, ')
          ..write('temperature: $temperature, ')
          ..write('intimacy: $intimacy, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    date,
    flow,
    symptoms,
    moods,
    notes,
    temperature,
    intimacy,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLog &&
          other.date == this.date &&
          other.flow == this.flow &&
          other.symptoms == this.symptoms &&
          other.moods == this.moods &&
          other.notes == this.notes &&
          other.temperature == this.temperature &&
          other.intimacy == this.intimacy &&
          other.updatedAt == this.updatedAt);
}

class DailyLogsCompanion extends UpdateCompanion<DailyLog> {
  final Value<DateTime> date;
  final Value<FlowIntensity> flow;
  final Value<List<Symptom>> symptoms;
  final Value<List<Mood>> moods;
  final Value<String?> notes;
  final Value<double?> temperature;
  final Value<bool> intimacy;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyLogsCompanion({
    this.date = const Value.absent(),
    this.flow = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.moods = const Value.absent(),
    this.notes = const Value.absent(),
    this.temperature = const Value.absent(),
    this.intimacy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyLogsCompanion.insert({
    required DateTime date,
    this.flow = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.moods = const Value.absent(),
    this.notes = const Value.absent(),
    this.temperature = const Value.absent(),
    this.intimacy = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       updatedAt = Value(updatedAt);
  static Insertable<DailyLog> custom({
    Expression<DateTime>? date,
    Expression<String>? flow,
    Expression<String>? symptoms,
    Expression<String>? moods,
    Expression<String>? notes,
    Expression<double>? temperature,
    Expression<bool>? intimacy,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (flow != null) 'flow': flow,
      if (symptoms != null) 'symptoms': symptoms,
      if (moods != null) 'moods': moods,
      if (notes != null) 'notes': notes,
      if (temperature != null) 'temperature': temperature,
      if (intimacy != null) 'intimacy': intimacy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyLogsCompanion copyWith({
    Value<DateTime>? date,
    Value<FlowIntensity>? flow,
    Value<List<Symptom>>? symptoms,
    Value<List<Mood>>? moods,
    Value<String?>? notes,
    Value<double?>? temperature,
    Value<bool>? intimacy,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyLogsCompanion(
      date: date ?? this.date,
      flow: flow ?? this.flow,
      symptoms: symptoms ?? this.symptoms,
      moods: moods ?? this.moods,
      notes: notes ?? this.notes,
      temperature: temperature ?? this.temperature,
      intimacy: intimacy ?? this.intimacy,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (flow.present) {
      map['flow'] = Variable<String>(
        $DailyLogsTable.$converterflow.toSql(flow.value),
      );
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(
        $DailyLogsTable.$convertersymptoms.toSql(symptoms.value),
      );
    }
    if (moods.present) {
      map['moods'] = Variable<String>(
        $DailyLogsTable.$convertermoods.toSql(moods.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (intimacy.present) {
      map['intimacy'] = Variable<bool>(intimacy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogsCompanion(')
          ..write('date: $date, ')
          ..write('flow: $flow, ')
          ..write('symptoms: $symptoms, ')
          ..write('moods: $moods, ')
          ..write('notes: $notes, ')
          ..write('temperature: $temperature, ')
          ..write('intimacy: $intimacy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderRepeat, String> repeat =
      GeneratedColumn<String>(
        'repeat',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReminderRepeat>($RemindersTable.$converterrepeat);
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    body,
    hour,
    minute,
    repeat,
    weekday,
    enabled,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      ),
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      repeat: $RemindersTable.$converterrepeat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}repeat'],
        )!,
      ),
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReminderRepeat, String, String> $converterrepeat =
      const EnumNameConverter<ReminderRepeat>(ReminderRepeat.values);
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String title;
  final String? body;
  final int hour;
  final int minute;
  final ReminderRepeat repeat;
  final int? weekday;
  final bool enabled;
  final DateTime createdAt;
  const Reminder({
    required this.id,
    required this.title,
    this.body,
    required this.hour,
    required this.minute,
    required this.repeat,
    this.weekday,
    required this.enabled,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    {
      map['repeat'] = Variable<String>(
        $RemindersTable.$converterrepeat.toSql(repeat),
      );
    }
    if (!nullToAbsent || weekday != null) {
      map['weekday'] = Variable<int>(weekday);
    }
    map['enabled'] = Variable<bool>(enabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      title: Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      hour: Value(hour),
      minute: Value(minute),
      repeat: Value(repeat),
      weekday: weekday == null && nullToAbsent
          ? const Value.absent()
          : Value(weekday),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String?>(json['body']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      repeat: $RemindersTable.$converterrepeat.fromJson(
        serializer.fromJson<String>(json['repeat']),
      ),
      weekday: serializer.fromJson<int?>(json['weekday']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String?>(body),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'repeat': serializer.toJson<String>(
        $RemindersTable.$converterrepeat.toJson(repeat),
      ),
      'weekday': serializer.toJson<int?>(weekday),
      'enabled': serializer.toJson<bool>(enabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith({
    String? id,
    String? title,
    Value<String?> body = const Value.absent(),
    int? hour,
    int? minute,
    ReminderRepeat? repeat,
    Value<int?> weekday = const Value.absent(),
    bool? enabled,
    DateTime? createdAt,
  }) => Reminder(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body.present ? body.value : this.body,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    repeat: repeat ?? this.repeat,
    weekday: weekday.present ? weekday.value : this.weekday,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      repeat: data.repeat.present ? data.repeat.value : this.repeat,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('repeat: $repeat, ')
          ..write('weekday: $weekday, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    body,
    hour,
    minute,
    repeat,
    weekday,
    enabled,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.repeat == this.repeat &&
          other.weekday == this.weekday &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> body;
  final Value<int> hour;
  final Value<int> minute;
  final Value<ReminderRepeat> repeat;
  final Value<int?> weekday;
  final Value<bool> enabled;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.repeat = const Value.absent(),
    this.weekday = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String title,
    this.body = const Value.absent(),
    required int hour,
    required int minute,
    required ReminderRepeat repeat,
    this.weekday = const Value.absent(),
    this.enabled = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       hour = Value(hour),
       minute = Value(minute),
       repeat = Value(repeat),
       createdAt = Value(createdAt);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<String>? repeat,
    Expression<int>? weekday,
    Expression<bool>? enabled,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (repeat != null) 'repeat': repeat,
      if (weekday != null) 'weekday': weekday,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? body,
    Value<int>? hour,
    Value<int>? minute,
    Value<ReminderRepeat>? repeat,
    Value<int?>? weekday,
    Value<bool>? enabled,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      repeat: repeat ?? this.repeat,
      weekday: weekday ?? this.weekday,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (repeat.present) {
      map['repeat'] = Variable<String>(
        $RemindersTable.$converterrepeat.toSql(repeat.value),
      );
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('repeat: $repeat, ')
          ..write('weekday: $weekday, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgCycleLengthMeta = const VerificationMeta(
    'avgCycleLength',
  );
  @override
  late final GeneratedColumn<int> avgCycleLength = GeneratedColumn<int>(
    'avg_cycle_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(28),
  );
  static const VerificationMeta _avgPeriodLengthMeta = const VerificationMeta(
    'avgPeriodLength',
  );
  @override
  late final GeneratedColumn<int> avgPeriodLength = GeneratedColumn<int>(
    'avg_period_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _lutealPhaseLengthMeta = const VerificationMeta(
    'lutealPhaseLength',
  );
  @override
  late final GeneratedColumn<int> lutealPhaseLength = GeneratedColumn<int>(
    'luteal_phase_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _adaptFromHistoryMeta = const VerificationMeta(
    'adaptFromHistory',
  );
  @override
  late final GeneratedColumn<bool> adaptFromHistory = GeneratedColumn<bool>(
    'adapt_from_history',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("adapt_from_history" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ThemeModeSetting, String>
  themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(ThemeModeSetting.system.name),
  ).withConverter<ThemeModeSetting>($AppSettingsTable.$converterthemeMode);
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AppLockType, String> lockType =
      GeneratedColumn<String>(
        'lock_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(AppLockType.none.name),
      ).withConverter<AppLockType>($AppSettingsTable.$converterlockType);
  static const VerificationMeta _notifyPeriodSoonMeta = const VerificationMeta(
    'notifyPeriodSoon',
  );
  @override
  late final GeneratedColumn<bool> notifyPeriodSoon = GeneratedColumn<bool>(
    'notify_period_soon',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_period_soon" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyPeriodStartMeta = const VerificationMeta(
    'notifyPeriodStart',
  );
  @override
  late final GeneratedColumn<bool> notifyPeriodStart = GeneratedColumn<bool>(
    'notify_period_start',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_period_start" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyFertileWindowMeta =
      const VerificationMeta('notifyFertileWindow');
  @override
  late final GeneratedColumn<bool> notifyFertileWindow = GeneratedColumn<bool>(
    'notify_fertile_window',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_fertile_window" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyOvulationMeta = const VerificationMeta(
    'notifyOvulation',
  );
  @override
  late final GeneratedColumn<bool> notifyOvulation = GeneratedColumn<bool>(
    'notify_ovulation',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_ovulation" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyPeriodLateMeta = const VerificationMeta(
    'notifyPeriodLate',
  );
  @override
  late final GeneratedColumn<bool> notifyPeriodLate = GeneratedColumn<bool>(
    'notify_period_late',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_period_late" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyPmsMeta = const VerificationMeta(
    'notifyPms',
  );
  @override
  late final GeneratedColumn<bool> notifyPms = GeneratedColumn<bool>(
    'notify_pms',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_pms" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reminderHourMeta = const VerificationMeta(
    'reminderHour',
  );
  @override
  late final GeneratedColumn<int> reminderHour = GeneratedColumn<int>(
    'reminder_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9),
  );
  static const VerificationMeta _reminderMinuteMeta = const VerificationMeta(
    'reminderMinute',
  );
  @override
  late final GeneratedColumn<int> reminderMinute = GeneratedColumn<int>(
    'reminder_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    avgCycleLength,
    avgPeriodLength,
    lutealPhaseLength,
    adaptFromHistory,
    themeMode,
    languageCode,
    onboardingComplete,
    lockType,
    notifyPeriodSoon,
    notifyPeriodStart,
    notifyFertileWindow,
    notifyOvulation,
    notifyPeriodLate,
    notifyPms,
    reminderHour,
    reminderMinute,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('avg_cycle_length')) {
      context.handle(
        _avgCycleLengthMeta,
        avgCycleLength.isAcceptableOrUnknown(
          data['avg_cycle_length']!,
          _avgCycleLengthMeta,
        ),
      );
    }
    if (data.containsKey('avg_period_length')) {
      context.handle(
        _avgPeriodLengthMeta,
        avgPeriodLength.isAcceptableOrUnknown(
          data['avg_period_length']!,
          _avgPeriodLengthMeta,
        ),
      );
    }
    if (data.containsKey('luteal_phase_length')) {
      context.handle(
        _lutealPhaseLengthMeta,
        lutealPhaseLength.isAcceptableOrUnknown(
          data['luteal_phase_length']!,
          _lutealPhaseLengthMeta,
        ),
      );
    }
    if (data.containsKey('adapt_from_history')) {
      context.handle(
        _adaptFromHistoryMeta,
        adaptFromHistory.isAcceptableOrUnknown(
          data['adapt_from_history']!,
          _adaptFromHistoryMeta,
        ),
      );
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('notify_period_soon')) {
      context.handle(
        _notifyPeriodSoonMeta,
        notifyPeriodSoon.isAcceptableOrUnknown(
          data['notify_period_soon']!,
          _notifyPeriodSoonMeta,
        ),
      );
    }
    if (data.containsKey('notify_period_start')) {
      context.handle(
        _notifyPeriodStartMeta,
        notifyPeriodStart.isAcceptableOrUnknown(
          data['notify_period_start']!,
          _notifyPeriodStartMeta,
        ),
      );
    }
    if (data.containsKey('notify_fertile_window')) {
      context.handle(
        _notifyFertileWindowMeta,
        notifyFertileWindow.isAcceptableOrUnknown(
          data['notify_fertile_window']!,
          _notifyFertileWindowMeta,
        ),
      );
    }
    if (data.containsKey('notify_ovulation')) {
      context.handle(
        _notifyOvulationMeta,
        notifyOvulation.isAcceptableOrUnknown(
          data['notify_ovulation']!,
          _notifyOvulationMeta,
        ),
      );
    }
    if (data.containsKey('notify_period_late')) {
      context.handle(
        _notifyPeriodLateMeta,
        notifyPeriodLate.isAcceptableOrUnknown(
          data['notify_period_late']!,
          _notifyPeriodLateMeta,
        ),
      );
    }
    if (data.containsKey('notify_pms')) {
      context.handle(
        _notifyPmsMeta,
        notifyPms.isAcceptableOrUnknown(data['notify_pms']!, _notifyPmsMeta),
      );
    }
    if (data.containsKey('reminder_hour')) {
      context.handle(
        _reminderHourMeta,
        reminderHour.isAcceptableOrUnknown(
          data['reminder_hour']!,
          _reminderHourMeta,
        ),
      );
    }
    if (data.containsKey('reminder_minute')) {
      context.handle(
        _reminderMinuteMeta,
        reminderMinute.isAcceptableOrUnknown(
          data['reminder_minute']!,
          _reminderMinuteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      avgCycleLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avg_cycle_length'],
      )!,
      avgPeriodLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avg_period_length'],
      )!,
      lutealPhaseLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}luteal_phase_length'],
      )!,
      adaptFromHistory: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}adapt_from_history'],
      )!,
      themeMode: $AppSettingsTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      ),
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      lockType: $AppSettingsTable.$converterlockType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}lock_type'],
        )!,
      ),
      notifyPeriodSoon: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_period_soon'],
      )!,
      notifyPeriodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_period_start'],
      )!,
      notifyFertileWindow: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_fertile_window'],
      )!,
      notifyOvulation: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_ovulation'],
      )!,
      notifyPeriodLate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_period_late'],
      )!,
      notifyPms: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_pms'],
      )!,
      reminderHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_hour'],
      )!,
      reminderMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minute'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ThemeModeSetting, String, String>
  $converterthemeMode = const EnumNameConverter<ThemeModeSetting>(
    ThemeModeSetting.values,
  );
  static JsonTypeConverter2<AppLockType, String, String> $converterlockType =
      const EnumNameConverter<AppLockType>(AppLockType.values);
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final int avgCycleLength;
  final int avgPeriodLength;
  final int lutealPhaseLength;
  final bool adaptFromHistory;
  final ThemeModeSetting themeMode;
  final String? languageCode;
  final bool onboardingComplete;
  final AppLockType lockType;
  final bool notifyPeriodSoon;
  final bool notifyPeriodStart;
  final bool notifyFertileWindow;
  final bool notifyOvulation;
  final bool notifyPeriodLate;
  final bool notifyPms;
  final int reminderHour;
  final int reminderMinute;
  const AppSetting({
    required this.id,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.lutealPhaseLength,
    required this.adaptFromHistory,
    required this.themeMode,
    this.languageCode,
    required this.onboardingComplete,
    required this.lockType,
    required this.notifyPeriodSoon,
    required this.notifyPeriodStart,
    required this.notifyFertileWindow,
    required this.notifyOvulation,
    required this.notifyPeriodLate,
    required this.notifyPms,
    required this.reminderHour,
    required this.reminderMinute,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['avg_cycle_length'] = Variable<int>(avgCycleLength);
    map['avg_period_length'] = Variable<int>(avgPeriodLength);
    map['luteal_phase_length'] = Variable<int>(lutealPhaseLength);
    map['adapt_from_history'] = Variable<bool>(adaptFromHistory);
    {
      map['theme_mode'] = Variable<String>(
        $AppSettingsTable.$converterthemeMode.toSql(themeMode),
      );
    }
    if (!nullToAbsent || languageCode != null) {
      map['language_code'] = Variable<String>(languageCode);
    }
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    {
      map['lock_type'] = Variable<String>(
        $AppSettingsTable.$converterlockType.toSql(lockType),
      );
    }
    map['notify_period_soon'] = Variable<bool>(notifyPeriodSoon);
    map['notify_period_start'] = Variable<bool>(notifyPeriodStart);
    map['notify_fertile_window'] = Variable<bool>(notifyFertileWindow);
    map['notify_ovulation'] = Variable<bool>(notifyOvulation);
    map['notify_period_late'] = Variable<bool>(notifyPeriodLate);
    map['notify_pms'] = Variable<bool>(notifyPms);
    map['reminder_hour'] = Variable<int>(reminderHour);
    map['reminder_minute'] = Variable<int>(reminderMinute);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      avgCycleLength: Value(avgCycleLength),
      avgPeriodLength: Value(avgPeriodLength),
      lutealPhaseLength: Value(lutealPhaseLength),
      adaptFromHistory: Value(adaptFromHistory),
      themeMode: Value(themeMode),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
      onboardingComplete: Value(onboardingComplete),
      lockType: Value(lockType),
      notifyPeriodSoon: Value(notifyPeriodSoon),
      notifyPeriodStart: Value(notifyPeriodStart),
      notifyFertileWindow: Value(notifyFertileWindow),
      notifyOvulation: Value(notifyOvulation),
      notifyPeriodLate: Value(notifyPeriodLate),
      notifyPms: Value(notifyPms),
      reminderHour: Value(reminderHour),
      reminderMinute: Value(reminderMinute),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      avgCycleLength: serializer.fromJson<int>(json['avgCycleLength']),
      avgPeriodLength: serializer.fromJson<int>(json['avgPeriodLength']),
      lutealPhaseLength: serializer.fromJson<int>(json['lutealPhaseLength']),
      adaptFromHistory: serializer.fromJson<bool>(json['adaptFromHistory']),
      themeMode: $AppSettingsTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      languageCode: serializer.fromJson<String?>(json['languageCode']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      lockType: $AppSettingsTable.$converterlockType.fromJson(
        serializer.fromJson<String>(json['lockType']),
      ),
      notifyPeriodSoon: serializer.fromJson<bool>(json['notifyPeriodSoon']),
      notifyPeriodStart: serializer.fromJson<bool>(json['notifyPeriodStart']),
      notifyFertileWindow: serializer.fromJson<bool>(
        json['notifyFertileWindow'],
      ),
      notifyOvulation: serializer.fromJson<bool>(json['notifyOvulation']),
      notifyPeriodLate: serializer.fromJson<bool>(json['notifyPeriodLate']),
      notifyPms: serializer.fromJson<bool>(json['notifyPms']),
      reminderHour: serializer.fromJson<int>(json['reminderHour']),
      reminderMinute: serializer.fromJson<int>(json['reminderMinute']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'avgCycleLength': serializer.toJson<int>(avgCycleLength),
      'avgPeriodLength': serializer.toJson<int>(avgPeriodLength),
      'lutealPhaseLength': serializer.toJson<int>(lutealPhaseLength),
      'adaptFromHistory': serializer.toJson<bool>(adaptFromHistory),
      'themeMode': serializer.toJson<String>(
        $AppSettingsTable.$converterthemeMode.toJson(themeMode),
      ),
      'languageCode': serializer.toJson<String?>(languageCode),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'lockType': serializer.toJson<String>(
        $AppSettingsTable.$converterlockType.toJson(lockType),
      ),
      'notifyPeriodSoon': serializer.toJson<bool>(notifyPeriodSoon),
      'notifyPeriodStart': serializer.toJson<bool>(notifyPeriodStart),
      'notifyFertileWindow': serializer.toJson<bool>(notifyFertileWindow),
      'notifyOvulation': serializer.toJson<bool>(notifyOvulation),
      'notifyPeriodLate': serializer.toJson<bool>(notifyPeriodLate),
      'notifyPms': serializer.toJson<bool>(notifyPms),
      'reminderHour': serializer.toJson<int>(reminderHour),
      'reminderMinute': serializer.toJson<int>(reminderMinute),
    };
  }

  AppSetting copyWith({
    int? id,
    int? avgCycleLength,
    int? avgPeriodLength,
    int? lutealPhaseLength,
    bool? adaptFromHistory,
    ThemeModeSetting? themeMode,
    Value<String?> languageCode = const Value.absent(),
    bool? onboardingComplete,
    AppLockType? lockType,
    bool? notifyPeriodSoon,
    bool? notifyPeriodStart,
    bool? notifyFertileWindow,
    bool? notifyOvulation,
    bool? notifyPeriodLate,
    bool? notifyPms,
    int? reminderHour,
    int? reminderMinute,
  }) => AppSetting(
    id: id ?? this.id,
    avgCycleLength: avgCycleLength ?? this.avgCycleLength,
    avgPeriodLength: avgPeriodLength ?? this.avgPeriodLength,
    lutealPhaseLength: lutealPhaseLength ?? this.lutealPhaseLength,
    adaptFromHistory: adaptFromHistory ?? this.adaptFromHistory,
    themeMode: themeMode ?? this.themeMode,
    languageCode: languageCode.present ? languageCode.value : this.languageCode,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    lockType: lockType ?? this.lockType,
    notifyPeriodSoon: notifyPeriodSoon ?? this.notifyPeriodSoon,
    notifyPeriodStart: notifyPeriodStart ?? this.notifyPeriodStart,
    notifyFertileWindow: notifyFertileWindow ?? this.notifyFertileWindow,
    notifyOvulation: notifyOvulation ?? this.notifyOvulation,
    notifyPeriodLate: notifyPeriodLate ?? this.notifyPeriodLate,
    notifyPms: notifyPms ?? this.notifyPms,
    reminderHour: reminderHour ?? this.reminderHour,
    reminderMinute: reminderMinute ?? this.reminderMinute,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      avgCycleLength: data.avgCycleLength.present
          ? data.avgCycleLength.value
          : this.avgCycleLength,
      avgPeriodLength: data.avgPeriodLength.present
          ? data.avgPeriodLength.value
          : this.avgPeriodLength,
      lutealPhaseLength: data.lutealPhaseLength.present
          ? data.lutealPhaseLength.value
          : this.lutealPhaseLength,
      adaptFromHistory: data.adaptFromHistory.present
          ? data.adaptFromHistory.value
          : this.adaptFromHistory,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      lockType: data.lockType.present ? data.lockType.value : this.lockType,
      notifyPeriodSoon: data.notifyPeriodSoon.present
          ? data.notifyPeriodSoon.value
          : this.notifyPeriodSoon,
      notifyPeriodStart: data.notifyPeriodStart.present
          ? data.notifyPeriodStart.value
          : this.notifyPeriodStart,
      notifyFertileWindow: data.notifyFertileWindow.present
          ? data.notifyFertileWindow.value
          : this.notifyFertileWindow,
      notifyOvulation: data.notifyOvulation.present
          ? data.notifyOvulation.value
          : this.notifyOvulation,
      notifyPeriodLate: data.notifyPeriodLate.present
          ? data.notifyPeriodLate.value
          : this.notifyPeriodLate,
      notifyPms: data.notifyPms.present ? data.notifyPms.value : this.notifyPms,
      reminderHour: data.reminderHour.present
          ? data.reminderHour.value
          : this.reminderHour,
      reminderMinute: data.reminderMinute.present
          ? data.reminderMinute.value
          : this.reminderMinute,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('avgCycleLength: $avgCycleLength, ')
          ..write('avgPeriodLength: $avgPeriodLength, ')
          ..write('lutealPhaseLength: $lutealPhaseLength, ')
          ..write('adaptFromHistory: $adaptFromHistory, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('lockType: $lockType, ')
          ..write('notifyPeriodSoon: $notifyPeriodSoon, ')
          ..write('notifyPeriodStart: $notifyPeriodStart, ')
          ..write('notifyFertileWindow: $notifyFertileWindow, ')
          ..write('notifyOvulation: $notifyOvulation, ')
          ..write('notifyPeriodLate: $notifyPeriodLate, ')
          ..write('notifyPms: $notifyPms, ')
          ..write('reminderHour: $reminderHour, ')
          ..write('reminderMinute: $reminderMinute')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    avgCycleLength,
    avgPeriodLength,
    lutealPhaseLength,
    adaptFromHistory,
    themeMode,
    languageCode,
    onboardingComplete,
    lockType,
    notifyPeriodSoon,
    notifyPeriodStart,
    notifyFertileWindow,
    notifyOvulation,
    notifyPeriodLate,
    notifyPms,
    reminderHour,
    reminderMinute,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.avgCycleLength == this.avgCycleLength &&
          other.avgPeriodLength == this.avgPeriodLength &&
          other.lutealPhaseLength == this.lutealPhaseLength &&
          other.adaptFromHistory == this.adaptFromHistory &&
          other.themeMode == this.themeMode &&
          other.languageCode == this.languageCode &&
          other.onboardingComplete == this.onboardingComplete &&
          other.lockType == this.lockType &&
          other.notifyPeriodSoon == this.notifyPeriodSoon &&
          other.notifyPeriodStart == this.notifyPeriodStart &&
          other.notifyFertileWindow == this.notifyFertileWindow &&
          other.notifyOvulation == this.notifyOvulation &&
          other.notifyPeriodLate == this.notifyPeriodLate &&
          other.notifyPms == this.notifyPms &&
          other.reminderHour == this.reminderHour &&
          other.reminderMinute == this.reminderMinute);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<int> avgCycleLength;
  final Value<int> avgPeriodLength;
  final Value<int> lutealPhaseLength;
  final Value<bool> adaptFromHistory;
  final Value<ThemeModeSetting> themeMode;
  final Value<String?> languageCode;
  final Value<bool> onboardingComplete;
  final Value<AppLockType> lockType;
  final Value<bool> notifyPeriodSoon;
  final Value<bool> notifyPeriodStart;
  final Value<bool> notifyFertileWindow;
  final Value<bool> notifyOvulation;
  final Value<bool> notifyPeriodLate;
  final Value<bool> notifyPms;
  final Value<int> reminderHour;
  final Value<int> reminderMinute;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.avgCycleLength = const Value.absent(),
    this.avgPeriodLength = const Value.absent(),
    this.lutealPhaseLength = const Value.absent(),
    this.adaptFromHistory = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.lockType = const Value.absent(),
    this.notifyPeriodSoon = const Value.absent(),
    this.notifyPeriodStart = const Value.absent(),
    this.notifyFertileWindow = const Value.absent(),
    this.notifyOvulation = const Value.absent(),
    this.notifyPeriodLate = const Value.absent(),
    this.notifyPms = const Value.absent(),
    this.reminderHour = const Value.absent(),
    this.reminderMinute = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.avgCycleLength = const Value.absent(),
    this.avgPeriodLength = const Value.absent(),
    this.lutealPhaseLength = const Value.absent(),
    this.adaptFromHistory = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.lockType = const Value.absent(),
    this.notifyPeriodSoon = const Value.absent(),
    this.notifyPeriodStart = const Value.absent(),
    this.notifyFertileWindow = const Value.absent(),
    this.notifyOvulation = const Value.absent(),
    this.notifyPeriodLate = const Value.absent(),
    this.notifyPms = const Value.absent(),
    this.reminderHour = const Value.absent(),
    this.reminderMinute = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<int>? avgCycleLength,
    Expression<int>? avgPeriodLength,
    Expression<int>? lutealPhaseLength,
    Expression<bool>? adaptFromHistory,
    Expression<String>? themeMode,
    Expression<String>? languageCode,
    Expression<bool>? onboardingComplete,
    Expression<String>? lockType,
    Expression<bool>? notifyPeriodSoon,
    Expression<bool>? notifyPeriodStart,
    Expression<bool>? notifyFertileWindow,
    Expression<bool>? notifyOvulation,
    Expression<bool>? notifyPeriodLate,
    Expression<bool>? notifyPms,
    Expression<int>? reminderHour,
    Expression<int>? reminderMinute,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (avgCycleLength != null) 'avg_cycle_length': avgCycleLength,
      if (avgPeriodLength != null) 'avg_period_length': avgPeriodLength,
      if (lutealPhaseLength != null) 'luteal_phase_length': lutealPhaseLength,
      if (adaptFromHistory != null) 'adapt_from_history': adaptFromHistory,
      if (themeMode != null) 'theme_mode': themeMode,
      if (languageCode != null) 'language_code': languageCode,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (lockType != null) 'lock_type': lockType,
      if (notifyPeriodSoon != null) 'notify_period_soon': notifyPeriodSoon,
      if (notifyPeriodStart != null) 'notify_period_start': notifyPeriodStart,
      if (notifyFertileWindow != null)
        'notify_fertile_window': notifyFertileWindow,
      if (notifyOvulation != null) 'notify_ovulation': notifyOvulation,
      if (notifyPeriodLate != null) 'notify_period_late': notifyPeriodLate,
      if (notifyPms != null) 'notify_pms': notifyPms,
      if (reminderHour != null) 'reminder_hour': reminderHour,
      if (reminderMinute != null) 'reminder_minute': reminderMinute,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? avgCycleLength,
    Value<int>? avgPeriodLength,
    Value<int>? lutealPhaseLength,
    Value<bool>? adaptFromHistory,
    Value<ThemeModeSetting>? themeMode,
    Value<String?>? languageCode,
    Value<bool>? onboardingComplete,
    Value<AppLockType>? lockType,
    Value<bool>? notifyPeriodSoon,
    Value<bool>? notifyPeriodStart,
    Value<bool>? notifyFertileWindow,
    Value<bool>? notifyOvulation,
    Value<bool>? notifyPeriodLate,
    Value<bool>? notifyPms,
    Value<int>? reminderHour,
    Value<int>? reminderMinute,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      avgCycleLength: avgCycleLength ?? this.avgCycleLength,
      avgPeriodLength: avgPeriodLength ?? this.avgPeriodLength,
      lutealPhaseLength: lutealPhaseLength ?? this.lutealPhaseLength,
      adaptFromHistory: adaptFromHistory ?? this.adaptFromHistory,
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      lockType: lockType ?? this.lockType,
      notifyPeriodSoon: notifyPeriodSoon ?? this.notifyPeriodSoon,
      notifyPeriodStart: notifyPeriodStart ?? this.notifyPeriodStart,
      notifyFertileWindow: notifyFertileWindow ?? this.notifyFertileWindow,
      notifyOvulation: notifyOvulation ?? this.notifyOvulation,
      notifyPeriodLate: notifyPeriodLate ?? this.notifyPeriodLate,
      notifyPms: notifyPms ?? this.notifyPms,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (avgCycleLength.present) {
      map['avg_cycle_length'] = Variable<int>(avgCycleLength.value);
    }
    if (avgPeriodLength.present) {
      map['avg_period_length'] = Variable<int>(avgPeriodLength.value);
    }
    if (lutealPhaseLength.present) {
      map['luteal_phase_length'] = Variable<int>(lutealPhaseLength.value);
    }
    if (adaptFromHistory.present) {
      map['adapt_from_history'] = Variable<bool>(adaptFromHistory.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
        $AppSettingsTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (lockType.present) {
      map['lock_type'] = Variable<String>(
        $AppSettingsTable.$converterlockType.toSql(lockType.value),
      );
    }
    if (notifyPeriodSoon.present) {
      map['notify_period_soon'] = Variable<bool>(notifyPeriodSoon.value);
    }
    if (notifyPeriodStart.present) {
      map['notify_period_start'] = Variable<bool>(notifyPeriodStart.value);
    }
    if (notifyFertileWindow.present) {
      map['notify_fertile_window'] = Variable<bool>(notifyFertileWindow.value);
    }
    if (notifyOvulation.present) {
      map['notify_ovulation'] = Variable<bool>(notifyOvulation.value);
    }
    if (notifyPeriodLate.present) {
      map['notify_period_late'] = Variable<bool>(notifyPeriodLate.value);
    }
    if (notifyPms.present) {
      map['notify_pms'] = Variable<bool>(notifyPms.value);
    }
    if (reminderHour.present) {
      map['reminder_hour'] = Variable<int>(reminderHour.value);
    }
    if (reminderMinute.present) {
      map['reminder_minute'] = Variable<int>(reminderMinute.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('avgCycleLength: $avgCycleLength, ')
          ..write('avgPeriodLength: $avgPeriodLength, ')
          ..write('lutealPhaseLength: $lutealPhaseLength, ')
          ..write('adaptFromHistory: $adaptFromHistory, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('lockType: $lockType, ')
          ..write('notifyPeriodSoon: $notifyPeriodSoon, ')
          ..write('notifyPeriodStart: $notifyPeriodStart, ')
          ..write('notifyFertileWindow: $notifyFertileWindow, ')
          ..write('notifyOvulation: $notifyOvulation, ')
          ..write('notifyPeriodLate: $notifyPeriodLate, ')
          ..write('notifyPms: $notifyPms, ')
          ..write('reminderHour: $reminderHour, ')
          ..write('reminderMinute: $reminderMinute')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyLogsTable dailyLogs = $DailyLogsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailyLogs,
    reminders,
    appSettings,
  ];
}

typedef $$DailyLogsTableCreateCompanionBuilder =
    DailyLogsCompanion Function({
      required DateTime date,
      Value<FlowIntensity> flow,
      Value<List<Symptom>> symptoms,
      Value<List<Mood>> moods,
      Value<String?> notes,
      Value<double?> temperature,
      Value<bool> intimacy,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DailyLogsTableUpdateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<DateTime> date,
      Value<FlowIntensity> flow,
      Value<List<Symptom>> symptoms,
      Value<List<Mood>> moods,
      Value<String?> notes,
      Value<double?> temperature,
      Value<bool> intimacy,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DailyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FlowIntensity, FlowIntensity, String>
  get flow => $composableBuilder(
    column: $table.flow,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Symptom>, List<Symptom>, String>
  get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Mood>, List<Mood>, String> get moods =>
      $composableBuilder(
        column: $table.moods,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get intimacy => $composableBuilder(
    column: $table.intimacy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flow => $composableBuilder(
    column: $table.flow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moods => $composableBuilder(
    column: $table.moods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get intimacy => $composableBuilder(
    column: $table.intimacy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FlowIntensity, String> get flow =>
      $composableBuilder(column: $table.flow, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Symptom>, String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Mood>, String> get moods =>
      $composableBuilder(column: $table.moods, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get intimacy =>
      $composableBuilder(column: $table.intimacy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyLogsTable,
          DailyLog,
          $$DailyLogsTableFilterComposer,
          $$DailyLogsTableOrderingComposer,
          $$DailyLogsTableAnnotationComposer,
          $$DailyLogsTableCreateCompanionBuilder,
          $$DailyLogsTableUpdateCompanionBuilder,
          (DailyLog, BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog>),
          DailyLog,
          PrefetchHooks Function()
        > {
  $$DailyLogsTableTableManager(_$AppDatabase db, $DailyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<FlowIntensity> flow = const Value.absent(),
                Value<List<Symptom>> symptoms = const Value.absent(),
                Value<List<Mood>> moods = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<bool> intimacy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyLogsCompanion(
                date: date,
                flow: flow,
                symptoms: symptoms,
                moods: moods,
                notes: notes,
                temperature: temperature,
                intimacy: intimacy,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime date,
                Value<FlowIntensity> flow = const Value.absent(),
                Value<List<Symptom>> symptoms = const Value.absent(),
                Value<List<Mood>> moods = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<bool> intimacy = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyLogsCompanion.insert(
                date: date,
                flow: flow,
                symptoms: symptoms,
                moods: moods,
                notes: notes,
                temperature: temperature,
                intimacy: intimacy,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyLogsTable,
      DailyLog,
      $$DailyLogsTableFilterComposer,
      $$DailyLogsTableOrderingComposer,
      $$DailyLogsTableAnnotationComposer,
      $$DailyLogsTableCreateCompanionBuilder,
      $$DailyLogsTableUpdateCompanionBuilder,
      (DailyLog, BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog>),
      DailyLog,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      required String id,
      required String title,
      Value<String?> body,
      required int hour,
      required int minute,
      required ReminderRepeat repeat,
      Value<int?> weekday,
      Value<bool> enabled,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> body,
      Value<int> hour,
      Value<int> minute,
      Value<ReminderRepeat> repeat,
      Value<int?> weekday,
      Value<bool> enabled,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReminderRepeat, ReminderRepeat, String>
  get repeat => $composableBuilder(
    column: $table.repeat,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeat => $composableBuilder(
    column: $table.repeat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderRepeat, String> get repeat =>
      $composableBuilder(column: $table.repeat, builder: (column) => column);

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<ReminderRepeat> repeat = const Value.absent(),
                Value<int?> weekday = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                title: title,
                body: body,
                hour: hour,
                minute: minute,
                repeat: repeat,
                weekday: weekday,
                enabled: enabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> body = const Value.absent(),
                required int hour,
                required int minute,
                required ReminderRepeat repeat,
                Value<int?> weekday = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                title: title,
                body: body,
                hour: hour,
                minute: minute,
                repeat: repeat,
                weekday: weekday,
                enabled: enabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int> avgCycleLength,
      Value<int> avgPeriodLength,
      Value<int> lutealPhaseLength,
      Value<bool> adaptFromHistory,
      Value<ThemeModeSetting> themeMode,
      Value<String?> languageCode,
      Value<bool> onboardingComplete,
      Value<AppLockType> lockType,
      Value<bool> notifyPeriodSoon,
      Value<bool> notifyPeriodStart,
      Value<bool> notifyFertileWindow,
      Value<bool> notifyOvulation,
      Value<bool> notifyPeriodLate,
      Value<bool> notifyPms,
      Value<int> reminderHour,
      Value<int> reminderMinute,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int> avgCycleLength,
      Value<int> avgPeriodLength,
      Value<int> lutealPhaseLength,
      Value<bool> adaptFromHistory,
      Value<ThemeModeSetting> themeMode,
      Value<String?> languageCode,
      Value<bool> onboardingComplete,
      Value<AppLockType> lockType,
      Value<bool> notifyPeriodSoon,
      Value<bool> notifyPeriodStart,
      Value<bool> notifyFertileWindow,
      Value<bool> notifyOvulation,
      Value<bool> notifyPeriodLate,
      Value<bool> notifyPms,
      Value<int> reminderHour,
      Value<int> reminderMinute,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avgCycleLength => $composableBuilder(
    column: $table.avgCycleLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avgPeriodLength => $composableBuilder(
    column: $table.avgPeriodLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lutealPhaseLength => $composableBuilder(
    column: $table.lutealPhaseLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get adaptFromHistory => $composableBuilder(
    column: $table.adaptFromHistory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ThemeModeSetting, ThemeModeSetting, String>
  get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppLockType, AppLockType, String>
  get lockType => $composableBuilder(
    column: $table.lockType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get notifyPeriodSoon => $composableBuilder(
    column: $table.notifyPeriodSoon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyPeriodStart => $composableBuilder(
    column: $table.notifyPeriodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyFertileWindow => $composableBuilder(
    column: $table.notifyFertileWindow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyOvulation => $composableBuilder(
    column: $table.notifyOvulation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyPeriodLate => $composableBuilder(
    column: $table.notifyPeriodLate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyPms => $composableBuilder(
    column: $table.notifyPms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderHour => $composableBuilder(
    column: $table.reminderHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avgCycleLength => $composableBuilder(
    column: $table.avgCycleLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avgPeriodLength => $composableBuilder(
    column: $table.avgPeriodLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lutealPhaseLength => $composableBuilder(
    column: $table.lutealPhaseLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get adaptFromHistory => $composableBuilder(
    column: $table.adaptFromHistory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lockType => $composableBuilder(
    column: $table.lockType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyPeriodSoon => $composableBuilder(
    column: $table.notifyPeriodSoon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyPeriodStart => $composableBuilder(
    column: $table.notifyPeriodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyFertileWindow => $composableBuilder(
    column: $table.notifyFertileWindow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyOvulation => $composableBuilder(
    column: $table.notifyOvulation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyPeriodLate => $composableBuilder(
    column: $table.notifyPeriodLate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyPms => $composableBuilder(
    column: $table.notifyPms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderHour => $composableBuilder(
    column: $table.reminderHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get avgCycleLength => $composableBuilder(
    column: $table.avgCycleLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get avgPeriodLength => $composableBuilder(
    column: $table.avgPeriodLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lutealPhaseLength => $composableBuilder(
    column: $table.lutealPhaseLength,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get adaptFromHistory => $composableBuilder(
    column: $table.adaptFromHistory,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ThemeModeSetting, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AppLockType, String> get lockType =>
      $composableBuilder(column: $table.lockType, builder: (column) => column);

  GeneratedColumn<bool> get notifyPeriodSoon => $composableBuilder(
    column: $table.notifyPeriodSoon,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyPeriodStart => $composableBuilder(
    column: $table.notifyPeriodStart,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyFertileWindow => $composableBuilder(
    column: $table.notifyFertileWindow,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyOvulation => $composableBuilder(
    column: $table.notifyOvulation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyPeriodLate => $composableBuilder(
    column: $table.notifyPeriodLate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyPms =>
      $composableBuilder(column: $table.notifyPms, builder: (column) => column);

  GeneratedColumn<int> get reminderHour => $composableBuilder(
    column: $table.reminderHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> avgCycleLength = const Value.absent(),
                Value<int> avgPeriodLength = const Value.absent(),
                Value<int> lutealPhaseLength = const Value.absent(),
                Value<bool> adaptFromHistory = const Value.absent(),
                Value<ThemeModeSetting> themeMode = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<AppLockType> lockType = const Value.absent(),
                Value<bool> notifyPeriodSoon = const Value.absent(),
                Value<bool> notifyPeriodStart = const Value.absent(),
                Value<bool> notifyFertileWindow = const Value.absent(),
                Value<bool> notifyOvulation = const Value.absent(),
                Value<bool> notifyPeriodLate = const Value.absent(),
                Value<bool> notifyPms = const Value.absent(),
                Value<int> reminderHour = const Value.absent(),
                Value<int> reminderMinute = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                avgCycleLength: avgCycleLength,
                avgPeriodLength: avgPeriodLength,
                lutealPhaseLength: lutealPhaseLength,
                adaptFromHistory: adaptFromHistory,
                themeMode: themeMode,
                languageCode: languageCode,
                onboardingComplete: onboardingComplete,
                lockType: lockType,
                notifyPeriodSoon: notifyPeriodSoon,
                notifyPeriodStart: notifyPeriodStart,
                notifyFertileWindow: notifyFertileWindow,
                notifyOvulation: notifyOvulation,
                notifyPeriodLate: notifyPeriodLate,
                notifyPms: notifyPms,
                reminderHour: reminderHour,
                reminderMinute: reminderMinute,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> avgCycleLength = const Value.absent(),
                Value<int> avgPeriodLength = const Value.absent(),
                Value<int> lutealPhaseLength = const Value.absent(),
                Value<bool> adaptFromHistory = const Value.absent(),
                Value<ThemeModeSetting> themeMode = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<AppLockType> lockType = const Value.absent(),
                Value<bool> notifyPeriodSoon = const Value.absent(),
                Value<bool> notifyPeriodStart = const Value.absent(),
                Value<bool> notifyFertileWindow = const Value.absent(),
                Value<bool> notifyOvulation = const Value.absent(),
                Value<bool> notifyPeriodLate = const Value.absent(),
                Value<bool> notifyPms = const Value.absent(),
                Value<int> reminderHour = const Value.absent(),
                Value<int> reminderMinute = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                avgCycleLength: avgCycleLength,
                avgPeriodLength: avgPeriodLength,
                lutealPhaseLength: lutealPhaseLength,
                adaptFromHistory: adaptFromHistory,
                themeMode: themeMode,
                languageCode: languageCode,
                onboardingComplete: onboardingComplete,
                lockType: lockType,
                notifyPeriodSoon: notifyPeriodSoon,
                notifyPeriodStart: notifyPeriodStart,
                notifyFertileWindow: notifyFertileWindow,
                notifyOvulation: notifyOvulation,
                notifyPeriodLate: notifyPeriodLate,
                notifyPms: notifyPms,
                reminderHour: reminderHour,
                reminderMinute: reminderMinute,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyLogsTableTableManager get dailyLogs =>
      $$DailyLogsTableTableManager(_db, _db.dailyLogs);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
