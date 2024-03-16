import 'package:flutter/material.dart';
import 'chat_details.dart'; // Import the new chat details page

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Romeo Seva III',
      'image': 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Romeo.jpg',
      'lastMessage': 'Hi there!',
      'time': '10:00 AM',
      'date': 'Mar 15',
      'status': 'Online',
    },
    {
      'name': 'Russ Allen Garde',
      'image': 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Russ.jpg',
      'lastMessage': 'Hello!',
      'time': '11:30 AM',
      'date': 'Mar 15',
      'status': 'Offline',
    },
    {
      'name': 'Argian Nichole Cortez',
      'image': 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Argian.jpg',
      'lastMessage': 'Hey!',
      'time': '1:45 PM',
      'date': 'Mar 15',
      'status': 'Online',
    },
    {
      'name': 'Joshua Anton Magbanua',
      'image': 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Anton.jpg',
      'lastMessage': 'Hi again!',
      'time': '3:00 PM',
      'date': 'Mar 15',
      'status': 'Offline',
    },
    {
      'name': 'John Armor Espinosa',
      'image': 'https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Armor.jpg',
      'lastMessage': 'Good evening!',
      'time': '5:20 PM',
      'date': 'Mar 15',
      'status': 'Online',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user['image']),
          ),
          title: Text(user['name']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      user['lastMessage'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${user['time']} - ${user['date']}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    user['status'] == 'Online' ? Icons.circle : Icons.circle_outlined,
                    color: user['status'] == 'Online' ? Colors.green : Colors.red,
                    size: 12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    user['status'],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatDetailsPage(user: user)),
            );
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatPage(),
  ));
}
