import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> _isSelectedList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

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
              padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 30),
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
                  _buildChip('Breakfast', 0),
                  _buildChip('Brunch', 1),
                  _buildChip('Lunch', 2),
                  _buildChip('Snack', 3),
                  _buildChip('Dessert', 4),
                  _buildChip('Dinner', 5),
                  _buildChip('Soup', 6),
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
                  _buildChip('1 Servings', 10),
                  _buildChip('2 Servings', 11),
                  _buildChip('3 Servings', 12),
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
                  _buildChip('Under 15 mins', 7),
                  _buildChip('Under 30 mins', 8),
                  _buildChip('Under 60 mins', 9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, int index) {
    return Focus(
      autofocus: false, // Prevent the chip from receiving focus
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SecondPage(label), // Pass label to the second page
            ),
          );
        },
        child: Chip(
          label: Padding(
            padding: const EdgeInsets.all(3.0), // Increase padding
            child: Text(
              label,
              style: TextStyle(fontSize: 18), // Increase font size
            ),
          ),
          backgroundColor: _isSelectedList[index]
              ? const Color(0xFF86BF3E)
              : const Color(0xFF86BF3E),
          labelStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Increase border radius
            side:
                BorderSide(color: const Color(0xFF86BF3E)), // Set border color
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String dishType;

  SecondPage(this.dishType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dishType),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'You selected $dishType',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
