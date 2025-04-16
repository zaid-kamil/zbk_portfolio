import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/pages/home_screen.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZBK Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),
      // home: AnimatedSplashScreen(
      //   splash: ClipOval(
      //     child: Image.asset("assets/gifs/loading.gif"),
      //   ),
      //   nextScreen: const HomeScreen(),
      //   // Replace with your main page widget
      //
      //   splashTransition: SplashTransition.fadeTransition,
      //   pageTransitionType: PageTransitionType.fade,
      //   // Changed from scale
      //   backgroundColor: Colors.blue,
      //   splashIconSize: 150,
      //   centered: true,
      // ),
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
  }
}
