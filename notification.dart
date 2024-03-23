import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742), // Match the color of the bottom navigation bar
        title: Text(
          'Notifications', // Change the title text to "Notifications"
          style: TextStyle(color: Colors.white), // Make the title text color white
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          NotificationItem(
            title: 'Promotions: Loyal Customer',
            message: 'Claim your Php100.00 discount voucher!',
            time: '8:00 AM',
          ),
          NotificationItem(
            title: 'Book Recommendation',
            message: 'A new book has been posted and is available near you!',
            time: '2 days ago',
          ),
          NotificationItem(
            title: 'Update Available',
            message: 'A new version of the app is available for download.',
            time: '3 days ago',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      onTap: () {
        // Handle tapping on notification item
        // For example, navigate to a specific page or show more details
      },
    );
  }
}
