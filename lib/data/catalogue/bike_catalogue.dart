import 'dart:convert';
import 'package:flutter/services.dart';

class CatalogueBike {
  final String id, make, model;
  final double tankLitres;
  final int chainLubeIntervalKm, chainServiceIntervalKm;

  const CatalogueBike({
    required this.id,
    required this.make,
    required this.model,
    required this.tankLitres,
    required this.chainLubeIntervalKm,
    required this.chainServiceIntervalKm,
  });

  factory CatalogueBike.fromJson(Map<String, dynamic> j) => CatalogueBike(
    id: j['id'],
    make: j['make'],
    model: j['model'],
    tankLitres: (j['tankLitres'] as num).toDouble(),
    chainLubeIntervalKm: j['chainLubeIntervalKm'],
    chainServiceIntervalKm: j['chainServiceIntervalKm'],
  );

  String get displayName => '$make $model';
}

Future<List<CatalogueBike>> loadCatalogue() async {
  final raw = await rootBundle.loadString('assets/bikes.json');
  return (jsonDecode(raw) as List)
      .map((e) => CatalogueBike.fromJson(e))
      .toList();
}
