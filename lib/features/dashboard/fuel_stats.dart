import 'dart:convert';
import '../../data/db/app_database.dart';

class FuelFill {
  final DateTime date;
  final int odometer;
  final double litres, cost;
  final bool fullTank;
  const FuelFill(
    this.date,
    this.odometer,
    this.litres,
    this.cost,
    this.fullTank,
  );
}

List<FuelFill> fuelFills(List<LogEntry> logs) {
  final fills = logs.where((l) => l.type == 'fuel').map((l) {
    final p = jsonDecode(l.payload) as Map<String, dynamic>;
    return FuelFill(
      l.date,
      l.odometer,
      (p['litres'] as num).toDouble(),
      (p['cost'] as num).toDouble(),
      p['fullTank'] as bool,
    );
  }).toList();
  fills.sort((a, b) => a.odometer.compareTo(b.odometer));
  return fills;
}

/// Average km/l between the first and last full-tank fills.
double? avgKmPerLitre(List<FuelFill> fills) {
  final full = [
    for (var i = 0; i < fills.length; i++)
      if (fills[i].fullTank) i,
  ];
  if (full.length < 2) return null;
  final first = full.first, last = full.last;
  final km = fills[last].odometer - fills[first].odometer;
  var litres = 0.0;
  for (var i = first + 1; i <= last; i++) {
    litres += fills[i].litres;
  }
  return (km > 0 && litres > 0) ? km / litres : null;
}

double spendThisMonth(List<FuelFill> fills) {
  final now = DateTime.now();
  return fills
      .where((f) => f.date.year == now.year && f.date.month == now.month)
      .fold(0.0, (sum, f) => sum + f.cost);
}
