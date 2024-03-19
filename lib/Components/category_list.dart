import 'package:flutter/material.dart';

class SizedBoxListView extends StatelessWidget {
  const SizedBoxListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryItem("🔥 Popular"),
          _buildCategoryItem("🥦 Healthy"),
          _buildCategoryItem("🍲 Soup"),
          _buildCategoryItem("🍿 Snacks"),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
