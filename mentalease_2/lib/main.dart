import 'package:flutter/material.dart';
import 'package:mentalease_2/login_area.dart';
import 'package:mentalease_2/signup_area.dart';
import 'package:mentalease_2/home_area.dart'; // Import the HomeArea class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        logo: Image.asset(
          'assets/images/mentalease_logo.png',
          width: 50,
          height: 50,
        ),
        title: 'MentalEase',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.logo, required this.title});

  final Widget logo;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            widget.logo,
            const SizedBox(width: 10),
            Text(widget.title),
          ],
        ),
      ),
      body: PageView(
        children: <Widget>[
          _buildMainPage(context),
          const HomeArea(), // Add HomeArea to the PageView
        ],
      ),
    );
  }

  Widget _buildMainPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: Text('Swipe left to go to Home Page'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginArea();
              }));
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Sign-In"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUpArea();
              }));
            },
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2))),
            child: const Text("Sign-Up"),
          ),
        ],
      ),
    );
  }
}
