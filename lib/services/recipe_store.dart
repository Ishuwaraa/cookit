import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';

class RecipeStore extends ChangeNotifier {
  
  final List<Recipe> _recipes = [];
  final List<Recipe> _userRecipes = [];
  final List<Recipe> _filteredRecipes = [];

  get recipes => _recipes;
  get userRecipes => _userRecipes;
  get filteredRecipes => _filteredRecipes;

  //add recipe
  Future<bool> addRecipe(Recipe recipe) async {
    bool isSuccess = await DatabaseService.addRecipeUsingModel(recipe);
    if(isSuccess){
      _recipes.add(recipe);
      _userRecipes.add(recipe);
      notifyListeners();  //notifying listeners data has been changed to build again
    }
    return isSuccess;
  }

  //fetching recipes at the start
  void fetchRecipesOnce() async {
    if(_recipes.isEmpty){
      try{
        //try with the DatabaseService().recipes. might be usefull cuz i gott pass the userId as the param
        List<Recipe> fetchedRecipes = await DatabaseService.recipes.first;
        _recipes.addAll(fetchedRecipes);
        notifyListeners();
      }catch (e) {
        print(e.toString());
      }
    }
  }

  //fetching user recipes
  void fetchUserRecipes(String userId) async {
    if(_userRecipes.isEmpty){
      try{
        List<Recipe> fetchedUserRecipes = await DatabaseService.getuserRecipes(userId).first;
        _userRecipes.addAll(fetchedUserRecipes);
        notifyListeners();
      }catch (e) {
        print(e.toString());
      }
    }
  }

  Future<bool> fetchFilteredRecipes(String type, String dish) async {
    bool isSuccess = false;

    if(_filteredRecipes.isEmpty){
      try{
        List<Recipe> fetchedFilteredRecipes = await DatabaseService.getFilteredRecipes(type, dish).first;
        _filteredRecipes.addAll(fetchedFilteredRecipes);
        notifyListeners();
        if(fetchedFilteredRecipes.isNotEmpty){
          isSuccess = true;
        }
      }catch (e) {
        print(e.toString());
      }
    }
    return isSuccess;
  }

  Future<bool> updateRecipe(Recipe recipe) async {
    bool isSuccess = false;

    try{
      isSuccess = await DatabaseService.updateRecipe(recipe);
      notifyListeners();
    }catch (e) {
      print(e.toString());
    }

    return isSuccess;
  }

  Future<bool> deleteRecipe(String recipeId) async {
    bool isSuccess = false;

    try{
      isSuccess = await DatabaseService.deleteRecipe(recipeId);
      notifyListeners();
    }catch (e) {
      print(e.toString());
    }

    return isSuccess;
  }
}