import 'package:flutter/material.dart';

import 'package:meals_app/Provider/fav_meals_provider.dart';

import 'package:meals_app/Provider/filter_provider.dart';

import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int currentPageIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void _selectDrawerItem(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favMeals = ref.watch(favoriteMealsProvider);

    final availableMeals = ref.watch(filteredMealProvider);

    Widget activeScreen = CategoryScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (currentPageIndex == 1) {
      activeScreen = MealsScreen(meals: favMeals);
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
