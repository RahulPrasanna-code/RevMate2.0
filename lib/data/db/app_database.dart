import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Bikes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get catalogueId => text()();
  TextColumn get nickname => text().nullable()();
  IntColumn get currentOdometer => integer().withDefault(const Constant(0))();
}

class LogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bikeId => integer().references(Bikes, #id)();
  TextColumn get type => text()(); // fuel | tyre_pressure | chain_service
  DateTimeColumn get date => dateTime()();
  IntColumn get odometer => integer()();
  TextColumn get payload => text()(); // JSON string
}

@DriftDatabase(tables: [Bikes, LogEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'revmate'));

  @override
  int get schemaVersion => 1;
}
