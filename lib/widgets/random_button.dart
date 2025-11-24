import 'package:flutter/material.dart';

class RandomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RandomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: const Text(
        "Random meal of the day",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
