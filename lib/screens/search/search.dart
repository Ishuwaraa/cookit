import 'package:cookit/components/appbar_title.dart';
import 'package:cookit/components/search_title.dart';
import 'package:cookit/components/styled_chip_button.dart';
import 'package:cookit/screens/search/filtered_results.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'breakfast', title: 'Breakfast',)));
                    },
                    child: const StyledChipButton(text: 'Breakfast'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'lunch', title: 'Lunch')));
                    },
                    child: const StyledChipButton(text: 'Lunch'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'brunch', title: 'Brunch')));
                    },
                    child: const StyledChipButton(text: 'Brunch'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'dinner', title: 'Dinner')));
                    },
                    child: const StyledChipButton(text: 'Dinner'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'dessert', title: 'Dessert')));
                    },
                    child: const StyledChipButton(text: 'Dessert'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'snack', title: 'Snack')));
                    },
                    child: const StyledChipButton(text: 'Snack'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'category', filter: 'soup', title: 'Soup')));
                    },
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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'serving', filter: '1', title: '1 Servings')));
                    },
                    child: const StyledChipButton(text: '1 Servings'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'serving', filter: '2', title: '2 Servings')));
                    },
                    child: const StyledChipButton(text: '2 Servings'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'serving', filter: '3', title: '3 Servings')));
                    },
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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'time', filter: '15min', title: 'Under 15min')));
                    },
                    child: const StyledChipButton(text: 'Under 15 mins'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'time', filter: '30min', title: 'Under 30min')));
                    },
                    child: const StyledChipButton(text: 'Under 30 mins'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'time', filter: '45min', title: 'Under 45min')));
                    },
                    child: const StyledChipButton(text: 'Under 45 mins'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilteredResult(type: 'time', filter: '60min', title: 'Under 60min')));
                    },
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
