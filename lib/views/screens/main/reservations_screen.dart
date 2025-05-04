import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Rezervacije',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,fontFamily: 'Poppins'),
                  
            ),
            const SizedBox(height: 16),
            const Text(
                'Odaberi uslugu koju želiš rezervirati',
                style: TextStyle(fontSize: 16, color: Colors.white,fontFamily: 'Poppins'),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: const [
                  CategoryCard(
                      title: 'Praonica',
                      subtitle: 'Rezerviraj termin za pranje veša',
                      route: '/laundry'),
                  CategoryCard(
                      title: 'Oprema',
                      subtitle: 'Rezerviraj sportsku i tehničku opremu',
                      route: '/laundry'),
                  CategoryCard(
                      title: 'Trening',
                      subtitle: 'Rezerviraj termin za trening u teretani',
                      route: '/laundry'),
                  CategoryCard(
                      title: 'Snack Bar',
                      subtitle: 'Rezerviraj mjesto ili narudžbu u snack baru',
                      route: '/laundry'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;

  const CategoryCard({super.key, required this.title, required this.subtitle, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onTap: () => context.push(route),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ));
  }
}
