import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_helper.dart';
import '../providers/portfolio_providers.dart';
import '../widgets/common_widgets.dart';
import '../widgets/animations.dart';

/// Projects Section - ATS-Optimized Format
class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    
    return SectionContainer(
      id: 'projects',
      backgroundColor: AppTheme.surfaceColor.withOpacity(0.3),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Featured Projects',
            subtitle: 'Real-world applications built with Flutter, Firebase, and modern architecture',
          ),
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: AppTheme.spacingXl,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];
              return SlideInAnimation(
                delay: Duration(milliseconds: 150 * index),
                child: _ProjectCard(
                  name: project.name,
                  subtitle: project.subtitle,
                  technologies: project.technologies,
                  description: project.description,
                  keyContributions: project.keyContributions,
                  githubUrl: project.githubUrl,
                  liveUrl: project.liveUrl,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Project Card - Following ATS Best Practices
class _ProjectCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final List<String> technologies;
  final String description;
  final List<String> keyContributions;
  final String? githubUrl;
  final String? liveUrl;
  
  const _ProjectCard({
    required this.name,
    required this.subtitle,
    required this.technologies,
    required this.description,
    required this.keyContributions,
    this.githubUrl,
    this.liveUrl,
  });
  
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, helper) {
        return AnimatedCard(
          padding: EdgeInsets.all(
            helper.responsive(
              mobile: AppTheme.spacingLg,
              tablet: AppTheme.spacingXl,
              desktop: AppTheme.spacingXl,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Name | Subtitle - H3 for ATS
              SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' | ',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: subtitle,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textSecondaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingMd),
              
              // Technologies - Plain Text with Labels (ATS LOVES THIS)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    'Technologies:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  Wrap(
                    spacing: AppTheme.spacingSm,
                    runSpacing: AppTheme.spacingSm,
                    children: technologies.map((tech) => TechChip(label: tech)).toList(),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingLg),
              
              // Description - Plain Text (ATS-Friendly)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    'Description:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  SelectableText(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.7,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingLg),
              
              // Key Contributions - Bullet Points (ATS LOVES THIS)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    'Key Contributions:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  ...keyContributions.map((contribution) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: FaIcon(
                              FontAwesomeIcons.circleCheck,
                              size: 14,
                              color: AppTheme.successColor,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMd),
                          Expanded(
                            child: SelectableText(
                              contribution,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
              
              // Links (if available)
              if (githubUrl != null || liveUrl != null) ...[
                const SizedBox(height: AppTheme.spacingLg),
                Wrap(
                  spacing: AppTheme.spacingMd,
                  runSpacing: AppTheme.spacingMd,
                  children: [
                    if (githubUrl != null)
                      _ProjectLinkButton(
                        icon: FontAwesomeIcons.github,
                        label: 'View Code',
                        url: githubUrl!,
                      ),
                    if (liveUrl != null)
                      _ProjectLinkButton(
                        icon: FontAwesomeIcons.arrowUpRightFromSquare,
                        label: 'Live Demo',
                        url: liveUrl!,
                      ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Project Link Button
class _ProjectLinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  
  const _ProjectLinkButton({
    required this.icon,
    required this.label,
    required this.url,
  });
  
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: Launch URL
        debugPrint('Launch: $url');
      },
      icon: FaIcon(icon, size: 14),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: const BorderSide(color: AppTheme.primaryColor),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ),
      ),
    );
  }
}
