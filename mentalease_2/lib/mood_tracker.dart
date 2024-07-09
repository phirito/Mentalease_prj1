import 'package:flutter/material.dart';

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Tracker"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isLandscape = constraints.maxWidth > constraints.maxHeight;

          return isLandscape
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildMoodTrackerContent(constraints),
                  ),
                )
              : SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildMoodTrackerContent(constraints),
                    ),
                  ),
                );
        },
      ),
    );
  }

  List<Widget> _buildMoodTrackerContent(BoxConstraints constraints) {
    return [
      const Text(
        "How was your day?",
        style: TextStyle(fontSize: 24),
      ),
      const SizedBox(height: 20),
      SizedBox(
        height: constraints.maxHeight *
            0.3, // Adjust height relative to screen size
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
          shrinkWrap:
              true, // Prevent GridView from taking up more space than necessary
          physics: const NeverScrollableScrollPhysics(),
          children: _moods.map((mood) {
            return ChoiceChip(
              label: Text(
                mood['emoji']!,
                style: const TextStyle(fontSize: 30),
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
      const SizedBox(height: 20),
      Text(
        _selectedMood.isNotEmpty
            ? 'You selected: $_selectedMood'
            : 'Please select a mood',
        style: const TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 40),
      const Text(
        "Mood History (in last 3 Days)",
        style: TextStyle(fontSize: 20),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: _buildMoodHistoryChart(constraints),
      ),
    ];
  }

  Widget _buildMoodHistoryChart(BoxConstraints constraints) {
    final Map<String, int> moodCounts = {};
    for (var mood in _moodHistory) {
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }

    return Container(
      height:
          constraints.maxHeight * 0.3, // Adjust height relative to screen size
      width: constraints.maxWidth * 0.8, // Adjust width relative to screen size
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _moods.map((mood) {
          final count = moodCounts[mood['label']] ?? 0;
          return Column(
            children: [
              Text(
                '${mood['emoji']}',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 8),
              Text(
                '$count',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: 20,
                height: 20.0 * count,
                color: Colors.blue,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
