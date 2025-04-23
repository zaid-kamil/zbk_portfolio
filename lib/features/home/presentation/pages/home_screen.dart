import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/home_content.dart';
import 'package:zbk_portfolio/features/home/presentation/widgets/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class TabItem {
  final String name;
  final IconData icon;

  const TabItem({required this.name, required this.icon});
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final double _breakpoint = 1200; // Breakpoint for mobile/desktop switch

  final List<TabItem> _tabItems = [
    TabItem(name: 'Mobile Apps', icon: Icons.smartphone),
    TabItem(name: 'Web Apps', icon: Icons.web),
    TabItem(name: 'Data Science & AI', icon: Icons.science),
    TabItem(name: 'Certificates', icon: Icons.workspace_premium),
    TabItem(name: 'Publications', icon: Icons.article),
    TabItem(name: 'About Me', icon: Icons.person)
  ];

  List<Widget> get actionList {
    return [
      changeThemeAction(),
      const SizedBox(width: 12),
      changeColorAction(),
    ];
  }

  Widget changeThemeAction() {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        if (state is PrefsColorChangedState) {
          final isDarkMode = state.themeMode == ThemeMode.dark ||
              state.themeMode == ThemeMode.system &&
                  MediaQuery.platformBrightnessOf(context) == Brightness.dark;
          debugPrint('Current theme mode is Dark: $isDarkMode');
          return IconButton(
            tooltip: '${isDarkMode ? "Light" : "Dark"} mode',
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            onPressed: () {
              context.read<PrefsBloc>().add(OnThemeToggleEvent());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget changeColorAction() {
    var colors = [
      ["Black", FlexScheme.blackWhite, Colors.black],
      ["Green", FlexScheme.green, Colors.green],
      ["Red", FlexScheme.shadRed, Colors.red],
      ["Blue", FlexScheme.bahamaBlue, Colors.blue],
      ["Purple", FlexScheme.deepPurple, Colors.purple],
      ["Pink", FlexScheme.pinkM3, Colors.pink],
      ["Amber", FlexScheme.amber, Colors.amber],
      ["Teal", FlexScheme.tealM3, Colors.teal],
      ["Yellow", FlexScheme.shadYellow, Colors.yellow],
      ["Indigo", FlexScheme.indigo, Colors.indigo],
    ];

    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        FlexScheme color = FlexScheme.blackWhite;
        if (state is PrefsColorChangedState) {
          color = state.color;
        }

        return IconButton(
          icon: Icon(
            Icons.color_lens,
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          tooltip: "Change theme color",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Choose a theme color'),
                content: SizedBox(
                  width: 300,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: colors.map((colorItem) {
                      final String colorName = colorItem[0] as String;
                      final FlexScheme colorScheme = colorItem[1] as FlexScheme;
                      final Color colorValue = colorItem[2] as Color;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Future.microtask(() {
                            if (mounted) {
                              context
                                  .read<PrefsBloc>()
                                  .add(OnColorChangedEvent(colorScheme));
                            }
                          });
                        },
                        child: Tooltip(
                          message: colorName,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorValue,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: colorScheme == color
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // white or black based on theme
    var backgroundColor = Colors.white;
    if (Theme.of(context).colorScheme.brightness != Brightness.light) {
      backgroundColor = Colors.black;
    } else {
      backgroundColor = Colors.white;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= _breakpoint;
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            backgroundColor: backgroundColor,
            drawer: isDesktop
                ? null
                : Drawer(
                    backgroundColor: backgroundColor,
                    width: 360,
                    child: Sidebar(),
                  ),
            appBar: AppBar(
              backgroundColor: backgroundColor,
              title: const Text('Journey before Destination'),
              actions: actionList,
              bottom: TabBar(
                automaticIndicatorColorAdjustment: true,
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: _tabItems.map((tab) {
                  return Tab(
                    text: tab.name,
                    icon: Icon(tab.icon),
                  );
                }).toList(),
              ),
            ),
            body: Row(
              children: [
                if (isDesktop) Sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: HomeContent(),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
