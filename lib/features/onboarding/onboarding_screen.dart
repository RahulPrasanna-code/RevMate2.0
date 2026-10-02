import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/catalogue/bike_catalogue.dart';
import '../../data/db/app_database.dart';
import '../../data/providers.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  Future<void> _pick(
    BuildContext context,
    WidgetRef ref,
    CatalogueBike bike,
  ) async {
    final controller = TextEditingController();
    final odo = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(bike.displayName),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Current odometer (km)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, int.tryParse(controller.text) ?? 0),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (odo == null) return;

    final db = ref.read(databaseProvider);
    await db
        .into(db.bikes)
        .insert(
          BikesCompanion.insert(
            catalogueId: bike.id,
            currentOdometer: Value(odo),
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogue = ref.watch(catalogueProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your bike')),
      body: catalogue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (bikes) => ListView.builder(
          itemCount: bikes.length,
          itemBuilder: (_, i) => ListTile(
            leading: const Icon(Icons.two_wheeler),
            title: Text(bikes[i].displayName),
            subtitle: Text('${bikes[i].tankLitres} L tank'),
            onTap: () => _pick(context, ref, bikes[i]),
          ),
        ),
      ),
    );
  }
}
