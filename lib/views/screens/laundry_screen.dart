import 'package:flutter/material.dart';

class LaundryScreen extends StatefulWidget {
  const LaundryScreen({super.key});

  @override
  _LaundryScreenState createState() => _LaundryScreenState();
}

class _LaundryScreenState extends State<LaundryScreen> {
  int selectedDayIndex = 0;
  int? selectedTimeSlot;
  int? selectedMachine;
  int numberOfSlots = 1;
  final List<String> days = ['Pon', 'Uto', 'Sri', 'Čet', 'Pet', 'Sub', 'Ned'];
  final List<String> timeSlots = [
    '08:00 - 08:30',
    '08:30 - 09:00',
    '09:00 - 09:30',
    '09:30 - 10:00',
    '10:00 - 10:30',
    '10:30 - 11:00'
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
        title: const Text('Praonica'),
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
                      Navigator.pop(context);
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
