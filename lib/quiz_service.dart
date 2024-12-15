import 'package:flutter/material.dart';

import 'math_page.dart';

class QuizPage extends StatefulWidget {
  final String category;
  const QuizPage({Key? key, required this.category}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizService _quizService = QuizService();
  Map<String, dynamic>? _currentQuestion;
  bool _isLoading = true;
  String? _currentQuestionId = 'question1'; // Start with question1

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  Future<void> _loadQuestion() async {
    setState(() => _isLoading = true);
    try {
      Map<String, dynamic> question = await _quizService.fetchQuestion(
          widget.category, _currentQuestionId!);
      setState(() {
        _currentQuestion = question;
        _isLoading = false;
      });
      _scheduleNextQuestion(); // Schedule the next question
    } catch (e) {
      print("Error loading question: $e");
      setState(() => _isLoading = false);
    }
  }

  void _scheduleNextQuestion() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _currentQuestionId = _getNextQuestionId(_currentQuestionId!);
      });
      _loadQuestion();
    });
  }

  String _getNextQuestionId(String currentId) {
    final idNumber = int.tryParse(currentId.replaceAll('question', '')) ?? 1;
    return 'question${idNumber + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz - ${widget.category}")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _currentQuestion != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentQuestion!['question'] ?? "Question not found",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    if (_currentQuestion!['options'] is List<dynamic>)
                      ...(_currentQuestion!['options'] as List<dynamic>)
                          .map((option) {
                        return ElevatedButton(
                          onPressed: () {
                            bool isCorrect =
                                option == _currentQuestion!['answer'];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(isCorrect
                                      ? "Correct!"
                                      : "Wrong Answer!")),
                            );
                          },
                          child: Text(option.toString()),
                        );
                      }).toList()
                    else
                      Center(
                        child: Text("Options data is incorrectly formatted."),
                      ),
                  ],
                )
              : Center(child: Text("No questions available!")),
    );
  }
}
