import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class ScorePage extends StatelessWidget {
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

  const ScorePage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.black,
      body: Stack(children: [
        Lottie.asset("assets/lottie/pop_animation.json", repeat: false),
        Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            _badgeColor(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Congratulations!',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "genos"),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your total score is:',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$score',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color: Colors.white),
                  ),

                  // ElevatedButton(onPressed: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
                  // }, child: Text("home"))

                  const SizedBox(height: 50,),
                  ElevatedButton.icon(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const QuizizHomePage()));
                  }, label: const Text("Home",style: TextStyle(color: Colors.black),),
                    icon: const Icon(Icons.home,color: Colors.black,),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),

                    ),
                        maximumSize: const Size(140, 60)),

                  ),

                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}