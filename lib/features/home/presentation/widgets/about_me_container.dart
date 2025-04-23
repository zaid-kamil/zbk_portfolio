import 'package:flutter/material.dart';

class AboutMeContainer extends StatelessWidget {
  const AboutMeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900;
    final padding = isWideScreen
        ? const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40.0)
        : const EdgeInsets.all(24.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: CustomScrollView(
        slivers: [
          // Introduction Section
          SliverPadding(
            padding: padding.copyWith(top: 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "I'm Zaid bin Kamil — a dynamic and versatile technology professional with over a decade of experience at the intersection of AI, Data Science, Android Development, and Technical Education. Often described as a \"jack of all trades, and master of quite a few,\" I bring a unique blend of creativity, technical expertise, and a passion for teaching that sets me apart.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),

          // Core Expertise Header
          SliverPadding(
            padding: padding.copyWith(top: 0, bottom: 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Core Expertise',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Expertise Sections
          SliverPadding(
            padding: padding.copyWith(top: 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // AI & Data Science
                _buildExpertiseSection(
                  context,
                  '🧠 Artificial Intelligence & Data Science',
                  "I specialize in building and training machine learning models that solve real-world problems. From classification tasks to training LLMs, I translate complex data into actionable insights—and often into engaging tutorials and resources for others to learn from. I'm certified by IBM, proficient in Python, and known for simplifying difficult concepts through storytelling, analogies, and real-world applications.",
                ),

                // Android Development
                _buildExpertiseSection(
                  context,
                  '📱 Android Development',
                  "A Google-certified Android Developer, I've built everything from intuitive user interfaces to complex, Firebase-integrated apps using Kotlin and Jetpack Compose. My development philosophy is rooted in clean architecture, user-centric design, and rigorous testing. I've also contributed multiple open-source projects, showcasing innovative approaches to Android UI/UX, permissions, and app architecture.",
                ),

                // Technical Training
                _buildExpertiseSection(
                  context,
                  '🎓 Technical Training & Thought Leadership',
                  "Teaching is not just part of my job—it's my passion. I design and deliver high-impact training programs, workshops, and curriculum modules tailored to diverse learners. I'm recognized for my ability to demystify technical jargon, engage audiences with humor and clarity, and inspire the next generation of developers and data scientists.",
                ),

                const SizedBox(height: 12),
              ]),
            ),
          ),

          // Tech Stack Header
          SliverPadding(
            padding: padding.copyWith(top: 0, bottom: 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tech Stack at a Glance',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Tech Stack Section
          SliverPadding(
            padding: padding.copyWith(top: 0),
            sliver: SliverToBoxAdapter(
              child: _buildTechStackSection(context, isWideScreen),
            ),
          ),

          // Personal Info Section
          SliverPadding(
            padding: padding.copyWith(top: 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 12),
                Text(
                  'A Bit More About Me',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  "When I'm not immersed in code or conducting a training session, you'll find me exploring the latest in AI research, binge-reading Brandon Sanderson novels, or fine-tuning my personal LLMs for fun. I'm a strong believer in continuous learning, open collaboration, and the power of technology to solve meaningful problems.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),

          // Call to Action
          SliverPadding(
            padding: padding.copyWith(top: 0),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                ),
                child: Text(
                  "If you're looking to collaborate on innovative projects, develop impactful learning experiences, or simply connect over emerging tech, I'd love to hear from you.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ),
          ),

          // Bottom Padding
          SliverPadding(padding: EdgeInsets.only(bottom: 24))
        ],
      ),
    );
  }

  Widget _buildExpertiseSection(
      BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTechStackSection(BuildContext context, bool isWideScreen) {
    final techCategories = [
      {
        'category': 'Languages',
        'items': 'Python, Java, Kotlin, Dart, SQL, HTML/CSS'
      },
      {
        'category': 'Frameworks',
        'items': 'Django, Flask, Flutter, LangChain, Jetpack Compose'
      },
      {
        'category': 'Tools',
        'items':
            'Git, Docker, Firebase, VS Code, Android Studio, Open Source APIs'
      },
      {
        'category': 'Skills',
        'items':
            'Machine Learning, LLM Training, Data Engineering, Android Architecture, Cloud Integration, Prompt Engineering'
      },
    ];

    if (isWideScreen) {
      // Two-column layout for wide screens
      return Wrap(
        spacing: 24,
        runSpacing: 16,
        children: techCategories.map((category) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 92,
            child: _buildTechCategory(
                context, category['category']!, category['items']!),
          );
        }).toList(),
      );
    } else {
      // Single column layout for narrow screens
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: techCategories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildTechCategory(
                context, category['category']!, category['items']!),
          );
        }).toList(),
      );
    }
  }

  Widget _buildTechCategory(
      BuildContext context, String category, String items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          items,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
