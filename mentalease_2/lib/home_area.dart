import 'package:flutter/material.dart';
import 'package:mentalease_2/journaling_area.dart';
import 'package:mentalease_2/meditate_area.dart';
import 'package:mentalease_2/mood_tracker.dart';
import 'package:mentalease_2/signup_area.dart'; // Import the LoginArea

class HomeArea extends StatefulWidget {
  const HomeArea({super.key});

  @override
  State<HomeArea> createState() => _HomeAreaState();
}

class _HomeAreaState extends State<HomeArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Greetings Users!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 116, 8, 0), // Maroon background
        automaticallyImplyLeading: false,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color:
                    Color.fromARGB(255, 145, 145, 145), // Maroon drawer header
              ),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignUpArea();
                  }),
                );
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20, left: 20, right: 20), // Space added at the top
                    padding: const EdgeInsets.fromLTRB(
                      15,
                      5,
                      15,
                      10,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          child: const Text(
                            'Quote of the day',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            'Leave tomorrow problems to tomorrows me',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const MoodTracker();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 116, 8, 0), // Maroon button
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(constraints.maxWidth * 0.8, 60)),
                        child: const Text("Mood Tracker"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const MeditateArea();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 116, 8, 0), // Maroon button
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(constraints.maxWidth * 0.8, 60)),
                        child: const Text("Meditate"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const JournalingArea();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 116, 8, 0), // Maroon button
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(constraints.maxWidth * 0.8, 60)),
                        child: const Text("Journaling"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
