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
    return BlocBuilder<PrefsBloc, PrefsState>(
      buildWhen: (previous, current) {
        // Only rebuild on actual state changes
        if (previous is PrefsColorChangedState && current is PrefsColorChangedState) {
          return previous.color != current.color || previous.themeMode != current.themeMode;
        }
        return true;
      },
      builder: (context, state) {
        // Default values
        ThemeMode themeMode = ThemeMode.system;
        Color seedColor = Colors.black;
        
        if (state is PrefsColorChangedState) {
          seedColor = state.color;
          themeMode = state.themeMode;
        }
        
        // Pre-generate the themes to avoid rebuilding them frequently
        final darkTheme = ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
          ),
          primaryColor: seedColor,
        );
        
        final lightTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
          useMaterial3: true,
          primaryColor: seedColor,
        );
        
        return MaterialApp(
          title: 'ZBK Portfolio',
          darkTheme: darkTheme,
          theme: lightTheme,
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
