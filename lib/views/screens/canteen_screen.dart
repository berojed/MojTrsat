import 'package:flutter/material.dart';
import 'package:mojtrsat/data/models/canteen.dart';
import 'package:mojtrsat/viewmodels/homeViewModel.dart';
import 'package:provider/provider.dart';

class CanteenScreen extends StatefulWidget {
  const CanteenScreen({super.key});

  @override
  _CanteenScreenState createState() => _CanteenScreenState();
}

class _CanteenScreenState extends State<CanteenScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).getCanteen();
  }

  @override
  Widget build(BuildContext context) {
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
                Padding(padding: const EdgeInsets.only(left: 160.0), child: IconButton(onPressed: () {

                }, icon: Icon(Icons.notifications), color: Colors.white, iconSize: 30.0,))
                
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
            SizedBox(height: 15),
            Consumer<HomeViewModel>(
              builder: (context, homeViewModel, child) {
                Canteen? canteen = homeViewModel.canteen;
                return Card(
                  shadowColor: Color(0x00121212),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  color: Color(0xFF1E1E1E),
                  margin: EdgeInsets.all(25.0),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: canteen != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: 
                                Row(
                                  children: [
                                    Icon(Icons.menu_book, color: Colors.white,size: 26,),
                                     Text('  MENI',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                                    
                                  ],
                                )
                               
                              ),
                              
                              SizedBox(height: 10),
                              Text(
                                '1. ${canteen.menu1}',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                '2. ${canteen.menu2}',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                '3. ${canteen.menu3}',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              
                            ],
                          )
                        : Text(
                            "No canteen available.",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
