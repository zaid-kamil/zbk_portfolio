import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:zbk_portfolio/features/home/presentation/pages/home_screen.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  @override
  void initState() {
    super.initState();
    // Remove splash screen when initialization is completed
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    FlexScheme scheme = FlexScheme.blackWhite;
    ThemeMode themeMode = ThemeMode.light;

    return BlocBuilder<PrefsBloc, PrefsState>(
      buildWhen: (previous, current) {
        // Only rebuild on actual state changes
        if (previous is PrefsColorChangedState &&
            current is PrefsColorChangedState) {
          return previous.color != current.color ||
              previous.themeMode != current.themeMode;
        }
        return true;
      },
      builder: (context, state) {
        if (state is PrefsColorChangedState) {
          scheme = state.color;
          themeMode = state.themeMode;
        }

        return MaterialApp(
          title: 'ZBK Portfolio',
          theme: FlexThemeData.light(scheme: scheme),
          darkTheme: FlexThemeData.dark(scheme: scheme, darkIsTrueBlack: true),
          themeMode: themeMode,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
          scrollBehavior: const ScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
            },
          ),
        );
      },
    );
  }
}
