/// Project Entity - Domain Model
class Project {
  final String id;
  final String name;
  final String subtitle;
  final List<String> technologies;
  final String description;
  final List<String> keyContributions;
  final String? githubUrl;
  final String? liveUrl;
  final int order;
  
  const Project({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.technologies,
    required this.description,
    required this.keyContributions,
    this.githubUrl,
    this.liveUrl,
    required this.order,
  });
}

/// Experience Entity - Domain Model
class Experience {
  final String id;
  final String title;
  final String company;
  final String duration;
  final List<String> responsibilities;
  final int order;
  
  const Experience({
    required this.id,
    required this.title,
    required this.company,
    required this.duration,
    required this.responsibilities,
    required this.order,
  });
}

/// Skill Category Entity - Domain Model
class SkillCategory {
  final String category;
  final List<String> skills;
  final int order;
  
  const SkillCategory({
    required this.category,
    required this.skills,
    required this.order,
  });
}
