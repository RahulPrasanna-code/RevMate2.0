import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/providers.dart';
import '../logs/fuel_entry_screen.dart';
import '../logs/maintenance_entry_screen.dart';
import 'fuel_stats.dart';
import 'maintenance_stats.dart';

class DashboardScreen extends ConsumerWidget {
  final Bike bike;
  const DashboardScreen({super.key, required this.bike});

  void _open(BuildContext context, Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text('Fuel'),
              onTap: () {
                Navigator.pop(ctx);
                _open(context, FuelEntryScreen(bike: bike));
              },
            ),
            ListTile(
              leading: const Icon(Icons.tire_repair),
              title: const Text('Tyre pressure'),
              onTap: () {
                Navigator.pop(ctx);
                _open(
                  context,
                  MaintenanceEntryScreen(
                    bike: bike,
                    kind: MaintenanceKind.tyrePressure,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Chain service'),
              onTap: () {
                Navigator.pop(ctx);
                _open(
                  context,
                  MaintenanceEntryScreen(
                    bike: bike,
                    kind: MaintenanceKind.chainService,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsProvider(bike.id)).value ?? [];
    final catalogue = ref.watch(catalogueProvider).value ?? [];

    final fills = fuelFills(logs);
    final avg = avgKmPerLitre(fills);
    final lastFill = fills.isEmpty ? null : fills.last;

    // Tyre pressure
    final tyre = latestOfType(logs, 'tyre_pressure');
    final tyreValue = tyre == null
        ? '—'
        : 'F ${payloadOf(tyre)['front']} · R ${payloadOf(tyre)['rear']}';

    // Chain due logic
    final chain = latestOfType(logs, 'chain_service');
    final matches = catalogue.where((c) => c.id == bike.catalogueId);
    String chainValue = '—';
    bool overdue = false;
    if (chain != null && matches.isNotEmpty) {
      final interval = matches.first.chainLubeIntervalKm;
      final due = chain.odometer + interval - bike.currentOdometer;
      overdue = due < 0;
      chainValue = overdue ? 'Overdue ${-due} km' : 'Due in $due km';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('RevMate')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add log'),
        onPressed: () => _showAddSheet(context),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: [
          _StatCard(
            icon: Icons.speed,
            label: 'Odometer',
            value: '${bike.currentOdometer} km',
          ),
          _StatCard(
            icon: Icons.local_gas_station,
            label: 'Last fill',
            value: lastFill == null
                ? '—'
                : '${lastFill.litres.toStringAsFixed(1)} L\n₹${lastFill.cost.toStringAsFixed(0)}',
          ),
          _StatCard(
            icon: Icons.currency_rupee,
            label: 'Fuel spend (this month)',
            value: '₹${spendThisMonth(fills).toStringAsFixed(0)}',
          ),
          _StatCard(
            icon: Icons.eco,
            label: 'Avg mileage',
            value: avg == null ? '—' : '${avg.toStringAsFixed(1)} km/l',
          ),
          _StatCard(
            icon: Icons.tire_repair,
            label: 'Tyre pressure (psi)',
            value: tyreValue,
          ),
          _StatCard(
            icon: Icons.link,
            label: 'Chain lube',
            value: chainValue,
            valueColor: overdue ? Theme.of(context).colorScheme.error : null,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color? valueColor;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Card(
      elevation: 0,
      color: t.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: valueColor ?? t.colorScheme.primary),
            const Spacer(),
            Text(
              value,
              style: t.textTheme.titleLarge?.copyWith(color: valueColor),
            ),
            const SizedBox(height: 4),
            Text(label, style: t.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
