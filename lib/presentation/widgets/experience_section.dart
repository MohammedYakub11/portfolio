import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_helper.dart';
import '../providers/portfolio_providers.dart';
import '../widgets/common_widgets.dart';

/// Experience Section - Professional Work History
class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(experienceProvider);
    
    return SectionContainer(
      id: 'experience',
      child: Column(
        children: [
          const SectionHeader(
            title: 'Professional Experience',
            subtitle: 'My journey in software development and business operations',
          ),
          
          ResponsiveBuilder(
            builder: (context, helper) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppTheme.spacingLg,
                ),
                itemBuilder: (context, index) {
                  final experience = experiences[index];
                  return _ExperienceCard(
                    title: experience.title,
                    company: experience.company,
                    duration: experience.duration,
                    responsibilities: experience.responsibilities,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Experience Card
class _ExperienceCard extends StatelessWidget {
  final String title;
  final String company;
  final String duration;
  final List<String> responsibilities;
  
  const _ExperienceCard({
    required this.title,
    required this.company,
    required this.duration,
    required this.responsibilities,
  });
  
  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.briefcase,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(width: AppTheme.spacingLg),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Title - H3 for ATS
                SelectableText(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacingSm),
                
                // Company and Duration
                Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        company,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spacingSm),
                
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 14,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    SelectableText(
                      duration,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spacingMd),
                
                // Divider
                Container(
                  height: 1,
                  color: AppTheme.cardColor,
                ),
                
                const SizedBox(height: AppTheme.spacingMd),
                
                // Responsibilities - Bullet Points for ATS
                ...responsibilities.map((responsibility) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: FaIcon(
                            FontAwesomeIcons.circleCheck,
                            size: 12,
                            color: AppTheme.successColor,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Expanded(
                          child: SelectableText(
                            responsibility,
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
          ),
        ],
      ),
    );
  }
}
