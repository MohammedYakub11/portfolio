import '../../domain/entities/portfolio_entities.dart';

/// Static Data Source - Contains all portfolio content (ATS-Optimized)
class StaticDataSource {
  /// Get all projects with ATS-friendly descriptions
  static List<Project> getProjects() {
    return [
      const Project(
        id: '1',
        name: 'Employee Management System',
        subtitle: 'Flutter Web & Mobile Application',
        technologies: [
          'Flutter',
          'Dart',
          'Firebase',
          'Firestore',
          'REST API',
          'Riverpod',
          'Firebase Cloud Messaging',
        ],
        description:
            'Developed a scalable employee management system using Flutter for web and mobile platforms. '
            'Implemented attendance, leave, holidays, shifts, roster, projects, timesheets, and reporting modules '
            'with secure REST API integration.',
        keyContributions: [
          'Built reusable Flutter widgets to improve development efficiency',
          'Implemented Riverpod for scalable state management',
          'Integrated Firebase Cloud Messaging for real-time push notifications',
          'Designed responsive UI supporting mobile, tablet, and desktop',
          'Contributed to backend API development for secure data exchange',
        ],
        order: 1,
      ),
      const Project(
        id: '2',
        name: 'Student Management System',
        subtitle: 'Flutter + Firebase',
        technologies: [
          'Flutter',
          'Firebase',
          'Firestore',
          'Riverpod',
        ],
        description:
            'Built a comprehensive student management system with Firebase backend. '
            'Features include attendance tracking, timetable management, assignments, and results modules. '
            'Implemented Firebase authentication and Firestore database for real-time data synchronization.',
        keyContributions: [
          'Attendance, timetable, assignments, and results modules',
          'Firebase backend for authentication and database storage',
          'Custom calendar components for scheduling',
          'Clean, maintainable Flutter architecture',
        ],
        order: 2,
      ),
      const Project(
        id: '3',
        name: 'Todo Application',
        subtitle: 'Flutter (MVC Architecture)',
        technologies: [
          'Flutter',
          'Dart',
          'MVC',
        ],
        description:
            'Developed a task management application following MVC architecture pattern. '
            'Implemented CRUD operations with local JSON persistence for offline functionality. '
            'Focused on clean code principles and maintainable architecture.',
        keyContributions: [
          'Implemented CRUD operations using local JSON persistence',
          'Designed clean and responsive UI',
          'Followed MVC architecture for maintainability',
        ],
        order: 3,
      ),
    ];
  }
  
  /// Get all work experience
  static List<Experience> getExperience() {
    return [
      const Experience(
        id: '1',
        title: 'Mobile & Web Application Developer',
        company: 'Ideassion Technology Solution',
        duration: 'Jan 2024 – Present',
        responsibilities: [
          'Designed and developed scalable Flutter web and mobile applications',
          'Integrated REST APIs and Firebase services',
          'Implemented Riverpod state management',
          'Participated in code reviews, debugging, and deployment',
        ],
        order: 1,
      ),
      const Experience(
        id: '2',
        title: 'Business Operations SME',
        company: 'Ford Motor Credit Company',
        duration: 'Feb 2021 – Sep 2022',
        responsibilities: [
          'Managed and reconciled customer accounts',
          'Collaborated with cross-functional teams',
          'Contributed to successful launch of lease extension process',
        ],
        order: 2,
      ),
    ];
  }
  
  /// Get all skills categorized (ATS-Optimized - Plain Text)
  static List<SkillCategory> getSkills() {
    return [
      const SkillCategory(
        category: 'Programming',
        skills: ['Dart'],
        order: 1,
      ),
      const SkillCategory(
        category: 'Framework',
        skills: ['Flutter (Mobile & Web)'],
        order: 2,
      ),
      const SkillCategory(
        category: 'Backend',
        skills: [
          'Firebase (Auth, Firestore, Cloud Messaging)',
        ],
        order: 3,
      ),
      const SkillCategory(
        category: 'State Management',
        skills: ['Riverpod'],
        order: 4,
      ),
      const SkillCategory(
        category: 'Web',
        skills: ['HTML', 'CSS', 'JavaScript'],
        order: 5,
      ),
      const SkillCategory(
        category: 'APIs',
        skills: ['RESTful API Integration'],
        order: 6,
      ),
      const SkillCategory(
        category: 'Architecture',
        skills: ['Clean Architecture', 'MVC'],
        order: 7,
      ),
      const SkillCategory(
        category: 'Tools',
        skills: ['Git', 'VS Code', 'Firebase Console'],
        order: 8,
      ),
    ];
  }
}
