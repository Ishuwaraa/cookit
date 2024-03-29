import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/screens/profile/test_edit_recipe.dart';
import 'package:cookit/screens/test_recipe_details.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class FoodCard extends StatefulWidget {

  // final Function()? onTap;
  final String type;
  const FoodCard(this.recipe, {required this.type, super.key});

  final Recipe recipe;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {

  bool addedToFav = false;

  void refreshData() {
    // Provider.of<RecipeStore>(context, listen: false).fetchRecipesOnce();
    RecipeStore store = RecipeStore();
    store.fetchRecipesOnce();
    print('fetched');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.type == 'detail'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TestRecipeDetails(recipeId: widget.recipe.recipeId)));
        }else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TestEditRecipe(recipeId: widget.recipe.recipeId)));
        }
      },
      child: Container(
        width: 500.0,
        height: 200.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipOval(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/cookit-logo.png'),
                  image: NetworkImage(widget.recipe.photoUrl),
                  width: 180.0,
                  height: 180.0,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 180.0,
                      height: 180.0,
                      color: Colors.grey,
                      child: const Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.recipe,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    // Text(recipe.recipeId),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(
                          Icons.dinner_dining,
                          color: Color(0xFF86BF3E),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            widget.recipe.category,
                            style: const TextStyle(color: Color(0xFF86BF3E)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color(0xFF86BF3E),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            widget.recipe.time,
                            style: const TextStyle(
                              color: Color(0xFF86BF3E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.room_service,
                          color: Color(0xFF86BF3E),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Serves ${widget.recipe.servings}',
                          style: const TextStyle(
                            color: Color(0xFF86BF3E),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            addedToFav = !addedToFav;
                            // Recipe.addOrRemoveFav();
                          });
                          print(addedToFav);
                        },
                        child: Icon(
                          addedToFav? Icons.favorite_outlined : Icons.favorite_border,
                          // Recipe.addedToFav? Icons.favorite_outlined : Icons.favorite_border,
                          size: 24,
                          color: const Color(0xFF86BF3E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
