import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: QuestionPage(),
    debugShowCheckedModeBanner: false,
  ));
}

Widget _questionBox(question) {
  return Container(
    height: 200,
    width: 400,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(25)),
    child: Center(
        child: Text(
      question,
      style: const TextStyle(fontFamily: 'genos', fontSize: 25, color: Colors.black),
    )),
  );
}

Widget _timer() {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
        color: Colors.grey[400], borderRadius: BorderRadius.circular(100)),
  );
}

Widget _options(option) {
  return Column(
    children: [
      const SizedBox(height: 25,),
      Container(
        height: 70,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 3, color: Colors.green)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(option, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'genos'),)
              ],
            ),
          ),
        ),
      )
    ],
  );
}


class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int number = 0;
  // timer
  late Timer _timer;
  int _secondRemaining = 15;

  List<String> shuffleOption=[];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Subject',
          style: TextStyle(
            fontFamily: 'genos',
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Stack(children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 700,
                      width: 425,
                      decoration: BoxDecoration(
                          color: const Color(0xff8ac049),
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          _questionBox('Here is the question?'),
                          const Text(
                            "Choose the correct option",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'genos',
                                color: Colors.white),
                          ),
                          _options('A. option A'),
                          _options('B. option B'),
                          _options('C. option C'),
                          _options('D. option D'),
                          const SizedBox(height: 30,)
                        ],
                      )),
                ],
              ),
            ),
            Positioned(
                child: Center(
                    child: Container(
                      height: 50, width: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                        child: Center(child: Text(_secondRemaining.toString(), style: const TextStyle(fontSize: 25),))))),
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 70),
                      backgroundColor: const Color(0xffffffff),
                      foregroundColor: Colors.lightGreenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {},
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'genos',
                        color: Colors.black54),
                  )),
              const SizedBox(
                width: 100,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 70),
                      backgroundColor: const Color(0xff8ac049),
                      foregroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {},
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'genos',
                        color: Colors.black54),
                  )),
            ],
          )
        ],
      ),
    );
  }

  // List<String> shuffleOption(List<String> option){}

  void nextQuestion() {
    if(number==9) {
      completed();
    }
    setState(() {
      number = number+1;
      updateShuffleOption();
      _secondRemaining= 15;
    });
  }

//function of timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(_secondRemaining>0) {
          _secondRemaining--;
        } else {
          nextQuestion();
          _secondRemaining = 15;
          updateShuffleOption();
        }
      });
    }
    );
  }

  void updateShuffleOption() {

  }

  void completed() {

  }

}
