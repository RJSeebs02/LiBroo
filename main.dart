import 'dart:convert';
import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';
import 'chat.dart';
import 'carting.dart';
import 'notification.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    final String user_username = usernameController.text.trim();
    final String user_password = passwordController.text.trim();

    // Your API endpoint
    const String apiUrl = 'https://zenenix.helioho.st/serve/validate.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'user_username': user_username, 'user_password': user_password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Successful login
        final responseData = jsonDecode(response.body);
        final bool validation = responseData['validation'];

        // Store validation status in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('validation', validation);

        if (validation) {
          _navigateToHome();
        } else {
          setState(() {
            errorMessage = 'Cannot verify user.';
          });
        }
      } else {
        // Handle error
        setState(() {
          errorMessage = 'Invalid username or password';
        });
      }
    } catch (e) {
      // Handle network errors
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                
                const Icon(
                  Icons.menu_book,
                  size: 100,
                ),
            
                Text(
                  'Libroo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16
                  ),
                ),
            
                const SizedBox(height: 10),
                
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        cursorColor: Colors.black,
                        controller: usernameController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 212, 208, 208)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Username',
                        ),
                      ),
            
                      const SizedBox(height: 25),
            
                      TextField(
                        cursorColor: Colors.black,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 212, 208, 208)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: _login,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                            color: const Color(0xFF393742),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Don\'t have an account yet? ',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                            TextSpan(
                              text: 'Sign Up',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                              }
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393742), // Set the background color of the main page to grey
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          HomePage(),
          ChatPage(),
          CartingPage(),
          NotificationPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xFF393742), // Set the color of the bottom navigation bar
        type: BottomNavigationBarType.fixed, // Set type to fixed
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFFD3AF),
        unselectedItemColor: Colors.white, // Set the color of the unselected icons to white
        onTap: _onItemTapped,
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? validation = prefs.getBool('validation');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Set debugShowCheckedModeBanner to false
    title: 'Login App',
    initialRoute: validation == null || !validation ? '/' : '/home',
    routes: {
      '/': (context) => const LoginPage(),
      '/home': (context) => const MyHomePage(),
    },
  ));
}
