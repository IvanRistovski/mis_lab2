import 'package:flutter/material.dart';

class RecipeYoutube extends StatelessWidget {
  final String youtubeUrl;

  const RecipeYoutube({super.key, required this.youtubeUrl});

  @override
  Widget build(BuildContext context) {
    if (youtubeUrl.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "YouTube",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          youtubeUrl,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.deepPurple,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
