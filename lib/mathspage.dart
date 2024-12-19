import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiznep/math_page.dart';

class Mathpage extends StatefulWidget {
  const Mathpage({super.key});

  @override
  State<Mathpage> createState() => _MathpageState();
}

class _MathpageState extends State<Mathpage> {
  final QuizService _quizService = QuizService();

  int currentIndex = 0;
  int totalPoints = 0;
  int timeLeft = 5;
  late Timer timer;
  bool answered = false;

  List<Map<String, dynamic>> questions = [];
  late Map<String, dynamic> currentQuestion;

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  Future<void> _loadQuestion() async {
    try {
      List<Map<String, dynamic>> fetchedQuestions = [];
      for (int i = 1; i <= 5; i++) {
        String questionId = 'question$i';
        Map<String, dynamic> question =
            await _quizService.fetchQuestion('History', questionId);
        fetchedQuestions.add(question);
      }
      setState(() {
        questions = fetchedQuestions;
        currentQuestion = questions[currentIndex];
        startTimer();
      });
    } catch (e) {
      print('Error in loading: $e');
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          moveToNextQuestion();
        }
      });
    });
  }

  void saveResult() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Error user is not authenciated");

        return;
      } else {
        print('Authenciated User ${user.uid}');
      }
      final quizResult = {
        'userEmail': user.email,
        'Categories': 'Maths',
        'points': totalPoints,
        'dateTime': DateTime.now(),
      };
      await FirebaseFirestore.instance
          .collection('quizResults')
          .add(quizResult);
    } catch (e) {
      print('Error while Saving Results');
    }
  }

  void moveToNextQuestion() {
    setState(() {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        timeLeft = 5;
        answered = false;
        currentQuestion = questions[currentIndex];
      } else {
        timer.cancel();
        showResultDialgo();
      }
    });
  }

  void checkAnswer(String selectedOption) {
    if (answered) return;
    setState(() {
      if (selectedOption == currentQuestion['answer']) {
        totalPoints += 10;
      }
      Future.delayed(Duration(seconds: 1), () {
        moveToNextQuestion();
      });
    });
  }

  void showResultDialgo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.calculate_outlined,
              color: Colors.black,
            ),
            title: const Text(
              'Quiz Result',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            content: Text(
              'You total point is :${totalPoints}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    saveResult();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0XFFEF4A27)),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEF4A27),
      appBar: AppBar(
        backgroundColor: const Color(0XFFEF4A27),
        centerTitle: true,
        title: const Text(
          'Maths',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.timer_outlined,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 650,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'QUESTION ${currentIndex + 1} OF ${questions.length}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            child: Text(
                              '$timeLeft',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0XFFEF4A27),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          currentQuestion['question'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...(currentQuestion['options'] as List<dynamic>)
                        .map((option) => GestureDetector(
                              onTap: () => checkAnswer(option),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: answered
                                      ? (option = currentQuestion['answer']
                                          ? Colors.green
                                          : Colors.red)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: answered
                                          ? (option = currentQuestion['answer']
                                              ? Colors.green
                                              : Colors.red)
                                          : Colors.grey,
                                      child: Text(
                                        String.fromCharCode(65 +
                                            (currentQuestion['options'] as List)
                                                .indexOf(option)),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      option,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
