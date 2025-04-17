import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/tab_bloc/tab_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/content_display_area.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  ProjectCategory _getCategoryFromState(TabState state) {
    return switch (state) {
      TabWebApp() => ProjectCategory.webApp,
      TabDataScience() => ProjectCategory.dataScience,
      TabCertificates() => ProjectCategory.certificates,
      TabPublications() => ProjectCategory.publications,
      TabAboutMe() => ProjectCategory.aboutMe,
      _ => ProjectCategory.mobileApp,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1500),
          child: ContentDisplayArea(
            key: ValueKey(state.runtimeType),
            category: _getCategoryFromState(state),
          ),
        );
      },
    );
  }
}