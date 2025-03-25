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
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          CategoryGridItem(category: availableCategories[1]),
          CategoryGridItem(category: availableCategories[2]),
          CategoryGridItem(category: availableCategories[3]),
          CategoryGridItem(category: availableCategories[4]),
          CategoryGridItem(category: availableCategories[5]),
          CategoryGridItem(category: availableCategories[6]),
        ],
      ),
    );
  }
}
