import 'package:flutter/material.dart';

class ProjectDifficulty extends StatelessWidget {
  final int difficultyLevel;

  const ProjectDifficulty({super.key, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          difficultyLevel,
          (index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}