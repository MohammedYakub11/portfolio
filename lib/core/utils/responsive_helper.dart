import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Responsive Helper - Determines device type and provides responsive values
class ResponsiveHelper {
  final BuildContext context;
  
  ResponsiveHelper(this.context);
  
  /// Get screen width
  double get width => MediaQuery.of(context).size.width;
  
  /// Get screen height
  double get height => MediaQuery.of(context).size.height;
  
  /// Check if mobile
  bool get isMobile => width < AppTheme.mobileBreakpoint;
  
  /// Check if tablet
  bool get isTablet => width >= AppTheme.mobileBreakpoint && 
                       width < AppTheme.desktopBreakpoint;
  
  /// Check if desktop
  bool get isDesktop => width >= AppTheme.desktopBreakpoint;
  
  /// Get responsive value based on device type
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
  
  /// Get responsive padding
  EdgeInsets get pagePadding => EdgeInsets.symmetric(
    horizontal: responsive(
      mobile: AppTheme.spacingMd,
      tablet: AppTheme.spacingXl,
      desktop: AppTheme.spacing3xl,
    ),
    vertical: AppTheme.spacingLg,
  );
  
  /// Get responsive section padding
  EdgeInsets get sectionPadding => EdgeInsets.symmetric(
    vertical: responsive(
      mobile: AppTheme.spacing2xl,
      tablet: AppTheme.spacing3xl,
      desktop: 80.0,
    ),
  );
  
  /// Get max content width for desktop
  double get maxContentWidth => responsive(
    mobile: width,
    tablet: 900,
    desktop: 1200,
  );
}

/// Responsive Widget Builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveHelper helper) builder;
  
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });
  
  @override
  Widget build(BuildContext context) {
    return builder(context, ResponsiveHelper(context));
  }
}
