import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {

  @override
  void initState() {
    Provider.of<RecipeStore>(context, listen: false).fetchRecipesOnce();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'COOKIT'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<RecipeStore>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.recipes.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 30,),
                        FoodCard(value.recipes[index]),
                      ],
                    );
                    // return FoodCard(value.recipes[index]);
                  },
                );
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}