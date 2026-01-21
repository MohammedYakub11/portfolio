import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_helper.dart';
import '../providers/portfolio_providers.dart';
import '../widgets/common_widgets.dart';
import '../widgets/animations.dart';

/// Skills Section - ATS-Optimized with Plain Text
class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = ref.watch(skillsProvider);
    
    return SectionContainer(
      id: 'skills',
      backgroundColor: AppTheme.surfaceColor.withOpacity(0.3),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Technical Skills',
            subtitle: 'Technologies and tools I work with professionally',
          ),
          
          ResponsiveBuilder(
            builder: (context, helper) {
              final crossAxisCount = helper.responsive(
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              
              // Calculate card width based on screen size
              final cardWidth = (helper.maxContentWidth - 
                  (helper.pagePadding.horizontal) - 
                  (AppTheme.spacingLg * (crossAxisCount - 1))) / 
                  crossAxisCount;
              
              return Wrap(
                spacing: AppTheme.spacingLg,
                runSpacing: AppTheme.spacingLg,
                children: skills.asMap().entries.map((entry) {
                  final index = entry.key;
                  final skillCategory = entry.value;
                  
                  return SlideInAnimation(
                    delay: Duration(milliseconds: 100 * index),
                    child: SizedBox(
                      width: helper.isMobile ? double.infinity : cardWidth,
                      child: _SkillCategoryCard(
                        category: skillCategory.category,
                        skills: skillCategory.skills,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Skill Category Card
class _SkillCategoryCard extends StatelessWidget {
  final String category;
  final List<String> skills;
  
  const _SkillCategoryCard({
    required this.category,
    required this.skills,
  });
  
  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category Name - H3 for ATS
          SelectableText(
            category,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Divider
          Container(
            height: 2,
            width: 40,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Skills List - Plain Text for ATS
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: SelectableText(
                  skill,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
