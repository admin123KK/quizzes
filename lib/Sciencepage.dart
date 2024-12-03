import 'dart:async';

import 'package:flutter/material.dart';

class Sciencepage extends StatefulWidget {
  const Sciencepage({super.key});

  @override
  State<Sciencepage> createState() => _SciencepageState();
}

class _SciencepageState extends State<Sciencepage> {
  int currentIndex = 0;
  int totalPoints = 0;
  int timeLeft = 5;
  bool answered = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
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
      if (currentIndex < question.length - 1) {
        currentIndex++;
        timeLeft = 5;
        answered = false;
      } else {
        timer.cancel();
        showResultDialog();
      }
    });
  }

  void checkAnswer(int index) {
    if (answered) return;
    setState(() {
      answered = true;
      if (option[currentIndex][index] == correctAnswered[currentIndex]) {
        totalPoints += 10;
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
            icon: const Icon(
              Icons.science_outlined,
              color: Colors.black,
            ),
            title: const Center(
                child: Text(
              'Quiz Result',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            )),
            content: Center(
                child: Text(
              'Your Total Point is:$totalPoints',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green),
            )),
            actions: [
              TextButton(
                onPressed: () {
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
        });
  }

  final List<String> question = [
    'What is the chemical symbol for water?',
    'Which planet is known as the Red Planet?',
    'What gas do plants absorb from the atmosphere during photosynthesis?',
    'Which part of the human brain controls balance and coordination??',
    'What is the most abundant gas in Earth’s atmosphere?'
  ];
  final List<List<String>> option = [
    ['O₂', 'H₂O', 'CO₂', 'OH'],
    ['Venus ', 'Mars', 'Jupiter', 'Saturn'],
    ['Oxygen ', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
    ['Cerebrum', 'Cerebellum', 'Medulla', 'Hypothalamus'],
    ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Argon']
  ];
  final List<String> correctAnswered = [
    'H₂O',
    'Mars',
    'Carbon Dioxide',
    'Cerebellum',
    'Nitrogen'
  ];

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'QUESTION ${currentIndex + 1}OF ${question.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                backgroundColor: const Color(0XFFEF4A27),
                                child: Text(
                                  '$timeLeft',
                                  style: TextStyle(color: Colors.white),
                                ),
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
                              question[currentIndex],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...option[currentIndex].asMap().entries.map(
                          (entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            bool isCorrect =
                                option == correctAnswered[currentIndex];
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
