import 'dart:async';

import 'package:flutter/material.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  int currentIndex = 0;
  int totalPoints = 0;
  late Timer timer;
  int timeLeft = 5;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel;
    super.dispose();
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
      if (options[currentIndex][index] == correctAnswers[currentIndex]) {
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
            title: const Text('Quiz'),
            content: Text('Your total points is : $totalPoints'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  final List<String> question = [
    'Which event is often considered the start of the modern era?',
    'Who was the first emperor of the Roman Empire?',
    'Which treaty ended World War I?',
    'What was the primary cause of the Cold War?',
    'What year did the Berlin Wall fall, symbolizing the end of the Cold War?',
  ];
  final List<List<String>> options = [
    [
      'The Fall of Constantinople (1453)',
      'The American Revolution (1775)',
      ' The Industrial Revolution (1760-1840)',
      'The French Revolution (1789)'
    ],
    ['Julius Caesar', 'Augustus Caesar', 'Nero', ' Constantine'],
    [
      'Treaty of Versailles',
      'Treaty of Ghent',
      ' Treaty of Paris',
      ' Treaty of Westphalia'
    ],
    [
      'A. Religious conflicts',
      'Ideological differences between the USA and USSR',
      'Disputes over territorial boundaries',
      ' Competition for trade routes'
    ],
    [' Roman Empire', 'British Empire', 'Ottoman Empire', ' Mongol Empire']
  ];

  final List<String> correctAnswers = [
    'The Fall of Constantinople (1453)',
    'Augustus Caesar',
    'Treaty of Versailles',
    'Ideological differences between the USA and USSR',
    'British Empire'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEF4A27),
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: const Color(0XFFEF4A27),
        title: const Text(
          'Histroy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.timer_outlined,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
        centerTitle: true,
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'QUESTION ${currentIndex + 1} OF ${question.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                backgroundColor: const Color(0XFFEF4A27),
                                child: Text(
                                  '${timeLeft}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
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
                        const SizedBox(height: 20),
                        ...options[currentIndex].asMap().entries.map(
                          (entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            bool isCorrect =
                                option == correctAnswers[currentIndex];
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
