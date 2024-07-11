import 'package:flutter/material.dart';

class JournalingArea extends StatefulWidget {
  const JournalingArea({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JournalingAreaState createState() => _JournalingAreaState();
}

class _JournalingAreaState extends State<JournalingArea> {
  final TextEditingController _journalController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<String> _journalEntries = [];
  final List<String> _chores = [];
  final List<bool> _choresDone = [];
  final PageController _pageController = PageController();

  void _addJournalEntry() {
    if (_journalController.text.isNotEmpty) {
      setState(() {
        _journalEntries.insert(0, _journalController.text);
        _journalController.clear();
      });
    }
  }

  void _addChore(String chore) {
    setState(() {
      _chores.add(chore);
      _choresDone.add(false);
    });
    _noteController.clear();
  }

  void _toggleChoreDone(int index) {
    setState(() {
      _choresDone[index] = !_choresDone[index];
    });
  }

  void _deleteChore(int index) {
    setState(() {
      _chores.removeAt(index);
      _choresDone.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _buildJournalEntryPage(),
          _buildJournalHistoryPage(),
        ],
      ),
    );
  }

  Widget _buildJournalEntryPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Journal Entry",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _journalController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Write about your day...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addJournalEntry,
            child: const Text(
              "Add Entry",
              style: TextStyle(color: Color.fromARGB(255, 116, 8, 0)),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Notes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              hintText: "Add a note...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_noteController.text.isNotEmpty) {
                _addChore(_noteController.text);
              }
            },
            child: const Text(
              "Add Note",
              style: TextStyle(color: Color.fromARGB(255, 116, 8, 0)),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "To-Do List",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _chores.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: _choresDone[index],
                  onChanged: (bool? value) {
                    _toggleChoreDone(index);
                  },
                ),
                title: Text(
                  _chores[index],
                  style: TextStyle(
                    decoration: _choresDone[index]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteChore(index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJournalHistoryPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal History"),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _journalEntries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_journalEntries[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
