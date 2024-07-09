import 'package:flutter/material.dart';

class JournalingArea extends StatefulWidget {
  const JournalingArea({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JournalingAreaState createState() => _JournalingAreaState();
}

class _JournalingAreaState extends State<JournalingArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journaling"),
      ),
    );
  }
}
