import 'package:flutter/material.dart';
import 'package:quiziz/screens/questions_page2.dart';

import 'level_up.dart';


class LevelCompletePage extends StatelessWidget {
  final int currentLevel;
  final int totalLevels;
  final int score;
  final int totalScore;
  final String categoryId;

  const LevelCompletePage({super.key, 
    required this.currentLevel,
    required this.totalLevels,
    required this.score,
    required this.totalScore,
    required this.categoryId,
  });

  void _nextLevel(BuildContext context) {
    if (currentLevel == totalLevels) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LevelUp(score: totalScore),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionsPage(
            categoryId: categoryId,
            levelId: 'level${currentLevel + 1}',
            currentLevel: currentLevel + 1,
            totalLevels: totalLevels,
            totalScore: totalScore,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Level Complete')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $currentLevel Complete!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Score for this level: $score',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Score: $totalScore',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _nextLevel(context),
              child: const Text('Next Level'),
            ),
          ],
        ),
      ),
    );
  }
}