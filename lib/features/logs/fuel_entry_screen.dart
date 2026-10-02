import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/providers.dart';

class FuelEntryScreen extends ConsumerStatefulWidget {
  final Bike bike;
  const FuelEntryScreen({super.key, required this.bike});

  @override
  ConsumerState<FuelEntryScreen> createState() => _FuelEntryScreenState();
}

class _FuelEntryScreenState extends ConsumerState<FuelEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _odo = TextEditingController(
    text: widget.bike.currentOdometer.toString(),
  );
  final _litres = TextEditingController();
  final _cost = TextEditingController();
  DateTime _date = DateTime.now();
  bool _fullTank = true;

  @override
  void dispose() {
    _odo.dispose();
    _litres.dispose();
    _cost.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
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

    await db
        .into(db.logEntries)
        .insert(
          LogEntriesCompanion.insert(
            bikeId: widget.bike.id,
            type: 'fuel',
            date: _date,
            odometer: odo,
            payload: jsonEncode({
              'litres': double.parse(_litres.text),
              'cost': double.parse(_cost.text),
              'fullTank': _fullTank,
            }),
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
      appBar: AppBar(title: const Text('Add fuel')),
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
              validator: _required,
            ),
            TextFormField(
              controller: _litres,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Litres'),
              validator: _required,
            ),
            TextFormField(
              controller: _cost,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Total cost (₹)'),
              validator: _required,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Filled to full tank'),
              subtitle: const Text('Needed for accurate mileage'),
              value: _fullTank,
              onChanged: (v) => setState(() => _fullTank = v),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
