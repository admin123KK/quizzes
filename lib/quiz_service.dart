import 'package:cloud_firestore/cloud_firestore.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchQuestion(
      String category, String questionId) async {
    try {
      DocumentSnapshot questionDoc = await _firestore
          .collection('questions') // Root collection
          .doc('questions') // Subdocument
          .collection(category) // Subcollection (category1, category2, etc.)
          .doc(questionId) // Specific question (question1, question2, etc.)
          .get();

      if (questionDoc.exists) {
        return questionDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception("Question not found.");
      }
    } catch (e) {
      print("Error fetching question: $e");
      throw Exception("Failed to fetch question.");
    }
  }
}
