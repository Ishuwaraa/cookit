import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: SlidingUpPanel(
        minHeight: 400,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        panel: _buildPanel(),
        body: _buildBody(),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 320, // Specify the maximum width for wrapping
                  child: Text(
                    "Grilled Pork Steak ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true, // Allow text to wrap to a new line
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Color(0xFF86BF3E),
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildTag("25 mins"),
                _buildTag("2 servings"),
                _buildTag("Dessert"),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Column(
              children: [
                Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ingredients 1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ingredients 1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ingredients 1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ingredients 1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: Color(0xFF86BF3E),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ingredients 1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Fusce ut felis sed justo interdum rhoncus. Vestibulum ante ipsum "
              "primis in faucibus orci luctus et ultrices posuere cubilia Curae; "
              "Sed vitae purus eget tortor scelerisque rhoncus. Lorem ipsum dolor "
              "sit amet, consectetur adipiscing elit. Fusce ut felis sed justo interdum ",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Comments",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 400, // Set container width as needed
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 8.0), // Spacer between text field and button
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF86BF3E), // Circular background color
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add comment functionality goes here
                        print('Add Comment button pressed');
                      },
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white, // Set the arrow icon color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Discover All Comments',
                    style: TextStyle(
                      color: Color(0xFF86BF3E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/r1.png', // Replace 'assets/r1.png' with your local image path
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF86BF3E),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
