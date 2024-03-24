import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;
  bool _isNotificationEnabled = true;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Tagalog', 'Bisaya', 'Ilonggo', 'Ilocano', 'Waray-Waray', 'Kapampangan', 'Pangasinan', 'Bikol']; // Add more languages as needed

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _languages
                  .map(
                    (language) => ListTile(
                      title: Text(language),
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _showTermsOfServiceDialog(BuildContext context) {
  // Implement terms of service dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Terms of Service'),
        content: SingleChildScrollView(
          child: Text(
            'Welcome to Libroo!\n\nThese terms and conditions outline the rules and regulations for the use of Libroo mobile application. By accessing this mobile application, we assume you accept these terms and conditions. Do not continue to use Libroo if you do not agree to take all of the terms and conditions stated on this page. \n\nYour Use of the App\n\nLibroo provides a platform for buying, selling, and renting books.\nYou agree to use the app in accordance with all applicable laws and regulations.\nYou are responsible for maintaining the confidentiality of your account credentials.\nYou agree not to engage in any activity that interferes with or disrupts the operation of the app.\n\nContent Guidelines\n\nYou are solely responsible for the content you upload, post, or transmit through the app.\nYou agree not to upload or transmit any content that is unlawful, offensive, or violates the rights of others.\nWe reserve the right to remove any content that violates these terms or is otherwise objectionable.',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}


  void _showPrivacyPolicyDialog(BuildContext context) {
    // Implement privacy policy dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy'),
          content: Text('This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n\nFor a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to names, addresses, email addresses, and contact no. The information that we request will be retained by us and used as described in this privacy policy. The app does use third-party services that may collect information used to identify you.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF393742),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: _isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _isDarkModeEnabled = value;
                  // Implement logic to switch theme mode
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: _isNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationEnabled = value;
                  // Implement logic to enable/disable notifications
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Language'),
            onTap: () {
              _showLanguageDialog(context);
            },
            subtitle: Text(_selectedLanguage),
          ),
          Divider(),
          ListTile(
            title: Text('Terms of Service'),
            onTap: () {
              _showTermsOfServiceDialog(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              _showPrivacyPolicyDialog(context);
            },
          ),
          Divider(),
          // Other settings
        ],
      ),
    );
  }
}
