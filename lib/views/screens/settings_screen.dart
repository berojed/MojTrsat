import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Moj račun'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Add your logout logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/images/flutter_logo.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bernard Jedvaj',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      'Soba: 4070, 1 paviljon',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'Email: jedvajbernard@gmail.com',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'JMBAG: 043214291',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Add your edit profile logic here
                  },
                ),
              ],
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.inbox, color: Colors.white),
              title: Text('Inbox', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.white),
              title: Text('Plaćanja', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem, color: Colors.white),
              title:
                  Text('Prijavi štetu', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Postavke aplikacije',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.white),
              title: Text('FAQ', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.white),
              title: Text('Jezik', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.support, color: Colors.white),
              title: Text('Podrška', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add your navigation logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
