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
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;
    final backgroundColor = theme.colorScheme.surface;

    return RepaintBoundary(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(_tabNames.length, (index) {
            final isSelected = _selectedIndex == index;
            final tabColor = isSelected ? primaryColor : Colors.grey.withAlpha(150);

            return Expanded(
              child: RepaintBoundary(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onTabSelected(index);

                    switch (index) {
                      case 0:
                        context.read<TabBloc>().add(OnMobileTabClickedEvent());
                        break;
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? primaryColor : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _tabIcons[index],
                          color: tabColor,
                          size: isSelected ? 24 : 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _tabNames[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: tabColor,
                            letterSpacing: isSelected ? 0.5 : 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}