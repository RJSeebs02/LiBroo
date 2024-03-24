import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('About Us',
        style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Developers of Libroo',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20,),
            // Add circular avatars of the developers here
            // Example:
            CircleAvatar(
              backgroundImage: NetworkImage('https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg'),
              radius: 50,
            ),
            Text(
              'Elijah Zachary Faeldonea',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 50,),
            CircleAvatar(
              backgroundImage: NetworkImage('https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Russ.jpg'),
              radius: 50,
            ),
            Text(
              'Russ Allen Garde',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 50,),
            CircleAvatar(
              backgroundImage: NetworkImage('https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Romeo.jpg'),
              radius: 50,
            ),
            Text(
              'Romeo Seva III',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
