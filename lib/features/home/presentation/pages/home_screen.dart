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
                      // Removed duplicate event dispatching
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TabBloc, TabState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case const (TabMobileApp):
                          return const AndroidFlutterContent();
                        case const (TabWebApp):
                          return const WebAppContent();
                        case const (TabDataScience):
                          return const DataScienceAiContent();
                        case const (TabCertificates):
                          return const CertificatesContent();
                        case const (TabPublications):
                          return const PublicationsContent();
                        case const (TabAboutMe):
                          return const AboutMeContent();
                        default:
                          return const AndroidFlutterContent();
                      }
                    },
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