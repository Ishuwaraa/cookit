import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestComment extends StatefulWidget {

  final String recipeId;

  const TestComment({required this.recipeId, super.key});

  @override
  State<TestComment> createState() => _TestCommentState();
}

class _TestCommentState extends State<TestComment> {

  bool loading = false;
  late Recipe _recipe;
  final _commentController = TextEditingController();

  void getRecipeDetails(String recipeId) async {
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
              title: const AppbarTitle(title: 'Comments'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('comments:'),
                const SizedBox(height: 20.0,),
                Expanded(
                  child: ListView.builder(
                    itemCount: _recipe.comments!.length,
                    itemBuilder: (context, index) {
                      List<String> comment = [];
                      List<String> name = [];
                      List<String> image = [];

                      if(_recipe.comments != null){
                        _recipe.comments!.forEach((data) => {
                          comment.add(data['comment']),
                          name.add(data['name']),
                          image.add(data['image']),
                        });
                      }
                      return Row(
                        children: [
                          // if(image.isNotEmpty)
                            Image.network(
                              image[index],
                              width: 50.0,
                              height: 50.0,
                            ),
                          Text('${name[index]}: ${comment[index]}'),
                        ],
                      );
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
                    addComment(_recipe.recipeId, _commentController.text.trim(), userData.name, userData.profilePicUrl);
                  }, 
                  child: const Text('add comment'),
                )
              ],
            ),
          );
        }else{
          return const Loading();
        }
      },
    );
  }
}