import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/tab_bloc/tab_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/about_me_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/android_flutter_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/certificates_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/data_science_ai_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/publications_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/sidebar.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/tab_row.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/web_content.dart';

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
                          case TabMobileApp:
                            content = const AndroidFlutterContent();
                            break;
                          case TabWebApp:
                            content = const WebAppContent();
                            break;
                          case const (TabDataScience):
                            content = const DataScienceAiContent();
                            break;
                          case TabCertificates:
                            content = const CertificatesContent();
                            break;
                          case TabPublications:
                            content = const PublicationsContent();
                            break;
                          case TabAboutMe:
                            content = const AboutMeContent();
                            break;
                          default:
                            content = const AndroidFlutterContent();
                        }
                        return RepaintBoundary(
                          child: PageTransitionSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (
                                Widget child,
                                Animation<double> primaryAnimation,
                                Animation<double> secondaryAnimation,
                                ) {
                              return SharedAxisTransition(
                                animation: primaryAnimation,
                                secondaryAnimation: secondaryAnimation,
                                transitionType: SharedAxisTransitionType.horizontal,
                                child: child,
                              );
                            },
                            child: content,
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
