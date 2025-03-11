import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> movies = [
    {
      "title": "Soul",
      "year": "(2020)",
      "imagePath": "images/discover_assets/soul.png",
    },
    {
      "title": "Knives Out",
      "year": "(2019)",
      "imagePath": "images/discover_assets/knives.png",
    },
    {
      "title": "Onward",
      "year": "(2020)",
      "imagePath": "images/discover_assets/onward.png",
    },
    {
      "title": "Mulan",
      "year": "(2020)",
      "imagePath": "images/discover_assets/mulan.png",
    },
    {
      "title": "Birds of Prey",
      "year": "(2020)",
      "imagePath": "images/discover_assets/birds_of_prey.png",
    },
    {
      "title": "Now You See Me 2",
      "year": "(2016)",
      "imagePath": "images/discover_assets/now_you_see_me.png",
    },
    {
      "title": "Enola Holmes",
      "year": "(2020)",
      "imagePath": "images/discover_assets/enola_holmes.png",
    },
    {
      "title": "Ready Player One",
      "year": "(2018)",
      "imagePath": "images/discover_assets/ready_player_one.1.png",
    },
  ];

  final List<Map<String, String>> tvseries = [
    {
      "title": "Stranger Things",
      "imagePath": "images/discover_assets/stranger_things.png",
    },
    {"title": "The Flash", "imagePath": "images/discover_assets/flash.png"},
    {
      "title": "Money Heist",
      "imagePath": "images/discover_assets/money_heist.png",
    },
    {
      "title": "Doctor Who",
      "imagePath": "images/discover_assets/doctor_who.png",
    },
    {
      "title": "Breaking Bad",
      "imagePath": "images/discover_assets/breaking_bird.png",
    },
    {"title": "Sherlock", "imagePath": "images/discover_assets/sherlock.png"},
    {"title": "Chernobyl", "imagePath": "images/discover_assets/chernobyl.png"},
    {
      "title": "13 Reasons Why",
      "imagePath": "images/discover_assets/13_reason_why.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15141F),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Find Movies, TV series, \nand more..",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.normal,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFF211F30),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "Sherlock Holmes",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TabBar(
                          dividerColor: Colors.transparent,
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 2.5,
                              color: Colors.orange,
                            ),
                            insets: EdgeInsets.fromLTRB(12, 0, 12, 6),
                          ),
                          labelColor: Colors.orange,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: false,
                          labelPadding: EdgeInsets.symmetric(horizontal: 12),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          tabs: [
                            const Tab(text: "Movies"),
                            const Tab(text: "Tv Series"),
                            const Tab(text: "Documentary"),
                            const Tab(text: "Sports"),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildStaggeredGrid(movies),
              _buildStaggeredGrid(tvseries),
              Center(
                child: Text(
                  "Documentary",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Center(
                child: Text(
                  "Sports",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid(List<Map<String, String>> items) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children:
              items.map((item) {
                return _buildCard(
                  title: item["title"]!,
                  year: item.containsKey("year") ? item["year"]! : "",
                  imagePath: item["imagePath"]!,
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    String? year,
    required String imagePath,
  }) {
    final Random random = Random();
    double height = random.nextBool() ? 220 : 280;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
        if (year != null && year.isNotEmpty)
          Text(year, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}
