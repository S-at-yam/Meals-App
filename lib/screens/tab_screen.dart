import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int currentPageIndex = 0;
  final List<Meal> favorites = [];

  void _toggleFavoriteMeal(Meal meal) {
    final isExisting = favorites.contains(meal);

    if (isExisting) {
      setState(() {
        favorites.remove(meal);
      });
    } else {
      setState(() {
        favorites.add(meal);
      });
    }
  }

  void _selectedTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void _selectDrawerItem(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoryScreen(onFavorite: _toggleFavoriteMeal);
    var activePageTitle = 'Categories';

    if (currentPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: favorites,
        onFavorite: _toggleFavoriteMeal,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectItem: _selectDrawerItem),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        selectedItemColor: Colors.amber,
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
