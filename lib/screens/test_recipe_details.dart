import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestRecipeDetails extends StatefulWidget {

  final String recipeId;
  const TestRecipeDetails({required this.recipeId, super.key});

  @override
  State<TestRecipeDetails> createState() => _TestRecipeDetailsState();
}

class _TestRecipeDetailsState extends State<TestRecipeDetails> {

  late Recipe _recipe;
  bool loading = false;
  final _commentController = TextEditingController();

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

  void addComment (String recipeId, String comment) async {
    if(_commentController.text.isNotEmpty){
      bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).addComment(recipeId, comment);

      if(isSuccess) {
        getRecipeDetails(recipeId);
        _commentController.clear();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Comment added'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please write your comment'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  void addToFavourite(String userId, String recipeId) async {
    bool isSuccess = await DatabaseService.addToFavourite(userId, recipeId);
    if(isSuccess){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Recipe added to favourites'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sorry, an error occured while adding to favourites'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getRecipeDetails(widget.recipeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

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
          Row(
            children: [
              Text('id: ${_recipe.recipeId}'),
              const SizedBox(width: 20.0,),
              GestureDetector(
                onTap: () {
                  addToFavourite(user.userId, _recipe.recipeId);
                },
                child: const Icon(Icons.favorite_outline)
              ),
            ],
          ),          
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
          Text('time: under ${_recipe.time}'),
          Text('description: ${_recipe.description}'),
          const SizedBox(height: 20.0,),
          Expanded(
            child: ListView.builder(
              itemCount: _recipe.comments!.length,
              itemBuilder: (context, index) {
                return Text(_recipe.comments![index]);
              }
            ),
          ),
          const SizedBox(height: 20.0,),
          TextField(
            controller: _commentController,                      
            obscureText: false,
          ),
          const SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: () {
              print(_commentController.text.trim());
              addComment(_recipe.recipeId, _commentController.text.trim());
            }, 
            child: const Text('add comment'),
          )
        ]
      ),
    );
  }
}