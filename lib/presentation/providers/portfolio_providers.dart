import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/static_data_source.dart';
import '../../domain/entities/portfolio_entities.dart';

/// Provider for Projects List
final projectsProvider = Provider<List<Project>>((ref) {
  return StaticDataSource.getProjects();
});

/// Provider for Experience List
final experienceProvider = Provider<List<Experience>>((ref) {
  return StaticDataSource.getExperience();
});

/// Provider for Skills List
final skillsProvider = Provider<List<SkillCategory>>((ref) {
  return StaticDataSource.getSkills();
});

/// Provider for Selected Project (for future detail view)
final selectedProjectProvider = StateProvider<Project?>((ref) => null);
