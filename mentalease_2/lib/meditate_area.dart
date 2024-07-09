import 'package:flutter/material.dart';

class MeditateArea extends StatefulWidget {
  const MeditateArea({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MeditateAreaState createState() => _MeditateAreaState();
}

class _MeditateAreaState extends State<MeditateArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood tracker"),
      ),
    );
  }
}
