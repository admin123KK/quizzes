import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiznep/explorepage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    fetchUserPoints();
  }

  Future<void> fetchUserPoints() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return;
      }
      final querySnapshot = await FirebaseFirestore.instance
          .collection('quizResults')
          .where('userEmail', isEqualTo: user.email)
          .get();

      int points = querySnapshot.docs.fold<int>(0,
          (previousValue, doc) => previousValue + (doc['points'] ?? 0) as int);

      setState(() {
        totalPoints = points;
      });
    } catch (e) {
      print('Error fetching user points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color(0XFFEF4A27),
        actions: const [
          Padding(
            padding: EdgeInsets.all(19.0),
            child: Icon(
              Icons.settings_outlined,
              color: Colors.black,
              size: 28,
            ),
          )
        ],
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
                    height: 750,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -50),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFEF4A27),
                                  borderRadius: BorderRadius.circular(70),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.asset(
                                    'assets/image/male.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Sky Karki',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Container(
                                  height: 110,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color: const Color(0XFFEF4A27),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildStateItem(Icons.star_outline,
                                            'Points', totalPoints.toString()),
                                        const SizedBox(width: 20),
                                        _builDivider(),
                                        const SizedBox(width: 30),
                                        _buildStateItem(Icons.public_outlined,
                                            'World', '#1'),
                                        const SizedBox(width: 20),
                                        _builDivider(),
                                        const SizedBox(width: 30),
                                        _buildStateItem(Icons.groups_outlined,
                                            'Local', '#69'),
                                        const SizedBox(width: 20),
                                        _builDivider(),
                                        const SizedBox(width: 30),
                                        _buildStateItem(Icons.whatshot_outlined,
                                            'Streak', '369'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildTabItem('Badge', true),
                                  _buildTabItem('Stats', false),
                                  _buildTabItem('Details', false),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildBadgeRow([
                          {
                            'image': 'assets/image/firstbadge.png',
                            'label': 'Rank 1'
                          },
                          {
                            'image': 'assets/image/secondbadge.png',
                            'label': 'Rank 2'
                          }
                        ]),
                        const SizedBox(height: 40),
                        _buildBadgeRow([
                          {
                            'image': 'assets/image/thirdbadge.png',
                            'label': 'Rank 3'
                          },
                          {
                            'image': 'assets/image/streakbadge.png',
                            'label': 'Member'
                          }
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNavigationBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStateItem(IconData icon, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Colors.black),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 10),
        Text(value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _builDivider() {
    return Container(
      height: 70,
      width: 1,
      color: Colors.white.withOpacity(0.6),
    );
  }

  Widget _buildTabItem(String label, bool isActive) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              color: isActive ? const Color(0XFFEF4A27) : Colors.grey,
              borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }

  Widget _buildBadgeRow(List<Map<String, String>> badges) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: badges
            .map((badge) => Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(badge['image']!),
                    ),
                    Text(badge['label']!),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0XFFEF4A27),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17),
          topRight: Radius.circular(17),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home_outlined, size: 31, color: Colors.white),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Explorepage()),
            ),
            child: const Icon(Icons.explore_outlined,
                size: 31, color: Colors.white),
          ),
          const Icon(Icons.stacked_bar_chart_outlined,
              size: 31, color: Colors.white),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profilepage()),
            ),
            child:
                const Icon(Icons.person_outline, size: 31, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
