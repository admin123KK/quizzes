import 'package:flutter/material.dart';
import 'package:quiznep/Sciencepage.dart';
import 'package:quiznep/historypage.dart';
import 'package:quiznep/poll_page.dart';
import 'package:quiznep/profilepage.dart';
import 'package:quiznep/sports_page.dart';
import 'package:quiznep/welcompage.dart';
import 'package:video_player/video_player.dart';

import 'mathspage.dart';

class Explorepage extends StatefulWidget {
  const Explorepage({super.key});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  late VideoPlayerController _controller;
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _searchFocusNode;
  bool _showDropdown = false;

  final List<Map<String, dynamic>> _categories = [
    {'title': 'Maths', 'icon': Icons.calculate, 'page': Mathpage()},
    {'title': 'History', 'icon': Icons.book_outlined, 'page': Historypage()},
    {'title': 'Science', 'icon': Icons.science_outlined, 'page': Sciencepage()},
    {'title': 'Sports', 'icon': Icons.sports_soccer, 'page': Sportspage()},
  ];

  List<Map<String, dynamic>> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://resource.flexclip.com/templates/video/720p/travel-agency-ad-city-paris-urban-promotional-vlog.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });

    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() {
      setState(() {
        _showDropdown = _searchFocusNode.hasFocus;
      });
    });

    // Initialize filtered categories
    _filteredCategories = _categories;
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _filterCategories(String query) {
    setState(() {
      _filteredCategories = _categories
          .where((category) =>
              category['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0XFFEF4A27),
                      ),
                    ),
                  ),
                  // Search Bar with Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (query) {
                              _filterCategories(query);
                            },
                          ),
                        ),
                        if (_showDropdown && _filteredCategories.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredCategories.length,
                              itemBuilder: (context, index) {
                                final category = _filteredCategories[index];
                                return ListTile(
                                  leading: Icon(
                                    category['icon'],
                                    color: Colors.red,
                                  ),
                                  title: Text(category['title']),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            category['page'] as Widget,
                                      ),
                                    );
                                    _searchController.clear();
                                    _searchFocusNode.unfocus();
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: _controller.value.size.width,
                                  height: _controller.value.size.height,
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
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
                      children: _filteredCategories
                          .map(
                            (category) => buildCategoryBox(
                              category['title'],
                              category['icon'],
                              Colors.red,
                              context,
                              category['page'] as Widget,
                            ),
                          )
                          .toList(),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PollPage(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.stacked_bar_chart_outlined,
                        size: 31,
                        color: Colors.white,
                      ),
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

  Widget buildCategoryBox(
    String title,
    IconData icon,
    Color color,
    BuildContext context,
    Widget page,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
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
              size: 30,
              color: Colors.white,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
