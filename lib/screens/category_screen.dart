import 'package:flutter/material.dart';

import 'package:meals_app/Models/category.dart';
import 'package:meals_app/Models/meal.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals =
        widget.availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder:
          (context, child) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
    );
  }
}
