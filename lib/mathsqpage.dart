import 'dart:async';

import 'package:flutter/material.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  int currentqIndex = 0; // Start with the first question
  int totalPoints = 0; // Track total points
  late Timer timer;
  int timeLeft = 5;
  bool answered = false; // Track if the current question has been answered

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
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
      if (currentqIndex < question.length - 1) {
        currentqIndex++;
        timeLeft = 5;
        answered = false; // Reset answer state for the next question
      } else {
        timer.cancel();
        showResultDialog(); // Show total score dialog
      }
    });
  }

  void checkAnswer(int index) {
    if (answered) return; // Prevent multiple answers for the same question
    setState(() {
      answered = true;
      if (options[currentqIndex][index] == correctAnswers[currentqIndex]) {
        totalPoints += 10; // Add points for correct answer
      }
      Future.delayed(const Duration(seconds: 1), () {
        moveToNextQuestion();
      });
    });
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text('Your total score is: $totalPoints'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the previous screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final List<String> question = [
    'Which of the Nepali player is most popular in BBL?',
    'Which of the Nepali player is most popular in NPL?',
    'Which of the Nepali player is most popular in CPL?',
    'Which of the Nepali player is most popular in DPL?',
    'Which of the Nepali player is most popular in EPL?'
  ];

  final List<List<String>> options = [
    ['Sandeep Lamichane', 'Parash Khadka', 'Shakti Gauchan', 'Sharad Vesawkar'],
    ['Sandeep Lamichane', 'Parash Khadka', 'Shakti Gauchan', 'Binod Das'],
    ['Paras Khadka', 'Sharad Vesawkar', 'Dipendra Airee', 'Sandeep Lamichane'],
    ['Gyanendra Malla', 'Shakti Gauchan', 'Rohit Paudel', 'Sandeep Lamichane'],
    ['Paras Khadka', 'Dipendra Airee', 'Kushal Bhurtel', 'Sandeep Lamichane'],
  ];

  final List<String> correctAnswers = [
    'Sandeep Lamichane',
    'Parash Khadka',
    'Sandeep Lamichane',
    'Sandeep Lamichane',
    'Sandeep Lamichane',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFEF4A27),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              height: 30,
              width: 30,
              child: const Icon(
                Icons.alarm_sharp,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Maths',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: const Color(0XFFEF4A27),
      body: Stack(
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'QUESTION ${currentqIndex + 1} OF ${question.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Center(child: Text('$timeLeft')),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              question[currentqIndex],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...options[currentqIndex].asMap().entries.map(
                          (entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            bool isCorrect =
                                option == correctAnswers[currentqIndex];
                            return GestureDetector(
                              onTap: () => checkAnswer(idx),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: answered
                                      ? (isCorrect ? Colors.green : Colors.red)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: answered
                                          ? (isCorrect
                                              ? Colors.green
                                              : Colors.red)
                                          : Colors.grey,
                                      child: Text(
                                        String.fromCharCode(65 + idx),
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
                            );
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
