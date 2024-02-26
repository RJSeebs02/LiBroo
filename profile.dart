import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_image.png'), // Placeholder image
            ),
            SizedBox(height: 16),
            Text(
              'Elijah Zachary Faeldonea',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Classic Member',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('boieloi@example.com'),
              onTap: () {
                // Handle tapping on email item
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+639385294825'),
              onTap: () {
                // Handle tapping on phone number item
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Lot 32, Block 17, City Heights Subdivision, Ruby St. corner Sapphire St., Brgy. Taculing, Bacolod City, Negros Occidental'),
              onTap: () {
                // Handle tapping on location item
              },
            ),
          ],
        ),
      ),
    );
  }
}
