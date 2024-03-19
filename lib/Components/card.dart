import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class FoodCard extends StatelessWidget {
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
            child: Image.asset(
              'assets/r1.png',
              width: 180.0,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(
                        Icons.dinner_dining,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Dessert',
                          style: TextStyle(color: Color(0xFF86BF3E)),
                        ),
                      ),
                      Icon(
                        Icons.access_time,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(width: 5),
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
                  SizedBox(height: 10),
                  Row(
                    children: [
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
                  Spacer(),
                  Align(
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
