import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/providers/canteen_providers.dart';
import 'package:mojtrsat/providers/news_providers.dart';
import 'package:mojtrsat/providers/student_providers.dart';
import 'package:mojtrsat/views/widgets/news_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // displaying canteen data, news articles and student info when the screen is initialized
    ref.read(canteenProvider);
    ref.read(newsProvider);
    ref.read(studentProvider);
  }

  @override
  Widget build(BuildContext context) {
    final canteen = ref.watch(canteenProvider);
    final student = ref.watch(studentProvider);
    var today =DateTime.now();

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
                  "Bok, ${student.value?.name}",
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
              '${today.day}.${today.month}.${today.year}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push('/canteen');
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
                          student.when(
                            data: (student) => student != null
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32, left: 16),
                                    child: Text(
                                      '${student.amountSpent} / ${student.amountDaily} eur',
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
                          canteen.when(
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
                  route: '/gym'
                ),
                _buildStatusCard(
                  icon: Icons.access_time,
                  title: "Slobodni termini",
                  time: "8.00 - 8.30",
                  color: Colors.greenAccent,
                  route: '/laundry' 
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

  //AI Generated templeate for status card and news card

  Widget _buildStatusCard({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
    required String route
  }) {
    return Expanded(
      child: Card(
        color: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Color(0x00121212),
        child:
        GestureDetector(
          onTap: () {
            context.push(route);
          },
          child: 
        Padding(
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
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    )
    );
  }

Widget _buildNewsCard(BuildContext context) {
  final newsAsync = ref.watch(newsProvider);

  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.47,
    width: MediaQuery.of(context).size.width,
    child: Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      shadowColor: const Color(0x00121212),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  
                  Expanded(
                    child: newsAsync.when(
                      data: (news) => news.isEmpty
                          ? const Text("Nema vijesti", style: TextStyle(color: Colors.white))
                          : ListView.builder(
                              padding: EdgeInsets.zero,  
                              itemCount: news.length,
                              itemBuilder: (context, index) {
                                final article = news[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 3),
                                  child: NewsCard(
                                    title: article.title,
                                    link: article.link,
                                    imageUrl: article.imageUrl,
                                  ),
                                );
                              },
                            ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Text("Greška: $e", style: const TextStyle(color: Colors.red)),
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
