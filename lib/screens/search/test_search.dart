import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/search_title.dart';
import 'package:cookit/components/styled_chip_button.dart';
import 'package:cookit/screens/search/filtered_results.dart';
import 'package:flutter/material.dart';

class TestSearchPage extends StatefulWidget {
  const TestSearchPage({Key? key}) : super(key: key);

  @override
  State<TestSearchPage> createState() => _TestSearchPageState();
}

class _TestSearchPageState extends State<TestSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchTitle(title: 'Dish Type'),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 18.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'breakfast')));
                    },
                    child: const StyledChipButton(text: 'Breakfast'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'lunch')));
                    },
                    child: const StyledChipButton(text: 'Lunch'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Brunch'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Dinner'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Dessert'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Snack'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Soup'),
                  ),
                ],
              ),
            ),
            const SearchTitle(title: 'Servings Size'),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 18.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: '1 Servings'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: '2 Servings'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: '3 Servings'),
                  ),
                ],
              ),
            ),
            const SearchTitle(title: 'Cook Time'),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 12.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Under 15 mins'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Under 30 mins'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Under 45 mins'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const StyledChipButton(text: 'Under 60 mins'),
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
