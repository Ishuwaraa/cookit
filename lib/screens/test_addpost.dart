import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/image_upload.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestAddRecipe extends StatefulWidget {
  const TestAddRecipe({super.key});

  @override
  State<TestAddRecipe> createState() => _TestAddRecipeState();
}

class _TestAddRecipeState extends State<TestAddRecipe> {

  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> times = ['15min', '30min', '45min', '60min'];
  final List<String> servings = ['1', '2', '3', '4',];
  final List<String> categories = ['breakfast', 'lunch', 'dinner', 'snack', 'dessert', 'soup'];

  String selectedTime = '15min';
  String selectedServing = '1';
  String selectedCategory = 'breakfast';
  String imageUrl = '';

  void updateImageUrl(String newUrl) {
    setState(() {
      imageUrl = newUrl; 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Recipe image added'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
      print('new image: $imageUrl');
    });
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void addRecipe(String userId) async {
    if(_recipeNameController.text.isNotEmpty && _ingredientsController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
      print('${_recipeNameController.text.trim()}, ${_ingredientsController.text.trim()}, $selectedTime, $selectedServing, $selectedCategory, ${_descriptionController.text.trim()}');

      if(imageUrl.isNotEmpty) {
        bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).addRecipe(
          Recipe(
            userId: userId, 
            recipeId: '',
            recipe: _recipeNameController.text.trim(), 
            ingredients: _ingredientsController.text.trim(), 
            time: selectedTime, 
            servings: selectedServing, 
            category: selectedCategory, 
            description: _descriptionController.text.trim(), 
            photoUrl: imageUrl,
          )
        );
        if(isSuccess){
          print('recipe added');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Recipe added.'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF86BF3E),
          ));
          _recipeNameController.clear();
          _ingredientsController.clear();
          _descriptionController.clear();
          selectedTime = '15min';
          selectedServing = '1';
          selectedCategory = 'breakfast';
          setState(() => imageUrl = '');
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sorry we had trouble uploading your recipe. Try again later.'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF86BF3E),
          ));
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Add an image to upload your recipe.'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }
      

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all the fields.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    // return StreamBuilder<UserData>(
    //   stream: DatabaseService(userId: user.userId).,
    //   builder: (context, AsyncSnapshot<Recipe> snapshot) {

    //   },
    // )

    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Add Recipe'),
      ),
      body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Adjust the height as needed
                  Center(
                    child: CircleAvatar(
                      radius: 90, // Adjust the size as needed
                      // backgroundImage: NetworkImage(userData.profilePicUrl),
                      backgroundImage: imageUrl.isEmpty ? const AssetImage('assets/recipe_1.png') as ImageProvider<Object>? : NetworkImage(imageUrl),
                    ),
                  ),
                  Center(
                    child: ImageUpload(onImageUrlChange: (newUrl) {
                      updateImageUrl(newUrl);
                    }),
                  ),
                  const SizedBox(
                      height: 20), // Add spacing between CircleAvatar and TextField
                  TextField(
                    controller: _recipeNameController,                      
                    obscureText: false,
                  ),
                  TextField(
                    controller: _ingredientsController,                      
                    obscureText: false,
                  ),
                  DropdownButton<String>(
                    value: selectedTime,
                    items: times.map(
                      (time) => DropdownMenuItem(
                        value: time,
                        child: Text('under $time'),
                      )
                      ).toList(), 
                    onChanged: (time) => setState(() => selectedTime = time!),
                  ),
                  DropdownButton<String>(
                    value: selectedServing,
                    items: servings.map(
                      (serving) => DropdownMenuItem(
                        value: serving,
                        child: Text(serving),
                      )
                      ).toList(), 
                    onChanged: (serving) => setState(() => selectedServing = serving!),
                  ),
                  DropdownButton<String>(
                    value: selectedCategory,
                    items: categories.map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      )
                      ).toList(), 
                    onChanged: (category) => setState(() => selectedCategory = category!),
                  ),
                  TextField(
                    controller: _descriptionController,                      
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: ElevatedButton(
                      onPressed: () {addRecipe(user.userId);},
                      child: const Text('Add recipe'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}