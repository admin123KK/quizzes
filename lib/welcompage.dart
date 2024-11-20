import 'package:flutter/material.dart';

class Welcompage extends StatefulWidget {
  const Welcompage({super.key});

  @override
  State<Welcompage> createState() => _WelcompageState();
}

class _WelcompageState extends State<Welcompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Good Morning,\nManju Karki',
                      style: TextStyle(
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
                height: 200,
                width: 360,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 151),
                  child: Text(
                    'Featured',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.home_outlined,
                  size: 31,
                ),
                Icon(
                  Icons.explore_outlined,
                  size: 31,
                  color: Colors.white,
                ),
                Icon(
                  Icons.stacked_bar_chart_outlined,
                  size: 31,
                  color: Colors.white,
                ),
                Icon(
                  Icons.person_outline,
                  size: 31,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
