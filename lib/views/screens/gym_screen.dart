import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/data/models/gym_membership.dart';
import 'package:mojtrsat/viewmodels/providers.dart';
import 'package:uuid/uuid.dart';

class GymScreen extends ConsumerStatefulWidget {
  const GymScreen({super.key});

  @override
  ConsumerState<GymScreen> createState() => _GymScreenState();
}

class _GymScreenState extends ConsumerState<GymScreen> {
  final List<String> memberhipTypes = [
    "Mjesecna",
    "Tromjesecna",
    "Godišnja",
    "Dnevna"
  ];

  String selectedMembershipType = "Mjesecna";
  int selectedLength = 30;

  @override
  void initState() {
    super.initState();
    ref.read(gymViewModelProvider.notifier).fetchGymMembership();
  }

  @override
  Widget build(BuildContext context) {
    final membershipAsync = ref.watch(gymViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Teretana', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            membershipAsync.when(
              data: (membership) {
                if (membership?.membershipType == null) {
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedMembershipType,
                        dropdownColor: Colors.grey[900],
                        decoration: const InputDecoration(
                          labelText: "Vrsta članarine",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        items: memberhipTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type, style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMembershipType = value!;
                            switch (value) {
                              case "Mjesecna":
                                selectedLength = 30;
                                break;
                              case "Tromjesecna":
                                selectedLength = 90;
                                break;
                              case "Godišnja":
                                selectedLength = 365;
                                break;
                              case "Dnevna":
                                selectedLength = 1;
                                break;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final userId = ref.read(authRepositoryProvider).supabaseClient.auth.currentUser?.id;
                          if (userId == null) return;

                          final uuid = Uuid();
                          final newMembership = GymMembership(
                            membershipID: uuid.v4(),
                            userID: userId,
                            membershipType: selectedMembershipType,
                            membershipLength: selectedLength,
                            membershipDaysLeft: selectedLength,
                            membershipHistory: [selectedMembershipType],
                            createdAt: DateTime.now(),
                          );

                          await ref.read(gymViewModelProvider.notifier).addGymMembership(newMembership);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text('Učlani se', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trenutna aktivna clanarina: ${membership?.membershipType}, istječe za ${membership?.membershipDaysLeft} dana.',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await ref.read(gymViewModelProvider.notifier).removeGymMembership();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Odjavi se iz teretane'),
                    ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Greška: $e', style: TextStyle(color: Colors.red)),
            ),

            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Povijest članstva',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: membershipAsync.when(
                data: (membership) {
                  if (membership == null || membership.membershipHistory.isEmpty) {
                    return const Center(child: Text('Nema povijesti', style: TextStyle(color: Colors.white)));
                  }

                  return ListView.builder(
                    itemCount: membership.membershipHistory.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${membership.membershipHistory[index]}, kupljeno: ${membership.createdAt.day}/${membership.createdAt.month}/${membership.createdAt.year}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Greška: $e', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
