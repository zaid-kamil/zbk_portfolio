import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbk_portfolio/features/home/presentation/tab_bloc/tab_bloc.dart';

class TabRow extends StatefulWidget {
  final Function(int) onTabSelected;

  const TabRow({
    super.key,
    required this.onTabSelected,
  });

  @override
  State<TabRow> createState() => _TabRowState();
}

class _TabRowState extends State<TabRow> {
  int _selectedIndex = 0;

  final List<String> _tabNames = [
    'Mobile Apps',
    'Web Apps',
    'Data Science & AI',
    'Certificates',
    'Publications',
    'About Me'
  ];

  final List<IconData> _tabIcons = [
    Icons.smartphone,
    Icons.web,
    Icons.science,
    Icons.workspace_premium,
    Icons.article,
    Icons.person
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabNames.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTabSelected(index);

                // Only dispatch the events here, not in HomeScreen
                switch (index) {
                  case 0:
                    context.read<TabBloc>().add(OnMobileTabClickedEvent());
                    break; // Added break statements
                  case 1:
                    context.read<TabBloc>().add(OnWebTabClickedEvent());
                    break;
                  case 2:
                    context.read<TabBloc>().add(OnDataScienceTabClickedEvent());
                    break;
                  case 3:
                    context.read<TabBloc>().add(OnCertificatesTabClickedEvent());
                    break;
                  case 4:
                    context.read<TabBloc>().add(OnPublicationsTabClickedEvent());
                    break;
                  case 5:
                    context.read<TabBloc>().add(OnAboutMeTabClickedEvent());
                    break;
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _tabIcons[index],
                    color: _selectedIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _tabNames[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: _selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}