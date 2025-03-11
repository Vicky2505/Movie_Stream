import 'package:flutter/material.dart';
import 'package:movie_stream/screens/discover_screen/discover_screen.dart';
import 'package:movie_stream/screens/home_screen/home_screen.dart';
import 'package:movie_stream/screens/profile_screen/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), DiscoverScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF211F30),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF15141F),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        iconSize: 36,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors:
                      _selectedIndex == 0
                          ? [Colors.orange, Colors.red]
                          : [Colors.grey, Colors.grey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: const Icon(Icons.home, size: 36, color: Colors.white),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedIndex == 1 ? Colors.orange : Colors.grey[800],
              ),
              child: Icon(
                Icons.play_arrow,
                size: 28,
                color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors:
                      _selectedIndex == 2
                          ? [Colors.orange, Colors.red]
                          : [Colors.grey, Colors.grey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: const Icon(Icons.person, size: 36, color: Colors.white),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
