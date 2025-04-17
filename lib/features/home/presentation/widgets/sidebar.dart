import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gif/gif.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zbk_portfolio/features/home/data/skills_data.dart';
import 'package:zbk_portfolio/features/home/presentation/prefs_bloc/prefs_bloc.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with TickerProviderStateMixin {
  late final GifController controller;

  // Move skills lists to a separate class or file for better organization
  final SkillsData _skillsData = SkillsData();

  @override
  void initState() {
    controller = GifController(vsync: this);
    super.initState();
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Gif(
          autostart: Autostart.loop,
          width: 260,
          height: 260,
          fps: 60,
          placeholder: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
          image: const AssetImage('assets/gifs/me.gif'),
        ),
        const SizedBox(height: 20),
        Text('Zaid Kamil', style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Contact Details'),
        const SizedBox(height: 8),
        _buildContactRow(Icons.phone, '+91-7860380291'),
        _buildContactRow(Icons.email, 'xaidmetamorphos@outlook.com'),
        _buildContactRow(Icons.language, 'socialmistry.com',
            onTap: () => _launchURL('https://socialmistry.com')),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text, {VoidCallback? onTap}) {
    final row = Row(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
    return onTap != null
        ? GestureDetector(onTap: onTap, child: row)
        : Padding(padding: const EdgeInsets.only(bottom: 4), child: row);
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Skills'),
        _buildSkillCategory(
            'Programming', _skillsData.programmingSkills, Colors.blue),
        _buildSkillCategory(
            'Data Science & ML', _skillsData.dataSkills, Colors.green),
        _buildSkillCategory('Web & Mobile', _skillsData.webMobileSkills,
            Colors.deepPurpleAccent),
        _buildSkillCategory(
            'DevOps & Cloud', _skillsData.devOpsSkills, Colors.purple),
        _buildSkillCategory(
            'Other Skills', _skillsData.otherSkills, Colors.red),
        _buildSkillCategory(
            'Tools & IDEs', _skillsData.toolsSkills, Colors.teal),
      ],
    );
  }

  Widget _buildSkillCategory(String title, List<String> skills, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70)),
          const SizedBox(height: 4),
          _buildSkillsChips(skills, color),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // our website
        _socialIcon(FontAwesomeIcons.bookOpenReader,
            () => _launchURL('https://socialmistry.com'), Colors.blue),
        _socialIcon(
            FontAwesomeIcons.linkedin,
            () => _launchURL('https://linkedin.com/in/zaidbinkamil/'),
            Colors.indigo),
        _socialIcon(FontAwesomeIcons.github,
            () => _launchURL('https://github.com/zaid-kamil'), Colors.black87),
      ],
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onTap, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildSkillsChips(List<String> skills, Color color) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: skills
          .map((skill) => Chip(
                backgroundColor: color.withAlpha(255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text(skill,
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
                padding: const EdgeInsets.all(4),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _buildProfileSection(),
                    const SizedBox(height: 30),
                    _buildPrefsActions(),
                    const SizedBox(height: 30),
                    _buildContactInfo(),
                    const SizedBox(height: 16),
                    _buildSkillsSection(),
                    const SizedBox(height: 20),
                    _buildSocialLinks(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrefsActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Change theme',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: actionList,
        ),
      ],
    );
  }

  List<Widget> get actionList {
    return [
      changeThemeAction(),
      const SizedBox(width: 12),
      changeColorAction(),
    ];
  }

  Widget changeThemeAction() {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        if (state is PrefsColorChangedState) {
          final isDarkMode = state.themeMode == ThemeMode.dark;
          return IconButton(
            tooltip: '${isDarkMode ? "Light" : "Dark"} mode',
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<PrefsBloc>().add(OnThemeToggleEvent());
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget changeColorAction() {
    var colors = [
      ["Black", Colors.black],
      ["Red", Colors.red],
      ["Green", Colors.green],
      ["Blue", Colors.blue],
      ["Purple", Colors.purple],
      ["Orange", Colors.orange],
      ["Pink", Colors.pink],
      ["Teal", Colors.teal],
    ];

    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        Color color = Colors.red;
        if (state is PrefsColorChangedState) {
          color = state.color;
        }

        return PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          position: PopupMenuPosition.under,
          tooltip: "Change theme color",
          offset: const Offset(0, 8),
          child: Icon(
            Icons.color_lens,
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          itemBuilder: (context) => colors.map((color) {
            return PopupMenuItem(
              value: color,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color[1] as Color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(color[0] as String),
                ],
              ),
            );
          }).toList(),
          onSelected: (value) {
            // Use a small delay before updating the color
            Future.microtask(() {
              final selectedColor = value[1] as Color;
              context.read<PrefsBloc>().add(OnColorChangedEvent(selectedColor));
            });
          },
        );
      },
    );
  }
}

// Move to a separate file

