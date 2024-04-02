import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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

  void addComment (String recipeId, String comment, String name) async {
    if(_commentController.text.isNotEmpty){
      bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).addComment(recipeId, comment, name);

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

  void shareRecipe (String recipe, String ingredients, String time, String desc, String serving){
    String msg = '''$recipe \n\n
      ingredients: $ingredients 
      time: $time 
      serving size: $serving \n
      $desc''';
    Share.share(msg);
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

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {    
        if(snapshot.hasData){
          UserData userData = snapshot.data!;

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
                    const SizedBox(width: 20.0,),
                    GestureDetector(
                      onTap: () {
                        shareRecipe(_recipe.recipe, _recipe.ingredients, _recipe.time, _recipe.description, _recipe.servings);
                      },
                      child: const Icon(Icons.share)
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
                const Text('comments:'),
                const SizedBox(height: 20.0,),
                Expanded(
                  child: ListView.builder(
                    itemCount: _recipe.comments!.length,
                    itemBuilder: (context, index) {
                      List<String> comment = [];
                      List<String> name = [];
                      if(_recipe.comments != null){
                        _recipe.comments!.forEach((data) => {
                          comment.add(data['comment']),
                          name.add(data['name']),
                        });
                      }
                      return Text('${comment[index]}: ${name[index]}');
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
                    addComment(_recipe.recipeId, _commentController.text.trim(), userData.name);
                  }, 
                  child: const Text('add comment'),
                )
              ]
            ),
          );
        }else{
          return const Loading();
        }
      },
    );    
  }
}