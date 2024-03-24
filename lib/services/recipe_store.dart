import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';

class RecipeStore extends ChangeNotifier {
  
  final List<Recipe> _recipes = [];

  get recipes => _recipes;

  //add recipe
  Future<bool> addRecipe(Recipe recipe) async {
    bool isSuccess = await DatabaseService.addRecipeUsingModel(recipe);
    if(isSuccess){
      _recipes.add(recipe);
      notifyListeners();  //notifying listeners data has been changed to build again
    }
    return isSuccess;
  }

  //fetching recipes at the start
  void fetchRecipesOnce() async {
    if(_recipes.isEmpty){
      try{
        //try with the DatabaseService().recipes. might be user full cuz i gott pass the userId as the param
        List<Recipe> fetchedRecipes = await DatabaseService.recipes.first;
        _recipes.addAll(fetchedRecipes);
        notifyListeners();
      }catch (e) {
        print(e.toString());
      }
    }
  }
}