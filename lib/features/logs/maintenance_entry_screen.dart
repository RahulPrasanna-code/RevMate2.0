import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/providers.dart';

enum MaintenanceKind { tyrePressure, chainService }

class MaintenanceEntryScreen extends ConsumerStatefulWidget {
  final Bike bike;
  final MaintenanceKind kind;
  const MaintenanceEntryScreen({
    super.key,
    required this.bike,
    required this.kind,
  });

  @override
  ConsumerState<MaintenanceEntryScreen> createState() =>
      _MaintenanceEntryScreenState();
}

class _MaintenanceEntryScreenState
    extends ConsumerState<MaintenanceEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _odo = TextEditingController(
    text: widget.bike.currentOdometer.toString(),
  );
  final _front = TextEditingController();
  final _rear = TextEditingController();
  DateTime _date = DateTime.now();
  String _action = 'Lubed';

  bool get _isTyre => widget.kind == MaintenanceKind.tyrePressure;

  @override
  void dispose() {
    _odo.dispose();
    _front.dispose();
    _rear.dispose();
    super.dispose();
  }

  String? _number(String? v) =>
      (v == null || double.tryParse(v) == null) ? 'Enter a number' : null;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(databaseProvider);
    final odo = int.parse(_odo.text);

    final payload = _isTyre
        ? {'front': double.parse(_front.text), 'rear': double.parse(_rear.text)}
        : {'action': _action};

    await db
        .into(db.logEntries)
        .insert(
          LogEntriesCompanion.insert(
            bikeId: widget.bike.id,
            type: _isTyre ? 'tyre_pressure' : 'chain_service',
            date: _date,
            odometer: odo,
            payload: jsonEncode(payload),
          ),
        );

    if (odo > widget.bike.currentOdometer) {
      await (db.update(db.bikes)..where((b) => b.id.equals(widget.bike.id)))
          .write(BikesCompanion(currentOdometer: Value(odo)));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isTyre ? 'Log tyre pressure' : 'Log chain service'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date'),
              subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            TextFormField(
              controller: _odo,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Odometer (km)'),
              validator: _number,
            ),
            if (_isTyre) ...[
              TextFormField(
                controller: _front,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Front pressure (psi)',
                ),
                validator: _number,
              ),
              TextFormField(
                controller: _rear,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Rear pressure (psi)',
                ),
                validator: _number,
              ),
            ] else
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: DropdownButtonFormField<String>(
                  initialValue: _action,
                  decoration: const InputDecoration(labelText: 'What was done'),
                  items:
                      const ['Lubed', 'Cleaned & lubed', 'Adjusted', 'Replaced']
                          .map(
                            (a) => DropdownMenuItem(value: a, child: Text(a)),
                          )
                          .toList(),
                  onChanged: (v) => setState(() => _action = v!),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
