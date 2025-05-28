import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mojtrsat/data/models/event.dart';
import 'package:mojtrsat/providers/events_provider.dart';
import 'package:uuid/uuid.dart';


class AddEventScreen extends ConsumerStatefulWidget {
  const AddEventScreen({super.key});

  @override
  ConsumerState<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends ConsumerState<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 18, minute: 0),
      );
      if (time != null) {
        setState(() {
          _selectedDate = date;
          _selectedTime = time;
        });
      }
    }
  }

  void _saveEvent() async {
    if (!_formKey.currentState!.validate() ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Molimo unesite sve podatke!")),
      );
      return;
    }

    final DateTime eventDate = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final uuid = const Uuid();

    final event = Event(
      eventID: uuid.v4(),
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      date: eventDate,
      location: _locationController.text.trim(),
      createdAt: DateTime.now(),
      attendees: [],
    );


    final eventViewModel = ref.read(eventsViewModelProvider.notifier);
    final success = await eventViewModel.createEvent(event);

    if (success && mounted) {
      ref.invalidate(eventsViewModelProvider);
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Greška pri spremanju eventa.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateString = _selectedDate == null || _selectedTime == null
        ? "Odaberi datum i vrijeme"
        : DateFormat("dd.MM.yyyy. HH:mm").format(
            DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            ),
          );

    final isLoading = ref.watch(eventsViewModelProvider).maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodaj novi event", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Naslov eventa",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? "Unesi naslov" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: "Opis",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (v) => v == null || v.trim().isEmpty ? "Unesi opis" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: "Lokacija",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? "Unesi lokaciju" : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                onTap: () => _pickDateTime(context),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: Text(dateString),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(150, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isLoading ? null : _saveEvent,
                  icon: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.save),
                  label: Text(isLoading ? "Spremam..." : "Spremi"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
