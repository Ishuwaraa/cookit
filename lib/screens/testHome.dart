import 'package:cookit/Components/category_list.dart';
import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/card.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/components/popular_recipe_card.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  // @override
  // void initState() {
  //   Provider.of<RecipeStore>(context, listen: false).fetchRecipesOnce();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Recipe>> (
      stream: DatabaseService.recipes,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Loading();
        }
        if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.hasError}'),);
        }

        final List<Recipe> recipes = snapshot.data ?? [];
        if(recipes.isNotEmpty){
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
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 270.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return PopularRecipeCard(recipe: recipes[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 10,),
                    const SizedBoxListView(),
                    const SizedBox(height: 10,),
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipes.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            FoodCard(recipes[index], type: 'detail',),
                          ],
                        );
                        // return FoodCard(value.recipes[index]);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }else{
          return Scaffold(
            appBar: AppBar(
              title: const AppbarTitle(title: 'COOKIT'),
            ),
            body: const Center(child: Text('Sorry we have trouble loading content'),),
          );
        }
      },
    );
  }
}
