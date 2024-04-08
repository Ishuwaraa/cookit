import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/image_upload.dart';
import 'package:cookit/components/loading.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/services/database.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRecipe extends StatefulWidget {
  final String recipeId;
  // final VoidCallback refreshData;

  const EditRecipe({required this.recipeId, super.key});

  @override
  State<EditRecipe> createState() => _TestEditRecipeState();
}

class _TestEditRecipeState extends State<EditRecipe> {
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

  void getRecipeDetails(String recipeId) async {
    try {
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
    } catch (e) {
      print(e.toString());
    }
  }

  void updateRecipeDetails(String recipeId) async {
    if (_recipeNameController.text.isNotEmpty &&
        _ingredientsController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
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
          photoUrl: imageUrl.isEmpty ? _recipe.photoUrl : imageUrl,
      ));

      if (isSuccess) {
        // Navigator.pop(context);
        // widget.refreshData();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Recipe updated'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sorry we could not update your recipe'),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF86BF3E),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all the fields.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    }
  }

  void deleteRecipe() async {
    print(_recipe.recipeId);
    bool isSuccess = await Provider.of<RecipeStore>(context, listen: false)
        .deleteRecipe(_recipe.recipeId);

    if (isSuccess) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Recipe successfully deleted.'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF86BF3E),
      ));
    } else {
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
    return loading? const Loading(): Scaffold(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _recipeNameController,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Recipe Title',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _ingredientsController,
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Ingredients',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey[200],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedTime,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF86BF3E),
                    size: 30,
                  ),
                  underline:const SizedBox(), // Hides the default underline
                  onChanged: (time) => setState(() => selectedTime = time!),
                  items: times.map(
                    (time) => DropdownMenuItem(
                        value: time,
                        child: Center(
                          child: Text(
                            'under $time',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                    .toList(),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey[200],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedServing,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF86BF3E),
                    size: 30,
                  ),
                  underline: const SizedBox(), // Hides the default underline
                  items: servings.map(
                    (serving) => DropdownMenuItem(
                      value: serving,
                      child: Center(
                        child: Text(
                          'serving $serving',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
                    .toList(),
                  onChanged: (serving) => setState(() => selectedServing = serving!),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey[200],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCategory,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF86BF3E),
                    size: 30,
                  ),
                  underline: const SizedBox(),
                  onChanged: (category) => setState(() => selectedCategory = category!),
                  items: categories.map((category) => DropdownMenuItem(
                      value: category,
                      child: Center(
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
                .toList(),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _descriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Descrption',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updateRecipeDetails(_recipe.recipeId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF86BF3E), // Set the button's background color to specific green
                    ),
                    child: const Text(
                      'Edit recipe',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                  ),
                  const SizedBox(width: 20.0,),
                  ElevatedButton(
                    onPressed: deleteRecipe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF86BF3E), // Set the button's background color to specific green
                    ),
                    child: const Text('Delete recipe',
                      style: TextStyle(color: Colors.white), // Set text color to white
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
