import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'catalogue/bike_catalogue.dart';
import 'db/app_database.dart';

import 'package:drift/drift.dart' show OrderingTerm;

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final catalogueProvider = FutureProvider<List<CatalogueBike>>(
  (ref) => loadCatalogue(),
);

final bikesProvider = StreamProvider<List<Bike>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.bikes).watch();
});

final logsProvider = StreamProvider.family<List<LogEntry>, int>((ref, bikeId) {
  final db = ref.watch(databaseProvider);
  final query = db.select(db.logEntries)
    ..where((t) => t.bikeId.equals(bikeId))
    ..orderBy([(t) => OrderingTerm.desc(t.date)]);
  return query.watch();
});
