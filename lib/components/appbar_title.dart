import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {

  final String title;
  const AppbarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
          style: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}