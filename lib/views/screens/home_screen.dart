import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mojtrsat/viewmodels/providers.dart';
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
    ref.read(canteenViewModelProvider.notifier).getCanteen();
    ref.read(newsViewModelProvider.notifier).getNews();
    ref.read(studentViewModelProvider.notifier).getStudentInfo();
  }

  @override
  Widget build(BuildContext context) {
    final canteenes = ref.watch(canteenViewModelProvider);
    final student = ref.watch(studentViewModelProvider);
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
                GestureDetector(
                  onTap: () async {
                    try {
                      context.push('/login');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Error during Google sign-up: $e')),
                      );
                    }
                  },
                  child: Icon(Icons.logout),
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
                          canteenes.when(
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

  //AI Generated templeate for status card and news card

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
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context) {
    final news = ref.watch(newsViewModelProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.47,
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
              //so that the text is not cut off
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vijesti",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                        child: news.isEmpty
                            ? Text(
                                "No news available",
                                style: TextStyle(color: Colors.white),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(2),
                                child: ListView.builder(
                                  itemCount: news.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: NewsCard(
                                            title: news[index]!.title,
                                            link: news[index]!.link,
                                            imageUrl: news[index]!.imageUrl));
                                  },
                                ),
                              )),
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
