import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_helper.dart';
import '../widgets/common_widgets.dart';

/// Footer Section - Contact and Links
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});
  
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      id: 'contact',
      backgroundColor: AppTheme.surfaceColor,
      child: Column(
        children: [
          const SectionHeader(
            title: 'Get In Touch',
            subtitle: 'Let\'s build something amazing together',
          ),
          
          ResponsiveBuilder(
            builder: (context, helper) {
              return Column(
                children: [
                  // Contact Cards
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppTheme.spacingLg,
                    runSpacing: AppTheme.spacingLg,
                    children: [
                      _ContactCard(
                        icon: FontAwesomeIcons.envelope,
                        title: 'Email',
                        value: AppConstants.email,
                        onTap: () => _launchUrl('mailto:${AppConstants.email}'),
                      ),
                      _ContactCard(
                        icon: FontAwesomeIcons.linkedin,
                        title: 'LinkedIn',
                        value: 'Connect',
                        onTap: () => _launchUrl(AppConstants.linkedin),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacing2xl),
                  
                  // Divider
                  Container(
                    height: 1,
                    color: AppTheme.cardColor,
                  ),
                  
                  const SizedBox(height: AppTheme.spacingLg),
                  
                  // Copyright
                  SelectableText(
                    '© ${DateTime.now().year} ${AppConstants.name}. Built with Flutter & Riverpod.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingSm),
                  
                  // ATS Keywords Footer (Hidden but readable by bots)
                  SelectableText(
                    'Flutter Developer | Dart | Firebase | REST API | Riverpod | Mobile App Development | Web Development',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Contact Card
class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;
  
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      onTap: onTap,
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingMd),
            
            SelectableText(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingSm),
            
            SelectableText(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
