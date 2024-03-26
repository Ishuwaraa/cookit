import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:flutter/material.dart';

class TestRecipeDetails extends StatefulWidget {

  final String recipeId;
  const TestRecipeDetails({required this.recipeId, super.key});

  @override
  State<TestRecipeDetails> createState() => _TestRecipeDetailsState();
}

class _TestRecipeDetailsState extends State<TestRecipeDetails> {

  late Recipe _recipe;
  bool loading = false;

  void getRecipeDetails (String recipeId) async {
    try{
      setState(() => loading = true);
      Recipe recipe = await DatabaseService.getRecipeDetails(recipeId);  
      setState(() {
        _recipe = recipe;
        loading = false;
      });
    }catch (e) {
      print(e.toString());
    }    
  }

  @override
  void initState() {
    getRecipeDetails(widget.recipeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading? const Loading() : Scaffold(
      appBar: AppBar(title: AppbarTitle(title: _recipe.recipe,)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: FadeInImage(
              placeholder: const AssetImage('assets/cookit-logo.png'),
              image: NetworkImage(_recipe.photoUrl),
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
          Text('id: ${_recipe.recipeId}'),
          Text('category: ${_recipe.category}'),
          const Text('ingredients:'),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _recipe.ingredients.split(',').map((ingredient) {
                  return Text(ingredient.trim());
                }).toList(),
              ),
            ],
          ),
          Text('servings: ${_recipe.servings}'),
          Text('time: ${_recipe.time}'),
          Text('description: ${_recipe.description}'),
        ]
      ),
    );
  }
}