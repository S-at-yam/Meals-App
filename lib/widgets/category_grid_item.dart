import 'package:flutter/material.dart';
import 'package:meals_app/Models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;
  @override
  Widget build(BuildContext context) {
    return Container(color: category.color);
  }
}
