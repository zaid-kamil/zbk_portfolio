import 'package:flutter/material.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/home_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/sidebar.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/tab_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final double _breakpoint = 1200; // Breakpoint for mobile/desktop switch

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= _breakpoint;

        return Scaffold(
          drawer: isDesktop
              ? null
              : Drawer(
                  width: 360,
                  backgroundColor: backgroundColor,
                  child: const Sidebar(),
                ),
          appBar: isDesktop
              ? null
              : AppBar(title: const Text("Zaid Kamil's Portfolio")),
          body: Row(
            children: [
              if (isDesktop) const Sidebar(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      TabRow(
                        onTabSelected: (index) =>
                            setState(() => selectedIndex = index),
                      ),
                      const Expanded(child: HomeContent()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
