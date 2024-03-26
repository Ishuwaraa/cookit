import 'package:cookit/models/recipe_model.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class FoodCard extends StatelessWidget {
  const FoodCard(this.recipe, {super.key});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      height: 200.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            // child: Image.asset(
            //   'assets/r1.png',
            //   width: 180.0,
            // ),
            child: CircleAvatar(
              radius: 90.0,
              child: ClipOval(
                child: Image.network(
                  recipe.photoUrl,
                  width: 180.0,
                  height: 180.0,
                  fit: BoxFit
                      .cover, // You might want to adjust the fit based on your requirement
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.recipe,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.dinner_dining,
                        color: Color(0xFF86BF3E),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          recipe.category,
                          style: const TextStyle(color: Color(0xFF86BF3E)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color(0xFF86BF3E),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          recipe.time,
                          style: const TextStyle(
                            color: Color(0xFF86BF3E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.room_service,
                        color: Color(0xFF86BF3E),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Serves ${recipe.servings}',
                        style: const TextStyle(
                          color: Color(0xFF86BF3E),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.favorite_border,
                      size: 24,
                      color: Color(0xFF86BF3E),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
