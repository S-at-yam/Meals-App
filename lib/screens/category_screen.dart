import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick your category')),
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
