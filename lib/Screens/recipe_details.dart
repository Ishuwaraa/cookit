import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/screens/test_comment.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetailsPage extends StatefulWidget {

  final String recipeId;
  final bool addToFav;
  const RecipeDetailsPage({required this.recipeId, required this.addToFav, super.key});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {

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

  void addComment (String recipeId, String comment, String name, String image) async {
    if(_commentController.text.isNotEmpty){
      bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).addComment(recipeId, comment, name, image);

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
    List<dynamic> recipeIds = await DatabaseService.getFavRecipeIds(userId);

    if(recipeIds.isEmpty){
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
    }else{
      bool valid = true;
      for(int i = 0; i < recipeIds.length; i++){
        if(recipeId == recipeIds[i]){
          valid = false;
          break;
        }
      }

      if(valid){
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
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Recipe is already in your favourites'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }
    }
  }

  void deleteFromFav(String userId, String recipeId) async {
    // setState(() => loading = true);
    bool isSuccess = await DatabaseService.deleteFromFav(userId, recipeId);
    // setState(() => loading = false);
    if(isSuccess){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Recipe removed'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }else{
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sorry, an error occured'),
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
            appBar: AppBar(
              title: const AppbarTitle(title: 'Recipe'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      shareRecipe(_recipe.recipe, _recipe.ingredients, _recipe.time, _recipe.description, _recipe.servings);
                    },
                    child: const Icon(Icons.share)
                  ),
                ),
              ],
            ),
            body: SlidingUpPanel(
              minHeight: 400,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
              panel: _buildPanel(user, userData),
              body: _buildBody(),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          );
        }else{
          return const Loading();
        }
      },
    );
  }

  Widget _buildPanel(UserModel user, UserData userData) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 270, // Specify the maximum width for wrapping
                  child: Text(_recipe.recipe,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true, // Allow text to wrap to a new line
                  ),
                ),
                IconButton(
                  icon: (widget.addToFav)? const Icon(Icons.favorite_outline, color: Color(0xFF86BF3E), size: 40,) : const Icon(Icons.favorite, color: Color(0xFF86BF3E), size: 40,),
                  onPressed: () {
                    if(widget.addToFav){
                      addToFavourite(user.userId, _recipe.recipeId);
                    }else{
                      deleteFromFav(user.userId, _recipe.recipeId);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTag(_recipe.category),
                _buildTag(_recipe.time),
                _buildTag(_recipe.servings),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: _recipe.ingredients.split(',').map((ingredient) {
                return Center(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 15,
                        color: Color(0xFF86BF3E),
                      ),
                      const SizedBox(width: 5),
                      Text(ingredient,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }).toList(),
              
              // [
              //   Center(
              //     child: Row(
              //       children: [
              //         Icon(
              //           Icons.circle,
              //           size: 15,
              //           color: Color(0xFF86BF3E),
              //         ),
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           'Ingredients 1',
              //           style: TextStyle(fontSize: 18),
              //         ),
              //       ],
              //     ),
              //   ),
              //   SizedBox(
              //     height: 10,
              //   ),                
              // ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(_recipe.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Comments",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // ListView.builder(
            //   itemCount: (_recipe.comments!.isEmpty)? _recipe.comments!.length : 1 ,
            //   itemBuilder: (context, index) {
            //     List<String> comment = [];
            //     List<String> name = [];
            //     if(_recipe.comments != null){
            //       _recipe.comments!.forEach((data) => {
            //         comment.add(data['comment']),
            //         name.add(data['name']),
            //       });
            //     }
            //     return Text('${comment[index]}: ${name[index]}');
            //   }
            // ),
            const SizedBox(height: 10),
            Container(
              width: 400, // Set container width as needed
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Write your comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 8.0), // Spacer between text field and button
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF86BF3E), // Circular background color
                    ),
                    child: IconButton(
                      onPressed: () {
                        addComment(_recipe.recipeId, _commentController.text.trim(), userData.name, userData.profilePicUrl);
                        print(_commentController.text.trim());
                      },
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white, // Set the arrow icon color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if(_recipe.comments!.isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TestComment(recipeId: _recipe.recipeId)));
                print(_recipe.comments!.length);
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'View All Comments',
                    style: TextStyle(
                      color: Color(0xFF86BF3E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Image.network(
            _recipe.photoUrl, // Replace 'assets/r1.png' with your local image path
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF86BF3E),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: (text != '1' && text != '2' && text != '3')
          ? Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            )
          : Text(
              '$text servings',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),          
      ),
    );
  }
}
