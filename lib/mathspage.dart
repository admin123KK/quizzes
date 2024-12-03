import 'dart:async';
import 'package:flutter/material.dart';

class Mathpage extends StatefulWidget {
  const Mathpage({super.key});

  @override
  State<Mathpage> createState() => _MathpageState();
}

class _MathpageState extends State<Mathpage> {
  int currentIndex = 0;
  int totalPoints = 0;
  int timeLeft = 5;
  late Timer timer;
  bool answered = false;

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
        showResultDialgo();
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
            title: const Text('Quiz'),
            content: Text('You total point is :${totalPoints}'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  final List<String> question = [
    'What is the value of  144 + 12 ÷ 4 144 +12÷4?',
    '3x−5=16, what is the value of 𝑥x?',
    'What is the sum of the first 10 prime numbers?',
    'A train travels 240 km in 4 hours. If it continues at the same speed, how far will it travel in 7 hours?',
    'Solve for 𝑥x: 2𝑥2−8𝑥+−8x+6=0.',
  ];
  final List<List<String>> option = [
    ['15', '18', '20', '21'],
    ['5', '6', '7', '8'],
    ['129', '142', '160', '210'],
    ['360 km', '420 km', '560 km', '600 km'],
    ['1 and 3', '2 and 4', '1 and 4', '2 and 3'],
  ];
  final List<String> correctAnswered = ['18', '7', '142', '560 km', '1 and 3'];

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
                            'QUESTION${currentIndex + 1}OF ${question.length}',
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
                          question[currentIndex],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                                      ? (isCorrect ? Colors.green : Colors.red)
                                      : Colors.grey,
                                  child: Text(
                                    String.fromCharCode(65 + idx),
                                    style: const TextStyle(color: Colors.white),
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
          )
        ],
      ),
    );
  }
}
