import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zbk_portfolio/features/home/data/skills_data.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});

  // Move skills lists to a separate class or file for better organization
  final SkillsData _skillsData = SkillsData();

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ClipOval(
          child: Image.asset(
            'assets/images/profile.png',
            width: 100,
            height: 100,
          ),
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
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Text(text),
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
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Skills'),
        _buildSkillCategory(
            context, 'Programming', _skillsData.programmingSkills),
        _buildSkillCategory(
            context, 'Data Science & ML', _skillsData.dataSkills),
        _buildSkillCategory(
            context, 'Web & Mobile', _skillsData.webMobileSkills),
        _buildSkillCategory(
            context, 'DevOps & Cloud', _skillsData.devOpsSkills),
        _buildSkillCategory(context, 'Other Skills', _skillsData.otherSkills),
        _buildSkillCategory(context, 'Tools & IDEs', _skillsData.toolsSkills),
      ],
    );
  }

  Widget _buildSkillCategory(
      BuildContext context, String title, List<String> skills) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 4),
          _buildSkillsChips(context, skills),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // our website
        _socialIcon(FontAwesomeIcons.globe,
            () => _launchURL('https://socialmistry.com')),
        _socialIcon(FontAwesomeIcons.linkedin,
            () => _launchURL('https://linkedin.com/in/zaidbinkamil/')),
        _socialIcon(FontAwesomeIcons.github,
            () => _launchURL('https://github.com/zaid-kamil')),
      ],
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 20,
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }

  Widget _buildSkillsChips(BuildContext context,
    List<String> skills,
  ) {
    var theme = Theme.of(context);
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: skills
          .map((skill) => Chip(
                backgroundColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text(skill),
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
                    _buildProfileSection(context),
                    const SizedBox(height: 20),
                    _buildContactInfo(),
                    const SizedBox(height: 16),
                    _buildSkillsSection(context),
                    const SizedBox(height: 20),
                    _buildSocialLinks(),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Build with Flutter & 💖',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Move to a separate file
