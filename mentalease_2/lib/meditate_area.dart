import 'package:flutter/material.dart';
import 'dart:async';

class MeditateArea extends StatefulWidget {
  const MeditateArea({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MeditateAreaState createState() => _MeditateAreaState();
}

class _MeditateAreaState extends State<MeditateArea>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _start = 0;
  bool _isRunning = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60), // Adjust the duration as needed
    );
  }

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _controller.forward(from: _start / 60); // Update to reflect current state
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _start++;
      });
    });
  }

  void _pauseTimer() {
    if (!_isRunning) return;
    _isRunning = false;
    _controller.stop();
    _timer?.cancel();
  }

  void _resetTimer() {
    _isRunning = false;
    _controller.reset();
    _timer?.cancel();
    setState(() {
      _start = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _start / 60,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 116, 8, 0)),
                  ),
                ),
                Text(
                  "${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 48),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: _startTimer,
                  icon: const Icon(Icons.play_arrow), // Play icon for "Start"
                  tooltip: 'Start',
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _pauseTimer,
                  icon: const Icon(Icons.pause), // Pause icon for "Pause"
                  tooltip: 'Pause',
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh), // Refresh icon for "Reset"
                  tooltip: 'Reset',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
