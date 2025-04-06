import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/tab_bloc/tab_bloc.dart';
import 'package:zbk_portfolio/portfolio_app.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<TabBloc>.value(
        value: TabBloc()..add(OnMobileTabClickedEvent()),
      ),
    ], child: const PortfolioApp()),
  );
}


