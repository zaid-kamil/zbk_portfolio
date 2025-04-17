import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/project_bloc/project_details_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/tab_bloc/tab_bloc.dart';
import 'package:zbk_portfolio/portfolio_app.dart';

void main() {
  // initialize bindings
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<TabBloc>.value(
        value: TabBloc()..add(OnMobileTabClickedEvent()),
      ),
      BlocProvider<ProjectDetailsBloc>(
        create: (context) => ProjectDetailsBloc(),
      ),
      BlocProvider<PrefsBloc>(
        create: (context) => PrefsBloc()..add(OnColorChangedEvent(Colors.black54)),
      )
    ], child: const PortfolioApp()),
  );
}
