import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int currentPageIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoryScreen();
    var activePageTitle = 'Categories';

    if (currentPageIndex == 1) {
      activeScreen = MealsScreen(meals: []);
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: _selectedTab,
      ),
    );
  }
}
