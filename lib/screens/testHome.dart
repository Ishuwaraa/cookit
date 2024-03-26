import 'package:cookit/Components/category_list.dart';
import 'package:cookit/Components/popular_recipe_card.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Popular Recipes",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 270.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    PopularRecipeCard(),
                    PopularRecipeCard(),
                    PopularRecipeCard(),
                    PopularRecipeCard(),
                    PopularRecipeCard(),
                    PopularRecipeCard(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Categories",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBoxListView(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Recipes",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Consumer<RecipeStore>(
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.recipes.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          FoodCard(value.recipes[index]),
                        ],
                      );
                      // return FoodCard(value.recipes[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
