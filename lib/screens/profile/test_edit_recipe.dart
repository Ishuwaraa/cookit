import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/image_upload.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestEditRecipe extends StatefulWidget {

  final String recipeId;
  // final VoidCallback refreshData;

  const TestEditRecipe({required this.recipeId, super.key});

  @override
  State<TestEditRecipe> createState() => _TestEditRecipeState();
}

class _TestEditRecipeState extends State<TestEditRecipe> {

  late Recipe _recipe;
  bool loading = false;

  TextEditingController _recipeNameController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  
  final List<String> times = ['15min', '30min', '45min', '60min'];
  final List<String> servings = ['1', '2', '3'];
  final List<String> categories = ['breakfast', 'lunch', 'brunch', 'dinner', 'snack', 'dessert', 'soup'];

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

  void getRecipeDetails (String recipeId) async {
    try{
      setState(() => loading = true);
      Recipe recipe = await DatabaseService.getRecipeDetails(recipeId);  
      setState(() {
        _recipe = recipe;
        loading = false;
        _recipeNameController.text = _recipe.recipe;
        _ingredientsController.text = _recipe.ingredients;
        _descriptionController.text = _recipe.description;
        selectedTime = _recipe.time;
        selectedServing = _recipe.servings;
        selectedCategory = _recipe.category;
      });
    }catch (e) {
      print(e.toString());
    }    
  }

  void updateRecipeDetails (String recipeId) async {
    if(_recipeNameController.text.isNotEmpty && _ingredientsController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
      print('${_recipeNameController.text.trim()}, ${_ingredientsController.text.trim()}, ${_descriptionController.text.trim()}');
      print('$selectedTime, $selectedCategory, $selectedServing');

      bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).updateRecipe(
        Recipe(
          userId: _recipe.userId, 
          recipeId: _recipe.recipeId, 
          recipe: _recipeNameController.text.trim(), 
          ingredients: _ingredientsController.text.trim(), 
          time: selectedTime, 
          servings: selectedServing, 
          category: selectedCategory,
          description: _descriptionController.text.trim(), 
          photoUrl: imageUrl.isEmpty? _recipe.photoUrl : imageUrl,
        )
      );

      if(isSuccess){
        // Navigator.pop(context);
        // widget.refreshData();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Recipe updated'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sorry we could not update your recipe'),
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

  void deleteRecipe() async {
    print(_recipe.recipeId);
    bool isSuccess = await Provider.of<RecipeStore>(context, listen: false).deleteRecipe(_recipe.recipeId);

    if(isSuccess){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Recipe successfully deleted.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sorry we could not delete your recipe.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  @override
  void initState() {
    getRecipeDetails(widget.recipeId);
    super.initState();
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    

    return loading? const Loading() : Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Edit Recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20), 
            Center(
              child: CircleAvatar(
                radius: 90, 
                backgroundImage: imageUrl.isEmpty ? NetworkImage(_recipe.photoUrl) : NetworkImage(imageUrl),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageUpload(type: 'camera', onImageUrlChange: (newUrl) {
                  updateImageUrl(newUrl);
                }),
                ImageUpload(type: 'gallery', onImageUrlChange: (newUrl) {
                  updateImageUrl(newUrl);
                }),
              ]
            ),
            const SizedBox(height: 20), 
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updateRecipeDetails(_recipe.recipeId);                        
                    },
                    child: const Text('Edit recipe'),
                  ),
                  const SizedBox(width: 20.0 ,),
                  ElevatedButton(
                    onPressed: deleteRecipe,
                    child: const Text('Delete recipe'),
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