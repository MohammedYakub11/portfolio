import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_helper.dart';
import '../widgets/common_widgets.dart';
import '../widgets/animations.dart';

/// Hero Section - Professional Summary and Introduction
class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;
  
  const HeroSection({
    super.key,
    this.onViewProjects,
  });
  
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
  
  Future<void> _downloadResume(BuildContext context) async {
    try {
      // For Flutter Web, we'll open the PDF in a new tab
      final uri = Uri.parse(AppConstants.resumePath);
      if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open resume. Please try again.'),
              backgroundColor: AppTheme.warningColor,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error downloading resume: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening resume. Please contact me directly.'),
            backgroundColor: AppTheme.warningColor,
          ),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'hero',
      child: ResponsiveBuilder(
        builder: (context, helper) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name - H1 for SEO/ATS (Animated)
              FadeInAnimation(
                duration: const Duration(milliseconds: 1000),
                child: SlideInAnimation(
                  offsetY: 30,
                  child: SelectableText(
                    AppConstants.name,
                    textAlign: TextAlign.center,
                    style: helper.responsive(
                      mobile: Theme.of(context).textTheme.displaySmall,
                      tablet: Theme.of(context).textTheme.displayMedium,
                      desktop: Theme.of(context).textTheme.displayLarge,
                    )?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingMd),
              
              // Title - H2 with ATS Keywords (Animated)
              SlideInAnimation(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingLg,
                    vertical: AppTheme.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: SelectableText(
                    AppConstants.title,
                    textAlign: TextAlign.center,
                    style: helper.responsive(
                      mobile: Theme.of(context).textTheme.titleMedium,
                      tablet: Theme.of(context).textTheme.titleLarge,
                      desktop: Theme.of(context).textTheme.headlineSmall,
                    )?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingLg),
              
              // Experience and Location (Animated)
              FadeInAnimation(
                delay: const Duration(milliseconds: 400),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppTheme.spacingLg,
                  runSpacing: AppTheme.spacingSm,
                  children: [
                    _InfoChip(
                      icon: FontAwesomeIcons.briefcase,
                      text: AppConstants.experience,
                    ),
                    _InfoChip(
                      icon: FontAwesomeIcons.locationDot,
                      text: AppConstants.location,
                    ),
                    _InfoChip(
                      icon: FontAwesomeIcons.circleCheck,
                      text: AppConstants.availability,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppTheme.spacing2xl),
              
              // Professional Summary - ATS-Optimized (Animated)
              ScaleInAnimation(
                delay: const Duration(milliseconds: 600),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.all(AppTheme.spacingLg),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        'Professional Summary',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      SelectableText(
                        AppConstants.professionalSummary,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.spacing2xl),
              
              // CTA Buttons (Animated)
              FadeInAnimation(
                delay: const Duration(milliseconds: 800),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppTheme.spacingMd,
                  runSpacing: AppTheme.spacingMd,
                  children: [
                    SizedBox(
                      width: 220,
                      child: GradientButton(
                        text: 'View Projects',
                        icon: FontAwesomeIcons.code,
                        onPressed: onViewProjects ?? () {},
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: _OutlineButton(
                        text: 'Download Resume',
                        icon: FontAwesomeIcons.download,
                        onPressed: () => _downloadResume(context),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppTheme.spacing2xl),
              
              // Social Links (Animated)
              FadeInAnimation(
                delay: const Duration(milliseconds: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      icon: FontAwesomeIcons.linkedin,
                      label: 'LinkedIn',
                      onPressed: () => _launchUrl(AppConstants.linkedin),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Info Chip Widget
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  
  const _InfoChip({
    required this.icon,
    required this.text,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 14,
            color: AppTheme.accentColor,
          ),
          const SizedBox(width: AppTheme.spacingSm),
          SelectableText(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Outline Button Widget
class _OutlineButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  
  const _OutlineButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.textPrimaryColor,
        side: const BorderSide(color: AppTheme.primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingLg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: AppTheme.textPrimaryColor),
          const SizedBox(width: AppTheme.spacingSm),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Social Button Widget
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon),
      iconSize: 24,
      color: AppTheme.textSecondaryColor,
      tooltip: label,
      hoverColor: AppTheme.primaryColor.withOpacity(0.1),
    );
  }
}
