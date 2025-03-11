import 'package:flutter/material.dart';
import 'package:movie_stream/screens/detail_screen/detail_screen.dart';
import 'package:movie_stream/screens/home_screen/featured_movie_card.dart';
import 'package:movie_stream/screens/home_screen/trending_movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<Map<String, String>> movies = [
  {
    "image": "images/home_assets/avenger_endgame.png",
    "title": "Avengers: Endgame",
    "rating": "8.4",
  },
  {
    "image": "images/home_assets/star_war.png",
    "title": "Star Wars: The Last Jedi",
    "rating": "7.0",
  },
  {"image": "images/home_assets/tenet.png", "title": "Tenet", "rating": "8.5"},
  {
    "image": "images/home_assets/wonder_women.png",
    "title": "Wonder Women",
    "rating": "8.6",
  },
];

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF15141F),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Stream ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: "Everywhere",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF121019),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            FeaturedMovieCard(),
            const SizedBox(height: 24),
            const Text(
              "Trending",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  double difference = index - currentPage;

                  final Matrix4 matrix =
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateY(difference * 0.08);

                  double scale = (1 - (difference.abs() * 0.12)).clamp(
                    0.88,
                    1.05,
                  );

                  return Transform(
                    transform: matrix,
                    alignment: FractionalOffset.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.2),
                      child: Transform.scale(
                        scale: scale,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(),
                              ),
                            );
                          },
                          child: TrendingMovieCard(
                            scale: scale,
                            image: movies[index]["image"]!,
                            title: movies[index]["title"]!,
                            rating: movies[index]["rating"]!,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
