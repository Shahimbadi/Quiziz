import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'score_page.dart';
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

  late Timer _timer;
  int _secondRemaining = 15;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    startTimer();
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
        _secondRemaining = 15;
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
    if (widget.currentLevel == widget.totalLevels) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ScorePage(score: cumulativeScore)));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LevelCompletePage(
                currentLevel: widget.currentLevel,
                totalLevels: widget.totalLevels,
                score: _score,
                totalScore: cumulativeScore,
                categoryId: widget.categoryId,
              ),
        ),
      );
    }
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: Colors.black,
          title: const Text('Do you want to exit?',style: TextStyle(
              color: Colors.white
          ),),

          actions: [
            TextButton(
              child: const Text('Cancel',style: TextStyle(
                  fontSize: 17,
                  color: Colors.lightGreen
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(

              child: const Text('Exit',style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 17,
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();  // Navigate back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(_secondRemaining>0) {
          _secondRemaining--;
        } else {
          _nextQuestion();
          _secondRemaining = 15;
          // updateShuffleOption();
        }
      });
    }
    );
  }

  Widget _ButtonNext() {
    if ( _isOptionSelected == true) {
      return ElevatedButton(
        onPressed: _isOptionSelected ? _nextQuestion : null,
        style: ElevatedButton.styleFrom(minimumSize: const Size(110, 50),
            backgroundColor: Colors.lightGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: const Text('Next',style: TextStyle(
            fontSize: 22,
            fontFamily: "genos",
            color: Colors.black
        ),),
      );
    } else {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize:const Size(110, 50),
            foregroundColor: Colors.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ) ),
        onPressed: _skipQuestion,
        child: const Text('Skip',style: TextStyle(
            fontSize: 22,
            fontFamily: "genos",
            color: Colors.lightGreen
        ),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 110,

        centerTitle: true,
        title: Text('Level ${widget.currentLevel}',style: const TextStyle(
            fontFamily: "genos",color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold
        ),),
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back,size: 35,color: Colors.black,),
          onPressed: _showExitConfirmation,
        ),

      ),
      body: Stack(
          children:[ Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  minHeight:7,
                  color: Colors.blue,

                  borderRadius: BorderRadius.circular(20),
                  value: widget.currentLevel / widget.totalLevels,
                ),
              ),
              Expanded(
                child: _questions.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : _buildQuestionCard(),
              ),
            ],
          ),
            Positioned(
                child: Center(heightFactor: 3,
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      child: Center(
                          child: Text(
                            _secondRemaining.toString(),
                            style: const TextStyle(fontSize: 25, fontFamily: "helvetica",),
                          ))),
                )),
          ]),
    );
  }

  Widget _buildQuestionCard() {
    final question = _questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40,),
          Container(
            height: 550,
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
                      child: Text(
                        question['question'],
                        style: const TextStyle(fontSize: 23, fontFamily: "helvetica",
                            fontWeight: FontWeight.w400,
                            color: Colors.white

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...question['options'].map<Widget>((option) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(16) ,
                          border: Border.all(color: Colors.lightGreen)

                      ),
                      margin: const EdgeInsets.all(4),
                      child: ListTile(
                        titleTextStyle:const TextStyle(
                            fontFamily: "helvetica",
                            fontSize: 17
                        ),
                        textColor: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        title: Text(option),
                        tileColor: _isOptionSelected && _selectedOption == option
                            ? (_isCorrect ? Colors.green : Colors.red)
                            : Colors.black54,
                        onTap: _isOptionSelected ? null : () => _handleOptionTap(option),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ButtonNext()
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(minimumSize:Size(110, 50),
              //       foregroundColor: Colors.lightGreen,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(16),
              //       ) ),
              //   onPressed: _skipQuestion,
              //   child: Text('Skip',style: TextStyle(
              //       fontSize: 22,
              //       fontFamily: "genos",
              //       color: Colors.lightGreen
              //   ),),
              // ),
              // ElevatedButton(
              //   onPressed: _isOptionSelected ? _nextQuestion : null,
              //   child: Text('Next'),
              //   style: ElevatedButton.styleFrom(minimumSize: Size(110, 50),
              //       backgroundColor: Colors.lightGreen,
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              // ),

            ],
          ),
        ],
      ),
    );
  }
}