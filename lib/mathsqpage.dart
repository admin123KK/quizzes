import 'dart:async';

import 'package:flutter/material.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  int currentqIndex = 0;
  late Timer timer;
  int timeLeft = 5;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.initState();
    startTimer();
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
      if (currentqIndex < question.length - 1) {
        currentqIndex++;
        timeLeft = 5;
      } else {
        timer.cancel();
      }
    });
  }

  final List<String> question = [
    'Which of the Nepali player is most popular in BBL?.',
    'Which of the Nepali player is most popular in NPL?.',
    'Which of the Nepali player is most popular in CPL?.',
    'Which of the Nepali player is most popular in DPL?.',
  ];
  final List<String> options = [
    'Sandeep Lamichane',
    'Parash Khadka',
    'Shakti Gauchan',
    'Shakti Gauchan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFFEF4A27),
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
              child: const Icon(Icons.arrow_back_ios)),
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
                                  'QUESTION $currentqIndex OF 10',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Center(child: Text(' $timeLeft')))
                              ],
                            ),
                          ),
                          Center(child: Text(question[currentqIndex]))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
