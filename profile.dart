import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'my_store.dart';
import 'edit_profile.dart';
import 'settings.dart';
import 'premium_subscription.dart'; // Import the premium subscription offer page
import 'about_us.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100), 
                      child: const Image(image: NetworkImage('https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PremiumSubscriptionPage()),
                  );
                },
                child: Text('Elijah', style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF393742), // Choose the color you prefer for the rectangle
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PremiumSubscriptionPage()),
                    );
                  },
                  child: Text(
                    'Premium User',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set the text color directly here
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width:200,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, side: BorderSide.none, shape: StadiumBorder()),
                  child: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
                )
              ),
              const SizedBox(height: 30),
              ProfileMenuWidget(
                title: "My Store",
                icon: Icons.monetization_on,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyStorePage()),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Settings",
                icon: Icons.settings,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              ProfileMenuWidget(
                title: "About Us",
                icon: Icons.question_answer,
                onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to the AboutUsPage
                  );
                },
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Logout",
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.1)
        ),
        child: Icon(icon, color:Colors.black)
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black, // Use textColor if not null, else use default color
        ),
      ),
      trailing: endIcon? Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.1),
        ),
        child: const Icon(Icons.arrow_right, size: 18.0, color: Colors.grey)) : null,
    );
  }
}
