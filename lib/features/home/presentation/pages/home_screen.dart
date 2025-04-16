import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/home_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/sidebar.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/tab_row.dart';
import 'package:zbk_portfolio/features/home/utils/preference_manager.dart';

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
              ? AppBar(
                  title: const Text("Zaid Kamil's Portfolio"),
                  clipBehavior: Clip.antiAlias,
                  actions: [
                    changeThemeAction(),
                    const SizedBox(width: 16),
                    changeColorAction(),
                    const SizedBox(width: 16),
                    changeFontAction(),
                  ],
                )
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

  changeFontAction() {
    List<int> fontSizes = [12, 14, 16, 18, 20];
    return PopupMenuButton(
      icon: const Icon(Icons.font_download),
      itemBuilder: (context) => fontSizes.map((size) {
        return PopupMenuItem(
          value: size,
          child: Text(
            '$size px',
            style: TextStyle(fontSize: size.toDouble()),
          ),
        );
      }).toList(),
      onSelected: (value) {
        context.read<PrefsBloc>().add(OnFontSizeChangedEvent(value as double));
      },
    );
  }

  changeThemeAction() {
    // switch between light and dark theme
    return Switch(
        value: PreferenceManager().getTheme() != ThemeMode.dark,
        onChanged: (value) {
          context.read<PrefsBloc>().add(OnThemeChangedEvent(value));
        });
  }

  changeColorAction() {
    var colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];
    return PopupMenuButton(
      icon: const Icon(Icons.color_lens),
      itemBuilder: (context) => colors.map((color) {
        return PopupMenuItem(
          value: color,
          child: Container(
            width: 24,
            height: 24,
            color: color,
          ),
        );
      }).toList(),
      onSelected: (value) {
        context.read<PrefsBloc>().add(OnColorChangedEvent(value as Color));
      },
    );
  }
}
