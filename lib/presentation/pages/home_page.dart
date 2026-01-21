import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/footer_section.dart';

/// Home Page - Main Portfolio Page
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Global keys for each section
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  
  // Scroll controller
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  // Method to scroll to a specific section
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section with Professional Summary
            HeroSection(
              onViewProjects: () => scrollToSection(projectsKey),
            ),
            
            // Skills Section
            SkillsSection(key: skillsKey),
            
            // Experience Section
            ExperienceSection(key: experienceKey),
            
            // Projects Section (Most Important for ATS)
            ProjectsSection(key: projectsKey),
            
            // Footer with Contact
            FooterSection(key: contactKey),
          ],
        ),
      ),
    );
  }
}
