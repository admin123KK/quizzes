import 'package:flutter/material.dart';
import 'package:quiznep/explorepage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
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
                        // Profile Picture with Offset
                        Transform.translate(
                          offset: const Offset(0, -50), // Move it up
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
                              const SizedBox(height: 10), // Add spacing
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
                                    color: const Color(
                                      0XFFEF4A27,
                                    ),
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
                                            'Points', '1000'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        _builDivider(),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        _buildStateItem(Icons.public_outlined,
                                            'World', '#1'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        _builDivider(),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        _buildStateItem(Icons.groups_outlined,
                                            'Local', '#69'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        _builDivider(),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        _buildStateItem(Icons.whatshot_outlined,
                                            'Streak', '369'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Badge',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0XFFEF4A27)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Stats',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                        'assets/image/firstbadge.png'),
                                  ),
                                  const Text('Rank 1')
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                        'assets/image/secondbadge.png'),
                                  ),
                                  const Text('Rank 2')
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                        'assets/image/thirdbadge.png'),
                                  ),
                                  const Text('Rank 3')
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                        'assets/image/streakbadge.png'),
                                  ),
                                  const Text('Member')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                  const Icon(
                    Icons.home_outlined,
                    size: 31,
                    color: Colors.white,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Explorepage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.explore_outlined,
                      size: 31,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.stacked_bar_chart_outlined,
                    size: 31,
                    color: Colors.white,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profilepage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.person_outline,
                      size: 31,
                      color: Colors.black,
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

Widget _buildStateItem(IconData icon, String label, String value) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: 30,
        color: Colors.black,
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        label,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )
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
