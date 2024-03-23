import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 55, 66), // Same color as main.dart
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey, // Same background color as main.dart
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your username',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform login action
                Navigator.pop(context); // Navigate back to the previous screen (home page)
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 57, 55, 66), // Same color as main.dart
              ),
            ),
          ],
        ),
      ),
    );
  }
}