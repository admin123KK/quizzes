import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'math_page.dart';

class SciencePage extends StatefulWidget {
  const SciencePage({super.key});

  @override
  State<SciencePage> createState() => _SciencePageState();
}

class _SciencePageState extends State<SciencePage> {
  final QuizService _quizService = QuizService();
  int currentIndex = 0;
  int totalPoints = 0;
  int timeLeft = 5;
  bool answered = false;
  bool isLoading = true;
  late Timer timer;

  List<Map<String, dynamic>> questions = [];
  late Map<String, dynamic> currentQuestion;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    // setState(() => isLoading = true);
    try {
      // Assuming question IDs are sequential: question1, question2, etc.
      List<Map<String, dynamic>> fetchedQuestions = [];
      for (int i = 1; i <= 5; i++) {
        String questionId = 'question$i';
        Map<String, dynamic> question = await _quizService.fetchQuestion(
          'Science', // Replace with the correct category name
          questionId,
        );
        fetchedQuestions.add(question);
      }
      setState(() {
        questions = fetchedQuestions;
        currentQuestion = questions[currentIndex];
        isLoading = false;
        startTimer();
      });
    } catch (e) {
      print("Error loading questions: $e");
      setState(() => isLoading = false);
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

  void moveToNextQuestion() {
    setState(() {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        timeLeft = 5;
        answered = false;
        currentQuestion = questions[currentIndex];
      } else {
        timer.cancel();
        showResultDialog();
      }
    });
  }

  void checkAnswer(String selectedOption) {
    if (answered) return;
    setState(() {
      answered = true;
      if (selectedOption == currentQuestion['answer']) {
        totalPoints += 10;
      }
      Future.delayed(Duration(seconds: 1), () {
        moveToNextQuestion();
      });
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.science_outlined, color: Colors.black),
          title: const Text(
            'Quiz Result',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          content: Text(
            'Your Total Point is: $totalPoints',
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
              ),
            )
          ],
        );
      },
    );
  }

  void saveResult() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Error: user is not authenticated");
        return;
      }
      final quizResult = {
        'userEmail': user.email,
        'Categories': 'Science',
        'points': totalPoints,
        'dateTime': DateTime.now().toIso8601String(),
      };
      await FirebaseFirestore.instance
          .collection('quizResults')
          .add(quizResult);
    } catch (e) {
      print('Error while saving results: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEF4A27),
      appBar: AppBar(
        backgroundColor: const Color(0XFFEF4A27),
        centerTitle: true,
        title: const Text(
          'Science',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Icon(
              Icons.timer_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'QUESTION ${currentIndex + 1} OF ${questions.length}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: const Color(0XFFEF4A27),
                                      child: Text(
                                        '$timeLeft',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Text(
                                    currentQuestion['question'] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
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
                                                ? (option ==
                                                        currentQuestion[
                                                            'answer']
                                                    ? Colors.green
                                                    : Colors.red)
                                                : Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: answered
                                                    ? (option ==
                                                            currentQuestion[
                                                                'answer']
                                                        ? Colors.green
                                                        : Colors.red)
                                                    : Colors.grey,
                                                child: Text(
                                                  String.fromCharCode(65 +
                                                      (currentQuestion[
                                                                  'options']
                                                              as List)
                                                          .indexOf(option)),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Text(
                                                option.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
