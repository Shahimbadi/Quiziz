import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


// void main() {
//   runApp(MaterialApp(
//     home: LevelUp(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class LevelUp extends StatelessWidget {
  final int score;

  Widget _badgeColor() {
    if (score > 15) {
      return const Center(
        child: SizedBox(
            height: 170,
            child: Image(image: AssetImage('assets/images/gold_badge.png'))),
      );
    } else if (score > 10) {
      return const Center(
        child: SizedBox(
            height: 170,
            child: Image(image: AssetImage('assets/images/silver_badge.png'))),
      );
    } else {
      return const Center(
        child: SizedBox(
            height: 170,
            child: Image(image: AssetImage('assets/images/bronze_badge.png'))),
      );
    }
  }

  const LevelUp({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: Stack(
        children: [
          Lottie.asset("assets/lottie/pop_animation.json",repeat: false),
          Column(
            children: [
              const SizedBox(height: 200,),
              _badgeColor(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Congratulations!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your total score is:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$score',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
          ],
        ),
        ]
      ),
    );
  }
}
