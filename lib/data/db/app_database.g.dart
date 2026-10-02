// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BikesTable extends Bikes with TableInfo<$BikesTable, Bike> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BikesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _catalogueIdMeta = const VerificationMeta(
    'catalogueId',
  );
  @override
  late final GeneratedColumn<String> catalogueId = GeneratedColumn<String>(
    'catalogue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentOdometerMeta = const VerificationMeta(
    'currentOdometer',
  );
  @override
  late final GeneratedColumn<int> currentOdometer = GeneratedColumn<int>(
    'current_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    catalogueId,
    nickname,
    currentOdometer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bikes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bike> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('catalogue_id')) {
      context.handle(
        _catalogueIdMeta,
        catalogueId.isAcceptableOrUnknown(
          data['catalogue_id']!,
          _catalogueIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_catalogueIdMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('current_odometer')) {
      context.handle(
        _currentOdometerMeta,
        currentOdometer.isAcceptableOrUnknown(
          data['current_odometer']!,
          _currentOdometerMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bike map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bike(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      catalogueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catalogue_id'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      currentOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_odometer'],
      )!,
    );
  }

  @override
  $BikesTable createAlias(String alias) {
    return $BikesTable(attachedDatabase, alias);
  }
}

class Bike extends DataClass implements Insertable<Bike> {
  final int id;
  final String catalogueId;
  final String? nickname;
  final int currentOdometer;
  const Bike({
    required this.id,
    required this.catalogueId,
    this.nickname,
    required this.currentOdometer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['catalogue_id'] = Variable<String>(catalogueId);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['current_odometer'] = Variable<int>(currentOdometer);
    return map;
  }

  BikesCompanion toCompanion(bool nullToAbsent) {
    return BikesCompanion(
      id: Value(id),
      catalogueId: Value(catalogueId),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      currentOdometer: Value(currentOdometer),
    );
  }

  factory Bike.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bike(
      id: serializer.fromJson<int>(json['id']),
      catalogueId: serializer.fromJson<String>(json['catalogueId']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      currentOdometer: serializer.fromJson<int>(json['currentOdometer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'catalogueId': serializer.toJson<String>(catalogueId),
      'nickname': serializer.toJson<String?>(nickname),
      'currentOdometer': serializer.toJson<int>(currentOdometer),
    };
  }

  Bike copyWith({
    int? id,
    String? catalogueId,
    Value<String?> nickname = const Value.absent(),
    int? currentOdometer,
  }) => Bike(
    id: id ?? this.id,
    catalogueId: catalogueId ?? this.catalogueId,
    nickname: nickname.present ? nickname.value : this.nickname,
    currentOdometer: currentOdometer ?? this.currentOdometer,
  );
  Bike copyWithCompanion(BikesCompanion data) {
    return Bike(
      id: data.id.present ? data.id.value : this.id,
      catalogueId: data.catalogueId.present
          ? data.catalogueId.value
          : this.catalogueId,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      currentOdometer: data.currentOdometer.present
          ? data.currentOdometer.value
          : this.currentOdometer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bike(')
          ..write('id: $id, ')
          ..write('catalogueId: $catalogueId, ')
          ..write('nickname: $nickname, ')
          ..write('currentOdometer: $currentOdometer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, catalogueId, nickname, currentOdometer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bike &&
          other.id == this.id &&
          other.catalogueId == this.catalogueId &&
          other.nickname == this.nickname &&
          other.currentOdometer == this.currentOdometer);
}

class BikesCompanion extends UpdateCompanion<Bike> {
  final Value<int> id;
  final Value<String> catalogueId;
  final Value<String?> nickname;
  final Value<int> currentOdometer;
  const BikesCompanion({
    this.id = const Value.absent(),
    this.catalogueId = const Value.absent(),
    this.nickname = const Value.absent(),
    this.currentOdometer = const Value.absent(),
  });
  BikesCompanion.insert({
    this.id = const Value.absent(),
    required String catalogueId,
    this.nickname = const Value.absent(),
    this.currentOdometer = const Value.absent(),
  }) : catalogueId = Value(catalogueId);
  static Insertable<Bike> custom({
    Expression<int>? id,
    Expression<String>? catalogueId,
    Expression<String>? nickname,
    Expression<int>? currentOdometer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (catalogueId != null) 'catalogue_id': catalogueId,
      if (nickname != null) 'nickname': nickname,
      if (currentOdometer != null) 'current_odometer': currentOdometer,
    });
  }

  BikesCompanion copyWith({
    Value<int>? id,
    Value<String>? catalogueId,
    Value<String?>? nickname,
    Value<int>? currentOdometer,
  }) {
    return BikesCompanion(
      id: id ?? this.id,
      catalogueId: catalogueId ?? this.catalogueId,
      nickname: nickname ?? this.nickname,
      currentOdometer: currentOdometer ?? this.currentOdometer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (catalogueId.present) {
      map['catalogue_id'] = Variable<String>(catalogueId.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (currentOdometer.present) {
      map['current_odometer'] = Variable<int>(currentOdometer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BikesCompanion(')
          ..write('id: $id, ')
          ..write('catalogueId: $catalogueId, ')
          ..write('nickname: $nickname, ')
          ..write('currentOdometer: $currentOdometer')
          ..write(')'))
        .toString();
  }
}

class $LogEntriesTable extends LogEntries
    with TableInfo<$LogEntriesTable, LogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bikes (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bikeId,
    type,
    date,
    odometer,
    payload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bikeIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $LogEntriesTable createAlias(String alias) {
    return $LogEntriesTable(attachedDatabase, alias);
  }
}

class LogEntry extends DataClass implements Insertable<LogEntry> {
  final int id;
  final int bikeId;
  final String type;
  final DateTime date;
  final int odometer;
  final String payload;
  const LogEntry({
    required this.id,
    required this.bikeId,
    required this.type,
    required this.date,
    required this.odometer,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bike_id'] = Variable<int>(bikeId);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    map['odometer'] = Variable<int>(odometer);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  LogEntriesCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesCompanion(
      id: Value(id),
      bikeId: Value(bikeId),
      type: Value(type),
      date: Value(date),
      odometer: Value(odometer),
      payload: Value(payload),
    );
  }

  factory LogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntry(
      id: serializer.fromJson<int>(json['id']),
      bikeId: serializer.fromJson<int>(json['bikeId']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometer: serializer.fromJson<int>(json['odometer']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bikeId': serializer.toJson<int>(bikeId),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'odometer': serializer.toJson<int>(odometer),
      'payload': serializer.toJson<String>(payload),
    };
  }

  LogEntry copyWith({
    int? id,
    int? bikeId,
    String? type,
    DateTime? date,
    int? odometer,
    String? payload,
  }) => LogEntry(
    id: id ?? this.id,
    bikeId: bikeId ?? this.bikeId,
    type: type ?? this.type,
    date: date ?? this.date,
    odometer: odometer ?? this.odometer,
    payload: payload ?? this.payload,
  );
  LogEntry copyWithCompanion(LogEntriesCompanion data) {
    return LogEntry(
      id: data.id.present ? data.id.value : this.id,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntry(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bikeId, type, date, odometer, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntry &&
          other.id == this.id &&
          other.bikeId == this.bikeId &&
          other.type == this.type &&
          other.date == this.date &&
          other.odometer == this.odometer &&
          other.payload == this.payload);
}

class LogEntriesCompanion extends UpdateCompanion<LogEntry> {
  final Value<int> id;
  final Value<int> bikeId;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<int> odometer;
  final Value<String> payload;
  const LogEntriesCompanion({
    this.id = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.odometer = const Value.absent(),
    this.payload = const Value.absent(),
  });
  LogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int bikeId,
    required String type,
    required DateTime date,
    required int odometer,
    required String payload,
  }) : bikeId = Value(bikeId),
       type = Value(type),
       date = Value(date),
       odometer = Value(odometer),
       payload = Value(payload);
  static Insertable<LogEntry> custom({
    Expression<int>? id,
    Expression<int>? bikeId,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<int>? odometer,
    Expression<String>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bikeId != null) 'bike_id': bikeId,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (odometer != null) 'odometer': odometer,
      if (payload != null) 'payload': payload,
    });
  }

  LogEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? bikeId,
    Value<String>? type,
    Value<DateTime>? date,
    Value<int>? odometer,
    Value<String>? payload,
  }) {
    return LogEntriesCompanion(
      id: id ?? this.id,
      bikeId: bikeId ?? this.bikeId,
      type: type ?? this.type,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('bikeId: $bikeId, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BikesTable bikes = $BikesTable(this);
  late final $LogEntriesTable logEntries = $LogEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bikes, logEntries];
}

typedef $$BikesTableCreateCompanionBuilder =
    BikesCompanion Function({
      Value<int> id,
      required String catalogueId,
      Value<String?> nickname,
      Value<int> currentOdometer,
    });
typedef $$BikesTableUpdateCompanionBuilder =
    BikesCompanion Function({
      Value<int> id,
      Value<String> catalogueId,
      Value<String?> nickname,
      Value<int> currentOdometer,
    });

final class $$BikesTableReferences
    extends BaseReferences<_$AppDatabase, $BikesTable, Bike> {
  $$BikesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LogEntriesTable, List<LogEntry>>
  _logEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.logEntries,
    aliasName: 'bikes__id__log_entries__bike_id',
  );

  $$LogEntriesTableProcessedTableManager get logEntriesRefs {
    final manager = $$LogEntriesTableTableManager(
      $_db,
      $_db.logEntries,
    ).filter((f) => f.bikeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BikesTableFilterComposer extends Composer<_$AppDatabase, $BikesTable> {
  $$BikesTableFilterComposer({
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

  ColumnFilters<String> get catalogueId => $composableBuilder(
    column: $table.catalogueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> logEntriesRefs(
    Expression<bool> Function($$LogEntriesTableFilterComposer f) f,
  ) {
    final $$LogEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableFilterComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BikesTableOrderingComposer
    extends Composer<_$AppDatabase, $BikesTable> {
  $$BikesTableOrderingComposer({
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

  ColumnOrderings<String> get catalogueId => $composableBuilder(
    column: $table.catalogueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BikesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BikesTable> {
  $$BikesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get catalogueId => $composableBuilder(
    column: $table.catalogueId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => column,
  );

  Expression<T> logEntriesRefs<T extends Object>(
    Expression<T> Function($$LogEntriesTableAnnotationComposer a) f,
  ) {
    final $$LogEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.bikeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BikesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BikesTable,
          Bike,
          $$BikesTableFilterComposer,
          $$BikesTableOrderingComposer,
          $$BikesTableAnnotationComposer,
          $$BikesTableCreateCompanionBuilder,
          $$BikesTableUpdateCompanionBuilder,
          (Bike, $$BikesTableReferences),
          Bike,
          PrefetchHooks Function({bool logEntriesRefs})
        > {
  $$BikesTableTableManager(_$AppDatabase db, $BikesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BikesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BikesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BikesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> catalogueId = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<int> currentOdometer = const Value.absent(),
              }) => BikesCompanion(
                id: id,
                catalogueId: catalogueId,
                nickname: nickname,
                currentOdometer: currentOdometer,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String catalogueId,
                Value<String?> nickname = const Value.absent(),
                Value<int> currentOdometer = const Value.absent(),
              }) => BikesCompanion.insert(
                id: id,
                catalogueId: catalogueId,
                nickname: nickname,
                currentOdometer: currentOdometer,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BikesTable, Bike>(table),
                  $$BikesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({logEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (logEntriesRefs) db.logEntries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (logEntriesRefs)
                    await $_getPrefetchedData<Bike, $BikesTable, LogEntry>(
                      currentTable: table,
                      referencedTable: $$BikesTableReferences
                          ._logEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BikesTableReferences(db, table, p0).logEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bikeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BikesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BikesTable,
      Bike,
      $$BikesTableFilterComposer,
      $$BikesTableOrderingComposer,
      $$BikesTableAnnotationComposer,
      $$BikesTableCreateCompanionBuilder,
      $$BikesTableUpdateCompanionBuilder,
      (Bike, $$BikesTableReferences),
      Bike,
      PrefetchHooks Function({bool logEntriesRefs})
    >;
typedef $$LogEntriesTableCreateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      required int bikeId,
      required String type,
      required DateTime date,
      required int odometer,
      required String payload,
    });
typedef $$LogEntriesTableUpdateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      Value<int> bikeId,
      Value<String> type,
      Value<DateTime> date,
      Value<int> odometer,
      Value<String> payload,
    });

final class $$LogEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry> {
  $$LogEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BikesTable _bikeIdTable(_$AppDatabase db) =>
      db.bikes.createAlias('log_entries__bike_id__bikes__id');

  $$BikesTableProcessedTableManager get bikeId {
    final $_column = $_itemColumn<int>('bike_id')!;

    final manager = $$BikesTableTableManager(
      $_db,
      $_db.bikes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bikeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  $$BikesTableFilterComposer get bikeId {
    final $$BikesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableFilterComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  $$BikesTableOrderingComposer get bikeId {
    final $$BikesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableOrderingComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  $$BikesTableAnnotationComposer get bikeId {
    final $$BikesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bikeId,
      referencedTable: $db.bikes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BikesTableAnnotationComposer(
            $db: $db,
            $table: $db.bikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogEntriesTable,
          LogEntry,
          $$LogEntriesTableFilterComposer,
          $$LogEntriesTableOrderingComposer,
          $$LogEntriesTableAnnotationComposer,
          $$LogEntriesTableCreateCompanionBuilder,
          $$LogEntriesTableUpdateCompanionBuilder,
          (LogEntry, $$LogEntriesTableReferences),
          LogEntry,
          PrefetchHooks Function({bool bikeId})
        > {
  $$LogEntriesTableTableManager(_$AppDatabase db, $LogEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bikeId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String> payload = const Value.absent(),
              }) => LogEntriesCompanion(
                id: id,
                bikeId: bikeId,
                type: type,
                date: date,
                odometer: odometer,
                payload: payload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bikeId,
                required String type,
                required DateTime date,
                required int odometer,
                required String payload,
              }) => LogEntriesCompanion.insert(
                id: id,
                bikeId: bikeId,
                type: type,
                date: date,
                odometer: odometer,
                payload: payload,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LogEntriesTable, LogEntry>(table),
                  $$LogEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bikeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bikeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bikeId,
                                referencedTable: $$LogEntriesTableReferences
                                    ._bikeIdTable(db),
                                referencedColumn: $$LogEntriesTableReferences
                                    ._bikeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogEntriesTable,
      LogEntry,
      $$LogEntriesTableFilterComposer,
      $$LogEntriesTableOrderingComposer,
      $$LogEntriesTableAnnotationComposer,
      $$LogEntriesTableCreateCompanionBuilder,
      $$LogEntriesTableUpdateCompanionBuilder,
      (LogEntry, $$LogEntriesTableReferences),
      LogEntry,
      PrefetchHooks Function({bool bikeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BikesTableTableManager get bikes =>
      $$BikesTableTableManager(_db, _db.bikes);
  $$LogEntriesTableTableManager get logEntries =>
      $$LogEntriesTableTableManager(_db, _db.logEntries);
}
