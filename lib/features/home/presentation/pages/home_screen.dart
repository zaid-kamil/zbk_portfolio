import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/domain/project.dart';
import 'package:zbk_portfolio/features/home/presentation/tab_bloc/tab_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/content_display_area.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/sidebar.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/tab_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  TabRow(
                    onTabSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<TabBloc, TabState>(
                      builder: (context, state) {
                        Widget content;
                        switch (state.runtimeType) {
                          case const (TabWebApp):
                            debugPrint('Web App Tab Selected');
                            content = const ContentDisplayArea(
                              category: ProjectCategory.webApp,
                            );
                            break;
                          case const (TabDataScience):
                            debugPrint('Data Science Tab Selected');
                            content = const ContentDisplayArea(
                              category: ProjectCategory.dataScience,
                            );
                            break;
                          case const (TabCertificates):
                            debugPrint('Certificates Tab Selected');
                            content = const ContentDisplayArea(
                              category: ProjectCategory.certificates,
                            );
                            break;
                          case const (TabPublications):
                            debugPrint('Publications Tab Selected');
                            content = const ContentDisplayArea(
                              category: ProjectCategory.publications,
                            );
                            break;
                          case const (TabAboutMe):
                            debugPrint('About Me Tab Selected');
                            content = const ContentDisplayArea(
                              category: ProjectCategory.aboutMe,
                            );
                            break;
                          default:
                            debugPrint('Mobile App Tab Selected');
                            content = const ContentDisplayArea(
                              category: ProjectCategory.mobileApp,
                            );
                            break;
                        }
                        return RepaintBoundary(
                          child: PageTransitionSwitcher(
                            duration: const Duration(milliseconds: 500),
                            reverse: state is TabWebApp || state is TabDataScience, // Reverse animation based on tab order
                            transitionBuilder: (
                                Widget child,
                                Animation<double> primaryAnimation,
                                Animation<double> secondaryAnimation,
                                ) {
                              return FadeScaleTransition(
                                animation: primaryAnimation,
                                child: SharedAxisTransition(
                                  animation: primaryAnimation,
                                  secondaryAnimation: secondaryAnimation,
                                  transitionType: SharedAxisTransitionType.horizontal,
                                  fillColor: Colors.white,
                                  child: child,
                                ),
                              );
                            },
                            child: KeyedSubtree(
                              key: ValueKey(state.runtimeType), // Important: Add key for proper transitions
                              child: content,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
