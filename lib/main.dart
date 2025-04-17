import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:zbk_portfolio/portfolio_app.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';

import 'features/home/presentation/project_bloc/project_details_bloc.dart';
import 'features/home/presentation/tab_bloc/tab_bloc.dart';

void main() {
  // Preserve the splash screen until initialization is complete
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Initialize your app
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<TabBloc>.value(
        value: TabBloc()..add(OnMobileTabClickedEvent()),
      ),
      BlocProvider<ProjectDetailsBloc>(
        create: (context) => ProjectDetailsBloc(),
      ),
      BlocProvider<PrefsBloc>(
        create: (context) => PrefsBloc(),
      )
    ], child: const PortfolioApp()),
  );
}
