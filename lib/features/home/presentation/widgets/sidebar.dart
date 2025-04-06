import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:url_launcher/url_launcher.dart';

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
          placeholder: (context) =>
              const Center(child: CircularProgressIndicator(
                color: Colors.white,
              )),
          image: const AssetImage('assets/gifs/me.gif'),
        ),
        const SizedBox(height: 20),
        Text(
          'Zaid Kamil',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        _buildSkillCategory(
            'Web & Mobile', _skillsData.webMobileSkills, Colors.deepPurpleAccent),
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
        _socialIcon(Icons.language,
            () => _launchURL('https://socialmistry.com'), Colors.blue),
        _socialIcon(
            Icons.phonelink_rounded,
            () => _launchURL('https://linkedin.com/in/zaidkamil/'),
            Colors.indigo),
        _socialIcon(
            Icons.code,
            () => _launchURL('https://github.com/zaidkamil'),
            Colors.black87),
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
                    _buildProfileSection(),
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
}

// Move to a separate file
class SkillsData {
  final List<String> programmingSkills = [
    'Python',
    'Java',
    'Kotlin',
    'Dart',
    'SQL'
  ];
  final List<String> dataSkills = [
    'TensorFlow',
    'PyTorch',
    'Scikit-learn',
    'OpenCV',
    'Pandas',
    'NumPy'
  ];
  final List<String> webMobileSkills = [
    'Flask',
    'Django',
    'Jetpack Compose',
    'Flutter',
    'Gradio',
    'Streamlit'
  ];
  final List<String> devOpsSkills = [
    'Docker',
    'Kubernetes',
    'Git',
    'CI/CD',
    'MLOps',
    'AWS',
    'Firebase'
  ];
  final List<String> otherSkills = [
    'HTML',
    'CSS',
    'JavaScript',
    'React',
    'Node.js',
    'FastAPI'
  ];
  final List<String> toolsSkills = [
    'GitHub',
    'Jupyter Notebook',
    'Google Colab',
    'VS Code',
    'PyCharm'
  ];
}
