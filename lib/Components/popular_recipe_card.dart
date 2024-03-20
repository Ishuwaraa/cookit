import 'package:flutter/material.dart';

class PopularRecipeCard extends StatelessWidget {
  const PopularRecipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/r1.png',
            ),
          ),
          const SizedBox(height: 10,), 
          const Text(
            'Title',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Icon(Icons.dinner_dining, color: Color(0xFF86BF3E),),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Dessert',
                    style: TextStyle(color: Color(0xFF86BF3E)),
                  ),
                ),
                const Icon(Icons.access_time,color: Color(0xFF86BF3E),),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '25 mins',
                    style: TextStyle(
                      color: Color(0xFF86BF3E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.room_service,
                  color: Color(0xFF86BF3E),
                ),
                SizedBox(width: 5),
                Text(
                  '2 servings',
                  style: TextStyle(
                    color: Color(0xFF86BF3E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
