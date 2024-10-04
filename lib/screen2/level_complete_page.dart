import 'package:flutter/material.dart';
import 'questions_page.dart';
import 'score_page.dart';

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
          builder: (context) => ScorePage(score: totalScore),
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
      backgroundColor: Colors.black,

      body: Padding(
        padding: const EdgeInsets.only(top:190,left:50,right: 50),
        child: Column(

          children: [

            Text(
              'Level $currentLevel Completed!',
              style: const TextStyle(fontSize: 35,
                  fontFamily: "genos",
                  fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 40),
            Text(
              'Score for this level: $score',
              style: const TextStyle(fontSize: 20,color: Colors.white),
            ),
            const SizedBox(height: 22),
            Text(
              'Total Score: $totalScore',
              style: const TextStyle(fontSize: 20,

                  color: Colors.white),

            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
              onPressed: () => _nextLevel(context),
              child: const Text('Next',style: TextStyle(
                  color: Colors.black,fontFamily: "genos",fontSize:26
              ),),
            ),
          ],
        ),
      ),
    );
  }
}