import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollPage extends StatefulWidget {
  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchRankings() async {
    QuerySnapshot snapshot = await _firestore.collection('quizResults').get();

    Map<String, int> userPoints = {};

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String userEmail = data['userEmail'];
      int points = data['points'];

      if (userPoints.containsKey(userEmail)) {
        userPoints[userEmail] = userPoints[userEmail]! + points;
      } else {
        userPoints[userEmail] = points;
      }
    }

    List<Map<String, dynamic>> rankings = userPoints.entries
        .map((entry) => {'userEmail': entry.key, 'points': entry.value})
        .toList();

    rankings.sort((a, b) => b['points'].compareTo(a['points']));

    return rankings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFEF4A27),
        title: Text('Ranking'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchRankings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            }

            final rankings = snapshot.data!;

            return ListView.builder(
              itemCount: rankings.length,
              itemBuilder: (context, index) {
                final user = rankings[index];
                final userEmail = user['userEmail'];
                final points = user['points'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0XFFEF4A27),
                    child: Text((index + 1).toString()),
                  ),
                  title: Container(
                    height: 44,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(
                          0XFFEF4A27,
                        ),
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          userEmail,
                        ),
                        Text(
                          '$points Points',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  // trailing: Text('$points Points',
                  //     style: TextStyle(color: Colors.green)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
