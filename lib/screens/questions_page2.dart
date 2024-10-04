import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'level_complete_page.dart';

class QuestionsPage extends StatefulWidget {
  final String categoryId;
  final String levelId;
  final int currentLevel;
  final int totalLevels;
  final int totalScore;  // to accumulate score across levels

  const QuestionsPage({super.key, 
    required this.categoryId,
    required this.levelId,
    required this.currentLevel,
    required this.totalLevels,
    this.totalScore = 0,  // default score is 0
  });

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int _score = 0;
  int _currentQuestionIndex = 0;
  List<DocumentSnapshot> _questions = [];
  String? _selectedOption;
  bool _isOptionSelected = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    final CollectionReference questions = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('levels')
        .doc(widget.levelId)
        .collection('questions');

    final snapshot = await questions.get();
    setState(() {
      _questions = snapshot.docs;
    });
  }

  void _handleOptionTap(String selectedOption) {
    if (_questions.isEmpty) return;

    final correctOption = _questions[_currentQuestionIndex]['correctOption'];

    setState(() {
      _selectedOption = selectedOption;
      _isOptionSelected = true;
      _isCorrect = selectedOption == correctOption;
      if (_isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOption = null;
        _isOptionSelected = false;
      } else {
        _completeLevel();
      }
    });
  }

  void _skipQuestion() {
    _nextQuestion();
  }

  void _completeLevel() {
    int cumulativeScore = widget.totalScore + _score;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LevelCompletePage(
          currentLevel: widget.currentLevel,
          totalLevels: widget.totalLevels,
          score: _score,
          totalScore: cumulativeScore,
          categoryId: widget.categoryId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Level ${widget.currentLevel}')),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: widget.currentLevel / widget.totalLevels,
          ),
          Expanded(
            child: _questions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _buildQuestionCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    final question = _questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question['question'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...question['options'].map<Widget>((option) {
                    return ListTile(
                      title: Text(option),
                      tileColor: _isOptionSelected && _selectedOption == option
                          ? (_isCorrect ? Colors.green : Colors.red)
                          : null,
                      onTap: _isOptionSelected ? null : () => _handleOptionTap(option),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _isOptionSelected ? _nextQuestion : null,
                child: const Text('Next'),
              ),
              ElevatedButton(
                onPressed: _skipQuestion,
                child: const Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}