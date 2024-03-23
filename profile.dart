import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'my_store.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393742), // Match the color of the bottom navigation bar
        title: Text(
          'Profile', // Change the title text to "Profile"
          style: TextStyle(color: Colors.white), // Make the title text color white
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
                     borderRadius: BorderRadius.circular(100), child: const Image(image: NetworkImage('https://raw.githubusercontent.com/RJSeebs02/LibrooImages/main/Lij.jpg'))
                    ),
                  ),
                ],
              ),
              
              
              const SizedBox(height: 10),
              Text('Elijah', style: Theme.of(context).textTheme.headlineLarge),
              Text('Basic User', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              SizedBox(
                width:200,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()), // Replace EditProfilePage() with the page you want to navigate to
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, side: BorderSide.none, shape: StadiumBorder()),
                  child: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
                  )
              ),
              const SizedBox(height: 30),
              ProfileMenuWidget(title: "My Store", icon: Icons.monetization_on, onPress: (){Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyStorePage()),
    );}),
              
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              ProfileMenuWidget(title: "Settings", icon: Icons.settings, onPress: (){}),
              ProfileMenuWidget(title: "About Us", icon: Icons.question_answer, onPress: (){}),
              
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              
              ProfileMenuWidget(title: "Logout", icon: Icons.logout, textColor: Colors.red, endIcon: false, onPress: (){}),
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
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
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