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

  // Initialize mood history with dummy data for 3 days
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "How was your day?",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150, // Adjust the height to fit your design
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
                //physics: const NeverScrollableScrollPhysics(),
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
              "Mood History (Last 3 Days)",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            _buildMoodHistoryBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodHistoryBox() {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildMoodHistoryChart(),
    );
  }

  Widget _buildMoodHistoryChart() {
    final Map<String, int> moodCounts = {};
    for (var mood in _moodHistory) {
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }

    return SizedBox(
      height: 150,
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
