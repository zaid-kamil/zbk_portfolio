import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zbk_portfolio/features/home/presentation/pages/home_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZBK Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: ClipOval(
          child: Image.asset("assets/gifs/loading.gif"),
        ),
        nextScreen: const HomeScreen(),
        // Replace with your main page widget
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        // Changed from scale
        backgroundColor: Colors.blue,
        splashIconSize: 150,
        centered: true,
      ),
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
