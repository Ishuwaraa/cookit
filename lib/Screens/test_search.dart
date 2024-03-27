import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 30),
              child: Text(
                'Dish type',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Breakfast',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Brunch',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Lunch',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Snack',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Dessert',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Dinner',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Soup',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 30),
              child: Text(
                'Cook time',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          '1 Servings',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          '2 Servings',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          '3 Servings',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 30),
              child: Text(
                ' Serving size',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Under 15 mins',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Under 30 mins',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Under 45 mins',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'Under 60 mins',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: const Color(0xFF86BF3E),
                      labelStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xFF86BF3E)),
                      ),
                    ),
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
