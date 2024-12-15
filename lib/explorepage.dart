import 'package:flutter/material.dart';
import 'package:quiznep/Sciencepage.dart';
import 'package:quiznep/historypage.dart';
import 'package:quiznep/mathsqpage.dart';
import 'package:quiznep/profilepage.dart';
import 'package:quiznep/quiz_service.dart';
import 'package:quiznep/welcompage.dart';
import 'package:video_player/video_player.dart';

class Explorepage extends StatefulWidget {
  const Explorepage({super.key});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://resource.flexclip.com/templates/video/720p/travel-agency-ad-city-paris-urban-promotional-vlog.mp4',
    )..initialize().then((_) {
        setState(() {}); // Rebuild to show the video once initialized
        _controller.play(); // Autoplay the video
        _controller.setLooping(true); // Loop the video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Explore Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0XFFEF4A27),
                      ),
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 40,
                      width: double.infinity,
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
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Top Picks
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                    child: Text(
                      'TOP PICKS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: _controller.value.isInitialized
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: FittedBox(
                                fit: BoxFit
                                    .cover, // Adjust the fit property as needed
                                child: SizedBox(
                                  width: _controller.value.size.width,
                                  height: _controller.value.size.height,
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                            )
                          : const Center(
                              child:
                                  CircularProgressIndicator()), // Show while video is loading
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Categories Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  // Categories Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        buildCategoryBox(
                          'Maths',
                          Icons.calculate,
                          Colors.red,
                          context,
                          const QuizPage(
                            category: 'category1',
                          ),
                        ),
                        buildCategoryBox(
                          'History',
                          Icons.book_outlined,
                          Colors.red,
                          context,
                          const Historypage(),
                        ),
                        buildCategoryBox(
                          'Science',
                          Icons.science_outlined,
                          Colors.red,
                          context,
                          const Sciencepage(),
                        ),
                        buildCategoryBox(
                          'Sports',
                          Icons.sports_soccer,
                          Colors.red,
                          context,
                          const Quizpage(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
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
                            builder: (context) => const Welcompage(),
                          ),
                        );
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Category Box Widget
Widget buildCategoryBox(String title, IconData icon, Color color,
    BuildContext context, Widget page) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
