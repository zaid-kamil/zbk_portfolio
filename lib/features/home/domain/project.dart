


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

  const Project({
    required this.category,
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.githubUrl,
    this.url,
  });


}