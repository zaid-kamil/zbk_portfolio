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
    final primaryColor = theme.primaryColorDark;
    final backgroundColor = theme.colorScheme.onPrimary;

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Container(
          alignment: Alignment.centerLeft,
          height: 64,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
              top: BorderSide(
                color: primaryColor.withAlpha(150),
                width: 1.0,
              ),
              left: BorderSide(
                color: primaryColor.withAlpha(150),
                width: 1.0,
              ),
              right: BorderSide(
                color: primaryColor.withAlpha(150),
                width: 1.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_tabNames.length, (index) {
                final isSelected = _selectedIndex == index;
                final tabColor =
                    isSelected ? primaryColor : Colors.grey.withAlpha(150);
                return SizedBox(
                  width: 120,
                  child: RepaintBoundary(
                    child: InkWell(
                      onTap: () {
                        setState(() => _selectedIndex = index);
                        widget.onTabSelected(index);
                        _handleTabClick(context, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  isSelected ? primaryColor : Colors.transparent,
                              width: 1.0,
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
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
        ),
      ),
    );
  }

  void _handleTabClick(BuildContext context, int index) {
    final event = switch (index) {
      0 => OnMobileTabClickedEvent(),
      1 => OnWebTabClickedEvent(),
      2 => OnDataScienceTabClickedEvent(),
      3 => OnCertificatesTabClickedEvent(),
      4 => OnPublicationsTabClickedEvent(),
      5 => OnAboutMeTabClickedEvent(),
      _ => OnMobileTabClickedEvent(),
    };
    context.read<TabBloc>().add(event);
  }
}
