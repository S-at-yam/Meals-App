import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Provider/meals_provider.dart';

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
  final List<Meal> favorites = [];

  Map<Filter, bool> _selectedFilters = kInitialFilter;

  void _toggleFavoriteMeal(Meal meal) {
    final isExisting = favorites.contains(meal);

    if (isExisting) {
      setState(() {
        favorites.remove(meal);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Item removed from favorites.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 2, 0, 0),
          ),
        );
      });
    } else {
      setState(() {
        favorites.add(meal);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Item added in favorites.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 2, 0, 0),
          ),
        );
      });
    }
  }

  void _selectedTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void _selectDrawerItem(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(selectedFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals =
        meals.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
    Widget activeScreen = CategoryScreen(
      onFavorite: _toggleFavoriteMeal,
      availableMeals: availableMeals,
    );
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
