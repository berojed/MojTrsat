import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/providers/canteen_providers.dart';

class CanteenScreen extends ConsumerWidget {
  const CanteenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canteenAsync = ref.watch(canteenProvider);

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
                Icon(Icons.restaurant, color: Colors.white, size: 26),
                SizedBox(width: 10),
                Text(
                  'Današnja ponuda',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ],
            ),
            SizedBox(height: 15),
            canteenAsync.when(
              data: (canteen) => canteen != null
                  ? Expanded(child: Card(
                    
                      shadowColor: Color(0x00121212),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      color: Color(0xFF1E1E1E),
                      margin: EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text(
                              '1. ${canteen.menu1}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 40),
                            Text(
                              '2. ${canteen.menu2}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 40),
                            Text(
                              '3. ${canteen.menu3}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),) 
                  : Text(
                      "No canteen available.",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
