import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/image_upload.dart';
import 'package:cookit/models/recipe_model.dart';
import 'package:cookit/models/user_model.dart';
import 'package:cookit/services/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _TestAddRecipeState();
}

class _TestAddRecipeState extends State<AddRecipe> {
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _descriptionController = TextEditingController();

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

  @override
  void dispose() {
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void addRecipe(String userId) async {
    if (_recipeNameController.text.isNotEmpty && _ingredientsController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      print('${_recipeNameController.text.trim()}, ${_ingredientsController.text.trim()}, $selectedTime, $selectedServing, $selectedCategory, ${_descriptionController.text.trim()}');

      if (imageUrl.isNotEmpty) {
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
        ));
        if (isSuccess) {
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sorry we had trouble uploading your recipe. Try again later.'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF86BF3E),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Add an image to upload your recipe.'),
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Add Recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.transparent,
                  backgroundImage: imageUrl.isEmpty ? const AssetImage('assets/foodplate.png') as ImageProvider<Object>? : NetworkImage(imageUrl),
                ),
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
                  hintText: 'Chili Crisp Chicken Salad', // Text displayed inside the border when the TextField is empty
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                    hintText: 'Salt,Cucumber,Shredded chicken',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                  underline: const SizedBox(), // Hides the default underline
                  onChanged: (time) => setState(() => selectedTime = time!),
                  items: times.map((time) => DropdownMenuItem(
                        value: time,
                        child: Center(
                          child: Text(
                            'under $time',
                            textAlign: TextAlign.center, // Center the text
                          ),
                        ),
                      ))
                  .toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                  items: servings.map((serving) => DropdownMenuItem(
                        value: serving,
                        child: Center(
                          child: Text(
                            'serving $serving',
                            textAlign: TextAlign.center, // Center the text
                          ),
                        ),
                      ))
                  .toList(),
                  onChanged: (serving) => setState(() => selectedServing = serving!),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: 380, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey[200], 
                ),
                child: DropdownButton<String>(
                  isExpanded:
                      true, // Expands the dropdown button to fill its container width
                  value: selectedCategory,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF86BF3E),
                    size: 30,
                  ),
                  underline: const SizedBox(), // Hides the default underline
                  onChanged: (category) => setState(() => selectedCategory = category!),
                  items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Center(
                            child: Text(
                              category,
                              textAlign: TextAlign.center, // Center the text
                            ),
                          ),
                        ))
                    .toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  addRecipe(user.userId);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color(0xFF86BF3E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Add recipe',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
