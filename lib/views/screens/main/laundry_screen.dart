import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/viewmodels/laundryViewmodel.dart';
import 'package:mojtrsat/data/models/laundry.dart';
import 'package:mojtrsat/viewmodels/providers.dart';

class LaundryScreen extends ConsumerStatefulWidget {
  const LaundryScreen({super.key});

  @override
  _LaundryScreenState createState() => _LaundryScreenState();
}

class _LaundryScreenState extends ConsumerState<LaundryScreen> {
  int selectedDayIndex = 0;
  int? selectedTimeSlot;
  int? selectedMachine;
  int numberOfSlots = 1;
  final List<String> days = ['Pon', 'Uto', 'Sri', 'Čet', 'Pet', 'Sub', 'Ned'];
  final List<String> timeSlots = [
    '00:00 - 00:30',
    '00:30 - 01:00',
    '01:00 - 01:30',
    '01:30 - 02:00',
    '02:00 - 02:30',
    '02:30 - 03:00',
    '03:00 - 03:30',
    '03:30 - 04:00',
    '04:00 - 04:30',
    '04:30 - 05:00',
    '05:00 - 05:30',
    '05:30 - 06:00',
    '06:00 - 06:30',
    '06:30 - 07:00',
    '07:00 - 07:30',
    '07:30 - 08:00',
    '08:00 - 08:30',
    '08:30 - 09:00',
    '09:00 - 09:30',
    '09:30 - 10:00',
    '10:00 - 10:30',
    '10:30 - 11:00',
    '11:00 - 11:30',
    '11:30 - 12:00',
    '12:00 - 12:30',
    '12:30 - 13:00',
    '13:00 - 13:30',
    '13:30 - 14:00',
    '14:00 - 14:30',
    '14:30 - 15:00',
    '15:00 - 15:30',
    '15:30 - 16:00',
    '16:00 - 16:30',
    '16:30 - 17:00',
    '17:00 - 17:30',
    '17:30 - 18:00',
    '18:00 - 18:30',
    '18:30 - 19:00',
    '19:00 - 19:30',
    '19:30 - 20:00',
    '20:00 - 20:30',
    '20:30 - 21:00',
    '21:00 - 21:30',
    '21:30 - 22:00',
    '22:00 - 22:30',
    '22:30 - 23:00',
    '23:00 - 23:30',
    '23:30 - 00:00',
  ];

  void confirmReservation() {
    if (selectedTimeSlot != null && selectedMachine != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Termin rezerviran!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Praonica',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selectedDayIndex == index
                            ? Colors.blue
                            : Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        days[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0), // Add vertical spacing
                    child: ListTile(
                      title: Text(timeSlots[index],
                          style: const TextStyle(color: Colors.white)),
                      tileColor: selectedTimeSlot == index
                          ? Colors.blue
                          : Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        setState(() {
                          selectedTimeSlot = index;
                        });
                        _showMachineSelectionDialog();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMachineSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text('Odaberi mašinu',
                  style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    value: selectedMachine,
                    dropdownColor: Colors.grey[900],
                    hint: const Text('Odaberi broj mašine',
                        style: TextStyle(color: Colors.white)),
                    items: List.generate(5, (index) => index + 1)
                        .map((machine) => DropdownMenuItem(
                              value: machine,
                              child: Text('Mašina $machine',
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setDialogState(() {

                        selectedMachine = value;
                      
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Broj slotova:',
                      style: TextStyle(color: Colors.white)),
                  Slider(
                    value: numberOfSlots.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    label: '$numberOfSlots',
                    onChanged: (value) {
                      setDialogState(() {
                        numberOfSlots = value.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final laundryViewModel =
                          ref.read(laundryViewModelProvider.notifier);
                      Navigator.pop(context);
                      laundryViewModel.createLaundrySlot(
                          selectedMachine!,
                          timeSlots[selectedTimeSlot!],
                          days[selectedDayIndex]);
                      confirmReservation();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Uzmi termin'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
