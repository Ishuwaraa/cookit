class Recipe {

  final String userId;
  final String recipe;
  final String ingredients;
  final String time;
  final String servings;
  final String category;
  final String description;
  final String photoUrl;
  // final String isFav;

  Recipe({
    required this.userId,
    required this.recipe, 
    required this.ingredients, 
    required this.time, 
    required this.servings, 
    required this.category,
    required this.description, 
    required this.photoUrl,
    // required this.isFav,
  });

}

class UserFavRecipe {

  final String isFav;

  UserFavRecipe({required this.isFav});
}