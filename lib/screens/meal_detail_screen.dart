import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Provider/fav_meals_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              bool wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavStatus(meal);
              if (wasAdded) {
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
              } else {
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
              }
            },

            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 8),
            Text(
              'Ingredients',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            for (final ingredient in meal.ingredients)
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                margin: EdgeInsets.only(left: 40, right: 20),
                width: double.infinity,
                child: Text(
                  '- $ingredient',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            for (final step in meal.steps)
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 20),
                child: Text(
                  '- $step',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
