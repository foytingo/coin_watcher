import 'package:coin_watcher/screens/favorites_screen.dart';
import 'package:coin_watcher/screens/market_screen.dart';
import 'package:coin_watcher/screens/search_screen.dart';
import 'package:flutter/material.dart';


class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedScreen = 0;

  final List<Widget> _screens = const [SearchScreen(), MarketScreen(), FavoritesScreen()];

  _changeScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  Widget? _changeTitle(int selectedScreenIndex) {
    switch (selectedScreenIndex) {
      case 0: return const Text("");
      case 1: return const Text("Market");
      case 2: return const Text("Favorites");
      default: return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: _changeTitle(_selectedScreen),
      ),
      body: _screens[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        onTap: _changeScreen,
        items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance),label: "Market"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites")
          ],
      ),
    );
  }
}