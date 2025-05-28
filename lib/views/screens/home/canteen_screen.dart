import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/providers/canteen_providers.dart';

class CanteenScreen extends ConsumerWidget {
  const CanteenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canteenAsync = ref.watch(canteenProvider);

    return Scaffold(
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Container(
              color: Colors.black,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Color(0xFF121212),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.restaurant, color: Colors.white, size: 28),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Današnja ponuda',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    canteenAsync.when(
                      data: (canteen) => canteen != null
                          ? Card(
                              color: Colors.white.withOpacity(0.10),
                              elevation: 10,
                              shadowColor: Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _MenuRow(number: 1, menu: canteen.menu1 ?? '-'),
                                    Divider(color: Colors.white12, thickness: 1, height: 32),
                                    _MenuRow(number: 2, menu: canteen.menu2 ?? '-'),
                                    Divider(color: Colors.white12, thickness: 1, height: 32),
                                    _MenuRow(number: 3, menu: canteen.menu3 ?? '-'),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Center(
                                child: Text(
                                  "Trenutno nema ponude.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                      loading: () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 64.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      error: (error, stack) => Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: Text(
                            'Došlo je do greške: $error',
                            style: TextStyle(color: Colors.redAccent, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Moderni prikaz menija kao poseban widget
class _MenuRow extends StatelessWidget {
  final int number;
  final String menu;

  const _MenuRow({required this.number, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Text(
            '$number',
            style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            menu,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
