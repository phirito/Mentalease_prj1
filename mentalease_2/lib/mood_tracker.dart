import 'package:flutter/material.dart';

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoodTrackerState createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood tracker"),
      ),
    );
  }
}
