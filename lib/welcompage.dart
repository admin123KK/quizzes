import 'package:flutter/material.dart';
import 'package:quiznep/explorepage.dart';

class Welcompage extends StatefulWidget {
  const Welcompage({super.key});

  @override
  State<Welcompage> createState() => _WelcompageState();
}

class _WelcompageState extends State<Welcompage> {
  String greeting = "";

  @override
  void initState() {
    updateGreeting();
    super.initState();
  }

  final List<String> items = [
    "Sky",
    "Abiskar",
    "Ritu",
    "Bibash",
    "Ram Hari",
    "Sushant",
    "Manish",
    "Sushant"
  ];

  void updateGreeting() {
    DateTime now = DateTime.now();

    int hour = now.hour;
    if (hour < 12) {
      setState(() {
        greeting = "Good Morning";
      });
    } else if (hour < 17) {
      setState(() {
        greeting = "Good Afternoon";
      });
    } else {
      greeting = "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$greeting,\nManju Karki',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFEF4A27),
                            fontSize: 18),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0XFFEF4A27),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          'assets/image/male.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RECENT QUIZ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(child: Text('Explore by testing your mind'))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: 370,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.grey, Color(0XFFEF4A27)],
                        begin: AlignmentDirectional.centerStart,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Featured',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Take part in challenges\n with friends and others',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 400, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Live Ranking',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  8, // Number of items in the ranking list
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Text(
                                      //   '${index + 1}. Sky ${index + 1}',
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                      Container(
                                        height: 50,
                                        width: 330,
                                        decoration: BoxDecoration(
                                          color: Color(0XFFEF4A27),
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/image/male.png'),
                                            Text('${index + 1}'),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              items[index],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 139,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${(1000 - index * 10)}.pt',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      // Text(
                                      //   '${(1000 - index * 10)} pts',
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //     color: Colors.black54,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0XFFEF4A27),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.home_outlined,
                    size: 31,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Explorepage()));
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
                  const Icon(
                    Icons.person_outline,
                    size: 31,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
