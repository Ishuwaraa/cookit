import 'package:cookit/Screens/profile/edit_post.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/screens/recipe/recipe_details.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type == 'detail') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => TestRecipeDetails(recipeId: widget.recipe.recipeId, addToFav: true,)));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipeDetailsPage(
                        recipeId: widget.recipe.recipeId,
                        addToFav: true,
                      )));
        } else if (widget.type == 'fav') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => TestRecipeDetails(recipeId: widget.recipe.recipeId, addToFav: false,)));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipeDetailsPage(
                        recipeId: widget.recipe.recipeId,
                        addToFav: false,
                      )));
        } else {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => TestEditRecipe(recipeId: widget.recipe.recipeId)));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditRecipe(recipeId: widget.recipe.recipeId)));
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
                    // Text(widget.userId),
                    Text(
                      widget.recipe.recipe,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
