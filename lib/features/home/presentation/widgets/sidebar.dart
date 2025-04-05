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

  // List of skills in categories
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
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Gif(
                    autostart: Autostart.loop,
                    width: 260,
                    height: 260,
                    fps: 60,
                    placeholder: (context) =>
                        const Center(child: CircularProgressIndicator()),
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
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.phone, color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Text('+91-7860380291',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.email,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 16),
                            SizedBox(width: 8),
                            Text('xaidmetamorphos@outlook.com',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => _launchURL('https://socialmistry.com'),
                          child: Row(
                            children: [
                              Icon(Icons.language,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  size: 16),
                              SizedBox(width: 8),
                              Text(
                                'socialmistry.com',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Skills',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 8),
                        const Text('Programming',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        const SizedBox(height: 4),
                        _buildSkillsChips(programmingSkills, Colors.blue),
                        const SizedBox(height: 8),
                        const Text('Data Science & ML',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        const SizedBox(height: 4),
                        _buildSkillsChips(dataSkills, Colors.green),
                        const SizedBox(height: 8),
                        const Text('Web & Mobile',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        const SizedBox(height: 4),
                        _buildSkillsChips(webMobileSkills, Colors.orange),
                        const SizedBox(height: 8),
                        const Text('DevOps & Cloud',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        const SizedBox(height: 4),
                        _buildSkillsChips(devOpsSkills, Colors.purple),
                        const SizedBox(height: 8),
                        const Text('Other Skills',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        const SizedBox(height: 4),
                        _buildSkillsChips(otherSkills, Colors.red),
                        const SizedBox(height: 8),
                        const Text('Tools & IDEs',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        const SizedBox(height: 4),
                        _buildSkillsChips(toolsSkills, Colors.teal),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(
                          Icons.language,
                          () => _launchURL('https://socialmistry.com'),
                          Colors.blue),
                      _socialIcon(
                          Icons.link,
                          () => _launchURL(
                              'https://www.linkedin.com/in/yourLinkedInID'),
                          Colors.indigo),
                      _socialIcon(
                          Icons.code,
                          () => _launchURL('https://github.com/yourGitHubID'),
                          Colors.black87),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
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
}
