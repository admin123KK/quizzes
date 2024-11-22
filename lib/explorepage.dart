import 'package:flutter/material.dart';
import 'package:quiznep/registerpage.dart';
import 'package:quiznep/signinpage.dart';
import 'package:quiznep/verifypage.dart';
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 40,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    height: 400,
                    width: 370,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(17)),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        ' TOP PICKS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        buildCategoryBox('Maths', Icons.calculate, Colors.red,
                            context, Welcompage()),
                        buildCategoryBox('History', Icons.book_outlined,
                            Colors.red, context, Signinpage()),
                        buildCategoryBox('Science', Icons.science_outlined,
                            Colors.red, context, Registerpage()),
                        buildCategoryBox('Sports', Icons.sports_soccer,
                            Colors.red, context, Verifypage())
                      ]),
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

Widget buildCategoryBox(
    String title, IconData icon, Color color, BuildContext context, page) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      // Navigate to the respective page
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
