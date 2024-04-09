import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/screens/recipe/recipe_details.dart';
import 'package:flutter/material.dart';

class PopularRecipeCard extends StatelessWidget {

  final Recipe recipe;
  const PopularRecipeCard( {required this.recipe, super.key} );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailsPage(recipeId: recipe.recipeId, addToFav: true,))),
      child: Container(
        width: 200.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: ClipOval(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/cookit-logo.png'),
                  image: NetworkImage(recipe.photoUrl),
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
            const SizedBox(height: 10,), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                recipe.recipe,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 10), 
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.dinner_dining, color: Color(0xFF86BF3E),),
                  const SizedBox(width: 5),
                  Text(
                    recipe.category,
                    style: const TextStyle(
                      color: Color(0xFF86BF3E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  const Icon(Icons.access_time,color: Color(0xFF86BF3E),),
                  const SizedBox(width: 5),
                  Text(
                    recipe.time,
                    style: const TextStyle(
                      color: Color(0xFF86BF3E),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Icon(Icons.room_service,color: Color(0xFF86BF3E),),
                  const SizedBox(width: 5),
                  Text(
                    recipe.servings,
                    style: const TextStyle(color: Color(0xFF86BF3E)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
