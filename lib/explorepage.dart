import 'package:flutter/material.dart';
import 'package:quiznep/welcompage.dart';

class Explorepage extends StatefulWidget {
  const Explorepage({super.key});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Text(
                    'Explore',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color(0XFFEF4A27),
                    ),
                  ),
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17)),
                color: Color(0XFFEF4A27),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Welcompage()));
                    },
                    child: const Icon(
                      Icons.home_outlined,
                      size: 31,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.explore_outlined,
                    size: 31,
                    color: Colors.black,
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
