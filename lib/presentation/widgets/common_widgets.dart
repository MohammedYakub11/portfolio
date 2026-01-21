import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_helper.dart';

/// Section Container - Wraps each major section with consistent spacing
class SectionContainer extends StatelessWidget {
  final String? id;
  final Widget child;
  final Color? backgroundColor;
  
  const SectionContainer({
    super.key,
    this.id,
    required this.child,
    this.backgroundColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, helper) {
        return Container(
          width: double.infinity,
          color: backgroundColor,
          padding: helper.sectionPadding,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: helper.maxContentWidth,
              ),
              child: Padding(
                padding: helper.pagePadding,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Section Header - Consistent heading style for all sections
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center 
          ? CrossAxisAlignment.center 
          : CrossAxisAlignment.start,
      children: [
        // H2 Heading for ATS
        SelectableText(
          title,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppTheme.spacingMd),
          SelectableText(
            subtitle!,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
        const SizedBox(height: AppTheme.spacing2xl),
      ],
    );
  }
}

/// Animated Card - Hover effect for interactive elements
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  
  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
  });
  
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(
            0,
            _isHovered ? -4 : 0,
            0,
          ),
          child: Card(
            elevation: _isHovered ? 8 : 0,
            color: AppTheme.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              side: BorderSide(
                color: _isHovered 
                    ? AppTheme.primaryColor.withOpacity(0.5)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(AppTheme.spacingLg),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Gradient Button - CTA buttons with gradient background
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  
  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingLg,
              vertical: AppTheme.spacingMd,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: AppTheme.spacingSm),
                ],
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Chip Widget - For displaying technologies/skills
class TechChip extends StatelessWidget {
  final String label;
  
  const TechChip({
    super.key,
    required this.label,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: SelectableText(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
