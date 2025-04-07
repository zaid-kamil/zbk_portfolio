


enum ProjectCategory {
  mobileApp,
  webApp,
  dataScience,
  certificates,
  publications,
  aboutMe,
}

class Project {
  final String title;
  final String description;
  final ProjectCategory category;
  final List<String> technologies;
  final String? imageUrl;
  final String? githubUrl;
  final String? url;
  final int difficultyLevel;
  final List<String>? screenshots;
  final String? videoUrl;

  const Project({
    required this.category,
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.githubUrl,
    this.url,
    this.difficultyLevel = 1,
    this.screenshots = const [],
    this.videoUrl,
  });
}