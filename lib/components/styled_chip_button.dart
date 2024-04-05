import 'package:flutter/material.dart';

class StyledChipButton extends StatelessWidget {
  final String text;
  const StyledChipButton({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: const Color(0xFF86BF3E),
      labelStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Color(0xFF86BF3E)),
      ),
    );
  }
}