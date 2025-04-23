import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/content_display_area.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: BouncingScrollPhysics(),
      children: [
        ContentDisplayArea(category: ProjectCategory.mobileApp),
        ContentDisplayArea(category: ProjectCategory.webApp),
        ContentDisplayArea(category: ProjectCategory.dataScience),
        ContentDisplayArea(category: ProjectCategory.certificates),
        ContentDisplayArea(category: ProjectCategory.publications),
        ContentDisplayArea(category: ProjectCategory.aboutMe),
      ],
    );
  }
}
