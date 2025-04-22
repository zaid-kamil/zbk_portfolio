import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicationContainer extends StatelessWidget {
  const PublicationContainer({super.key});

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [
        _buildBookCard(
          context,
          'My First Mobile App for Students',
          'assets/images/book1.png',
          'My First Mobile App for Students is an entry-level guide tailored for absolute beginners eager to step into the world of mobile app development. Designed with students and self-learners in mind, this book walks readers through the complete app development lifecycle—from conceptualizing ideas to building functional Android applications using intuitive tools and modern programming practices.',
          'https://www.amazon.in/First-Mobile-App-Students-comprehensive-ebook/dp/B0CJ6PKM1J',
        ),
        _buildBookCard(
          context,
          'Flutter Solutions for Web Developers',
          'assets/images/book2.jpg',
          'Flutter Solutions for Web Developers bridges the gap between traditional web development and the evolving world of cross-platform mobile apps using Flutter. Geared toward web developers looking to expand their skills, this book offers practical, solution-driven guidance to transition from HTML, CSS, and JavaScript to Dart and Flutter\'s declarative UI framework.',
          'https://www.amazon.in/Flutter-Solutions-Web-Development-development/dp/9365898242',
        ),
        _buildComingSoon(context),
      ],
    );
  }

  Widget _buildBookCard(BuildContext context, String title, String imagePath,
      String description, String amazonUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height:
          MediaQuery.of(context).size.height * 0.8, // Fixed container height
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ),
                      Center(
                        child: Hero(
                          tag: title,
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'BPB Publications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.8),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            height: 1.5,
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _buildAnimatedButton(
                      'View on Amazon',
                      () => _launchURL(amazonUrl),
                      Icons.shopping_cart,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoon(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories,
              size: 64,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'More Publications\nComing Soon!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            _buildAnimatedButton(
              'View Author Profile',
              () => _launchURL(
                  'https://www.amazon.in/stores/author/B0CJNWCTZN/allbooks'),
              Icons.person,
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(
      String text, VoidCallback onPressed, IconData icon,
      {bool isPrimary = true}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1, end: 1),
        duration: const Duration(milliseconds: 200),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: isPrimary
                ? FilledButton.icon(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    icon: Icon(icon),
                    label: Text(text),
                  )
                : TextButton.icon(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    icon: Icon(icon),
                    label: Text(text),
                  ),
          );
        },
      ),
    );
  }
}
