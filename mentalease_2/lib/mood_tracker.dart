// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MoodTracker extends StatefulWidget {
  final bool showGreeting;

  const MoodTracker({super.key, this.showGreeting = true});

  @override
  // ignore: library_private_types_in_public_api
  _MoodTrackerState createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  String _selectedMood = '';
  final List<Map<String, String>> _moods = [
    {'emoji': '😀', 'label': 'Happy'},
    {'emoji': '😐', 'label': 'Neutral'},
    {'emoji': '😞', 'label': 'Sad'},
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '😰', 'label': 'Anxious'},
    {'emoji': '😴', 'label': 'Tired'},
  ];

  final List<String> _moodHistory = ['Happy', 'Sad', 'Neutral'];

  void _addMoodToHistory(String mood) {
    if (_moodHistory.length >= 3) {
      _moodHistory.removeAt(0); // Remove the oldest mood
    }
    _moodHistory.add(mood);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showGreeting) // Conditionally display greeting
                Text(
                  "How was your day?",
                  style: TextStyle(fontSize: mediaQuery.textScaleFactor * 24),
                ),
              SizedBox(height: mediaQuery.size.height * 0.02),
              SizedBox(
                height: mediaQuery.size.height *
                    0.3, // Adjust height relative to screen size
                child: GridView.count(
                  crossAxisCount: isLandscape ? 4 : 3,
                  mainAxisSpacing: mediaQuery.size.width * 0.02,
                  crossAxisSpacing: mediaQuery.size.width * 0.02,
                  childAspectRatio: 1,
                  shrinkWrap:
                      true, // Prevent GridView from taking up more space than necessary
                  physics: const NeverScrollableScrollPhysics(),
                  children: _moods.map((mood) {
                    return ChoiceChip(
                      label: Text(
                        mood['emoji']!,
                        style: TextStyle(
                            fontSize: mediaQuery.textScaleFactor * 30),
                      ),
                      selected: _selectedMood == mood['label'],
                      onSelected: (selected) {
                        setState(() {
                          _selectedMood = selected ? mood['label']! : '';
                          if (selected) {
                            _addMoodToHistory(mood['label']!);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.02),
              Container(
                alignment: Alignment.center,
                child: Text(
                  _selectedMood.isNotEmpty
                      ? 'You selected: $_selectedMood'
                      : 'Please select a mood',
                  style: TextStyle(fontSize: mediaQuery.textScaleFactor * 18),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.05),
              Text(
                "Mood History (in last 3 Days)",
                style: TextStyle(fontSize: mediaQuery.textScaleFactor * 20),
              ),
              SizedBox(height: mediaQuery.size.height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.size.width * 0.05,
                    vertical: mediaQuery.size.height * 0.02),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: _buildMoodHistoryChart(mediaQuery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodHistoryChart(MediaQueryData mediaQuery) {
    final Map<String, int> moodCounts = {};
    for (var mood in _moodHistory) {
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }

    return SizedBox(
      height:
          mediaQuery.size.height * 0.3, // Adjust height relative to screen size
      width:
          mediaQuery.size.width * 0.9, // Adjust width relative to screen size
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _moods.map((mood) {
            final count = moodCounts[mood['label']] ?? 0;
            // Calculate bar height to avoid too large or small bars
            double barHeight =
                mediaQuery.size.height * 0.1 * (count / (_moodHistory.length));
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.02),
              child: Column(
                children: [
                  Text(
                    '${mood['emoji']}',
                    style: TextStyle(fontSize: mediaQuery.textScaleFactor * 25),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.00),
                  Text(
                    '$count',
                    style: TextStyle(fontSize: mediaQuery.textScaleFactor * 10),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.00),
                  Container(
                    width: mediaQuery.size.width * 0.1,
                    height: barHeight > 0
                        ? barHeight
                        : mediaQuery.size.height * 0.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 116, 8, 0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 1, // Spread radius of the shadow
                          blurRadius: 4, // Blur radius of the shadow
                          offset: const Offset(2, 2), // Offset of the shadow
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
