import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/viewmodels/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).getCanteen();
  }

  @override
  Widget build(BuildContext context) {
    final canteenAsync = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                  "Bok, Bernard!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 160.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications),
                      color: Colors.white,
                      iconSize: 30.0,
                    ))
              ],
            ),
            SizedBox(height: 2),
            Text(
              "Subota, 9. lipanj",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.go('/canteen');
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  color: Color.fromRGBO(30, 30, 30, 1),
                  shadowColor: Color(0x00121212),
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Potrošeno danas',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          canteenAsync.when(
                            data: (canteen) => canteen != null
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32, left: 16),
                                    child: Text(
                                      "   0/5.32€",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                  )
                                : Text('No data'),
                            loading: () => CircularProgressIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Column(
                        children: [
                          Text('Radno vrijeme',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          canteenAsync.when(
                            data: (canteen) => canteen != null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      '  ${canteen.workingHours_weekday.split(" ")[0]}\n${canteen.workingHours_weekday.split(" ")[1]}\n\n  ${canteen.workingHours_weekend.split(",")[0]}\n${canteen.workingHours_weekend.split(",")[1]}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Text('No data'),
                            loading: () => CircularProgressIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusCard(
                  icon: Icons.fitness_center,
                  title: "Nedostupnost teretane",
                  time: "18.45 - 20.45",
                  color: Colors.redAccent,
                ),
                _buildStatusCard(
                  icon: Icons.access_time,
                  title: "Slobodni termini",
                  time: "8.00 - 8.30",
                  color: Colors.greenAccent,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildNewsCard(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //AI Generated from here

  Widget _buildStatusCard({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Color(0x00121212),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    time,
                    style: TextStyle(
                        color: color, fontSize: 14, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadowColor: Color(0x00121212),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/flutter_logo.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Vijesti",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 34),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        children: [
                          TextSpan(
                              text: "Porast minimalne studentske satnice s "),
                          TextSpan(
                            text: "5.5\$ na 6.06\$ od 1.1.2025. ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "Više",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
