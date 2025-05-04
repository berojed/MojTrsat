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

  int _mapMembershipToDays(String value) {
    switch (value) {
      case "Mjesecna":
        return 30;
      case "Tromjesecna":
        return 90;
      case "Godišnja":
        return 365;
      case "Dnevna":
        return 1;
      default:
        return 30;
    }
  }

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
        child: membershipAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Greška: $e', style: const TextStyle(color: Colors.red)),
          data: (membership) {
            final hasHistory = membership?.membershipHistory.isNotEmpty == true;
            final isActive = membership?.membershipType != null &&
                             membership?.membershipLength != null &&
                             membership!.membershipLength > 0; //made mistake here, instead of membershiplength>0, i checked membershiplength!=null

            return Column(
              children: [
                if (!isActive)
                  Column(
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
                            child: Text(type, style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMembershipType = value!;
                            selectedLength = _mapMembershipToDays(value);
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final userId = ref.read(authRepositoryProvider).supabaseClient.auth.currentUser?.id;
                          if (userId == null) return;

                          if (hasHistory) {
                            await ref.read(gymViewModelProvider.notifier).addGymMembershipAgain(
                                  selectedMembershipType,
                                  selectedLength,
                                );
                          } else {
                            final uuid = const Uuid();
                            final newMembership = GymMembership(
                              membershipID: uuid.v4(),
                              userID: userId,
                              membershipType: selectedMembershipType,
                              membershipLength: selectedLength,
                              membershipHistory: [selectedMembershipType],
                              createdAt: DateTime.now(),
                            );

                            await ref.read(gymViewModelProvider.notifier).createEmptyMembership(newMembership);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasHistory ? Colors.orange : Colors.green,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          hasHistory ? 'Učlani se ponovno' : 'Učlani se',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trenutna aktivna članarina: ${membership.membershipType}, istječe za ${membership.membershipLength - DateTime.now().difference(membership.createdAt).inDays} dana.',
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
                  child: Builder(
                    builder: (_) {
                      final history = membership?.membershipHistory ?? [];

                      if (history.isEmpty) {
                        return const Center(
                          child: Text('Nema povijesti', style: TextStyle(color: Colors.white)),
                        );
                      }

                      return ListView.builder(
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          final created = membership?.createdAt;
                          final dateStr = created != null
                              ? '${created.day}/${created.month}/${created.year}'
                              : 'Nepoznat datum';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '${history[index]}, kupljeno: $dateStr',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
