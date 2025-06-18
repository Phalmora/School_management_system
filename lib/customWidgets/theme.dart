import 'package:flutter/material.dart';

class AppTheme {
  // Color Constants
  static const Color primaryBlue = Color(0xFF42A5F5);
  static const Color primaryPurple = Color(0xFF5C6BC0);
  static const Color primaryBlue600 = Color(0xFF1E88E5);
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue200 = Color(0xFF90CAF9);
  static final Color blue800 = Colors.blue.shade800;
  static final Color blue600 = Colors.blue.shade600;
  static final Color blue400 = Colors.blue.shade400;
  static const Color greylight = Color(0xFFE5E8EC);
  static const Color greydark = Color(0xFFD9DDE3);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryPurple],
  );

  // Enhanced Device Type Detection
  static bool isSmallPhone(BuildContext context) => MediaQuery.of(context).size.width < 360;
  static bool isMediumPhone(BuildContext context) => MediaQuery.of(context).size.width >= 360 && MediaQuery.of(context).size.width < 400;
  static bool isLargePhone(BuildContext context) => MediaQuery.of(context).size.width >= 400 && MediaQuery.of(context).size.width < 600;
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  // Screen Dimensions
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  // Responsive Dashboard Specific Styling
  static double getDashboardHorizontalPadding(BuildContext context) {
    if (isSmallPhone(context)) return 12.0;
    if (isMediumPhone(context)) return 16.0;
    if (isLargePhone(context)) return 20.0;
    if (isTablet(context)) return 24.0;
    return 32.0;
  }

  static double getDashboardVerticalPadding(BuildContext context) {
    if (isSmallPhone(context)) return 8.0;
    if (isMediumPhone(context)) return 12.0;
    if (isLargePhone(context)) return 16.0;
    if (isTablet(context)) return 20.0;
    return 24.0;
  }

  // Welcome Section Styling
  static double getWelcomeSectionPadding(BuildContext context) {
    if (isSmallPhone(context)) return 16.0;
    if (isMediumPhone(context)) return 20.0;
    if (isLargePhone(context)) return 24.0;
    if (isTablet(context)) return 28.0;
    return 32.0;
  }

  static double getWelcomeAvatarRadius(BuildContext context) {
    if (isSmallPhone(context)) return 28.0;
    if (isMediumPhone(context)) return 32.0;
    if (isLargePhone(context)) return 35.0;
    if (isTablet(context)) return 40.0;
    return 45.0;
  }

  static double getWelcomeAvatarIconSize(BuildContext context) {
    if (isSmallPhone(context)) return 32.0;
    if (isMediumPhone(context)) return 36.0;
    if (isLargePhone(context)) return 40.0;
    if (isTablet(context)) return 45.0;
    return 50.0;
  }

  // Text Styles for Welcome Section
  static TextStyle getWelcomeBackTextStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 14.0 :
    isMediumPhone(context) ? 15.0 :
    isLargePhone(context) ? 16.0 :
    isTablet(context) ? 18.0 : 20.0;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle getWelcomeNameTextStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 20.0 :
    isMediumPhone(context) ? 22.0 :
    isLargePhone(context) ? 24.0 :
    isTablet(context) ? 28.0 : 32.0;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade800,
    );
  }

  static TextStyle getWelcomeClassTextStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 10.0 :
    isMediumPhone(context) ? 11.0 :
    isLargePhone(context) ? 12.0 :
    isTablet(context) ? 14.0 : 16.0;
    return TextStyle(
      color: Colors.indigo.shade700,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  // Quick Stats Styling
  static double getQuickStatsSpacing(BuildContext context) {
    if (isSmallPhone(context)) return 8.0;
    if (isMediumPhone(context)) return 10.0;
    if (isLargePhone(context)) return 12.0;
    if (isTablet(context)) return 16.0;
    return 20.0;
  }

  static double getQuickStatsPadding(BuildContext context) {
    if (isSmallPhone(context)) return 12.0;
    if (isMediumPhone(context)) return 16.0;
    if (isLargePhone(context)) return 20.0;
    if (isTablet(context)) return 24.0;
    return 28.0;
  }

  static double getQuickStatsIconPadding(BuildContext context) {
    if (isSmallPhone(context)) return 8.0;
    if (isMediumPhone(context)) return 10.0;
    if (isLargePhone(context)) return 12.0;
    if (isTablet(context)) return 14.0;
    return 16.0;
  }

  static double getQuickStatsIconSize(BuildContext context) {
    if (isSmallPhone(context)) return 20.0;
    if (isMediumPhone(context)) return 22.0;
    if (isLargePhone(context)) return 24.0;
    if (isTablet(context)) return 28.0;
    return 32.0;
  }

  // Grid Configuration
  static int getDashboardGridCrossAxisCount(BuildContext context) {
    if (isSmallPhone(context)) return 1;
    if (isMediumPhone(context)) return 2;
    if (isLargePhone(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }

  static double getDashboardGridCrossAxisSpacing(BuildContext context) {
    if (isSmallPhone(context)) return 12.0;
    if (isMediumPhone(context)) return 14.0;
    if (isLargePhone(context)) return 16.0;
    if (isTablet(context)) return 20.0;
    return 24.0;
  }

  static double getDashboardGridMainAxisSpacing(BuildContext context) {
    return getDashboardGridCrossAxisSpacing(context);
  }

  static double getDashboardGridChildAspectRatio(BuildContext context) {
    if (isSmallPhone(context)) return 1.2;
    if (isMediumPhone(context)) return 0.9;
    if (isLargePhone(context)) return 0.85;
    if (isTablet(context)) return 0.8;
    return 0.75;
  }

  // Dashboard Card Styling
  static double getDashboardCardPadding(BuildContext context) {
    if (isSmallPhone(context)) return 16.0;
    if (isMediumPhone(context)) return 18.0;
    if (isLargePhone(context)) return 20.0;
    if (isTablet(context)) return 24.0;
    return 28.0;
  }

  static double getDashboardCardIconPadding(BuildContext context) {
    if (isSmallPhone(context)) return 12.0;
    if (isMediumPhone(context)) return 14.0;
    if (isLargePhone(context)) return 16.0;
    if (isTablet(context)) return 18.0;
    return 20.0;
  }

  static double getDashboardCardIconSize(BuildContext context) {
    if (isSmallPhone(context)) return 28.0;
    if (isMediumPhone(context)) return 30.0;
    if (isLargePhone(context)) return 32.0;
    if (isTablet(context)) return 36.0;
    return 40.0;
  }

  // Dashboard Card Text Styles
  static TextStyle getDashboardCardTitleStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 14.0 :
    isMediumPhone(context) ? 15.0 :
    isLargePhone(context) ? 16.0 :
    isTablet(context) ? 18.0 : 20.0;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade800,
    );
  }

  static TextStyle getDashboardCardSubtitleStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 10.0 :
    isMediumPhone(context) ? 11.0 :
    isLargePhone(context) ? 12.0 :
    isTablet(context) ? 13.0 : 14.0;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.grey.shade600,
    );
  }

  // Section Title Styling
  static TextStyle getSectionTitleStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 18.0 :
    isMediumPhone(context) ? 20.0 :
    isLargePhone(context) ? 22.0 :
    isTablet(context) ? 24.0 : 26.0;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  // Activity Section Styling
  static double getActivityItemPadding(BuildContext context) {
    if (isSmallPhone(context)) return 16.0;
    if (isMediumPhone(context)) return 18.0;
    if (isLargePhone(context)) return 20.0;
    if (isTablet(context)) return 24.0;
    return 28.0;
  }

  static double getActivityIconPadding(BuildContext context) {
    if (isSmallPhone(context)) return 8.0;
    if (isMediumPhone(context)) return 9.0;
    if (isLargePhone(context)) return 10.0;
    if (isTablet(context)) return 12.0;
    return 14.0;
  }

  static double getActivityIconSize(BuildContext context) {
    if (isSmallPhone(context)) return 18.0;
    if (isMediumPhone(context)) return 19.0;
    if (isLargePhone(context)) return 20.0;
    if (isTablet(context)) return 22.0;
    return 24.0;
  }

  // Drawer Styling
  static double getDrawerHeaderHeight(BuildContext context) {
    if (isSmallPhone(context)) return 180.0;
    if (isMediumPhone(context)) return 190.0;
    if (isLargePhone(context)) return 200.0;
    if (isTablet(context)) return 220.0;
    return 240.0;
  }

  static double getDrawerAvatarRadius(BuildContext context) {
    if (isSmallPhone(context)) return 35.0;
    if (isMediumPhone(context)) return 38.0;
    if (isLargePhone(context)) return 40.0;
    if (isTablet(context)) return 45.0;
    return 50.0;
  }

  // Responsive Card Styling
  static double getCardElevation(BuildContext context) {
    return isMobile(context) ? 6.0 : (isTablet(context) ? 8.0 : 10.0);
  }

  static double getCardBorderRadius(BuildContext context) {
    if (isSmallPhone(context)) return 16.0;
    if (isMediumPhone(context)) return 20.0;
    if (isLargePhone(context)) return 24.0;
    if (isTablet(context)) return 28.0;
    return 32.0;
  }

  // Responsive Input Field Styling
  static double getInputBorderRadius(BuildContext context) {
    return isMobile(context) ? 8.0 : (isTablet(context) ? 10.0 : 12.0);
  }

  static double getFocusedBorderWidth(BuildContext context) {
    return isMobile(context) ? 1.5 : (isTablet(context) ? 2.0 : 2.5);
  }

  // Responsive Button Styling
  static double getButtonHeight(BuildContext context) {
    return isMobile(context) ? 45.0 : (isTablet(context) ? 50.0 : 55.0);
  }

  static double getButtonBorderRadius(BuildContext context) {
    return getButtonHeight(context) / 2;
  }

  static double getButtonElevation(BuildContext context) {
    return isMobile(context) ? 4.0 : (isTablet(context) ? 5.0 : 6.0);
  }

  // Responsive Text Styles
  static TextStyle getButtonTextStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 16.0 : (isTablet(context) ? 18.0 : 20.0);
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: white,
      fontFamily: 'Roboto',
    );
  }

  static TextStyle getFontStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 24.0 : (isTablet(context) ? 28.0 : 32.0);
    return TextStyle(
      fontSize: fontSize,
      color: white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    );
  }

  static TextStyle getHeadingStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 16.0 : (isTablet(context) ? 18.0 : 20.0);
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800],
    );
  }

  static TextStyle getSubHeadingStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 14.0 : (isTablet(context) ? 15.0 : 16.0);
    return TextStyle(
      fontSize: fontSize,
      color: Colors.grey[600],
    );
  }

  static TextStyle getBodyTextStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 13.0 : (isTablet(context) ? 14.0 : 15.0);
    return TextStyle(fontSize: fontSize);
  }

  static TextStyle getCaptionTextStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 11.0 : (isTablet(context) ? 12.0 : 13.0);
    return TextStyle(fontSize: fontSize, color: Colors.grey[600]);
  }

  static TextStyle getStatValueStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 16.0 :
    isMediumPhone(context) ? 17.0 :
    isLargePhone(context) ? 18.0 :
    isTablet(context) ? 20.0 : 22.0;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800],
    );
  }

  static TextStyle getStatTitleStyle(BuildContext context) {
    double fontSize = isSmallPhone(context) ? 10.0 :
    isMediumPhone(context) ? 11.0 :
    isLargePhone(context) ? 12.0 :
    isTablet(context) ? 13.0 : 14.0;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle getSplashSubtitleStyle(BuildContext context) {
    double fontSize = isMobile(context) ? 14.0 : (isTablet(context) ? 16.0 : 18.0);
    return TextStyle(fontSize: fontSize, color: white70, fontFamily: 'Roboto');
  }

  // Responsive Spacing
  static double getDefaultSpacing(BuildContext context) {
    if (isSmallPhone(context)) return 12.0;
    if (isMediumPhone(context)) return 16.0;
    if (isLargePhone(context)) return 20.0;
    if (isTablet(context)) return 24.0;
    return 28.0;
  }

  static double getSmallSpacing(BuildContext context) {
    return isMobile(context) ? 8.0 : (isTablet(context) ? 10.0 : 12.0);
  }

  static double getMediumSpacing(BuildContext context) {
    return isMobile(context) ? 12.0 : (isTablet(context) ? 15.0 : 18.0);
  }

  static double getLargeSpacing(BuildContext context) {
    return isMobile(context) ? 40.0 : (isTablet(context) ? 50.0 : 60.0);
  }

  static double getExtraLargeSpacing(BuildContext context) {
    return isMobile(context) ? 24.0 : (isTablet(context) ? 30.0 : 36.0);
  }

  // Responsive Icon sizes
  static double getIconSize(BuildContext context) {
    return isMobile(context) ? 24.0 : (isTablet(context) ? 28.0 : 32.0);
  }

  static double getHeaderIconSize(BuildContext context) {
    return isMobile(context) ? 26.0 : (isTablet(context) ? 30.0 : 34.0);
  }

  static double getStatIconSize(BuildContext context) {
    return isMobile(context) ? 26.0 : (isTablet(context) ? 30.0 : 34.0);
  }

  static double getLogoSize(BuildContext context) {
    return isMobile(context) ? 40.0 : (isTablet(context) ? 50.0 : 60.0);
  }

  // Responsive Padding
  static EdgeInsets getCardPadding(BuildContext context) {
    double padding = getDefaultSpacing(context);
    return EdgeInsets.all(padding);
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    double padding = getDefaultSpacing(context);
    return EdgeInsets.all(padding);
  }

  static EdgeInsets getHorizontalPadding(BuildContext context) {
    double padding = getDefaultSpacing(context);
    return EdgeInsets.symmetric(horizontal: padding);
  }

  static EdgeInsets getVerticalPadding(BuildContext context) {
    double padding = getDefaultSpacing(context);
    return EdgeInsets.symmetric(vertical: padding);
  }

  // Status badge padding
  static EdgeInsets getStatusBadgePadding(BuildContext context) {
    double horizontal = isMobile(context) ? 10.0 : (isTablet(context) ? 12.0 : 14.0);
    double vertical = isMobile(context) ? 4.0 : (isTablet(context) ? 6.0 : 8.0);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  // Layout helpers
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800;
    return 1200;
  }

  static double getTabBarHeight(BuildContext context) {
    return isMobile(context) ? 40.0 : (isTablet(context) ? 45.0 : 50.0);
  }

  static double getAppBarHeight(BuildContext context) {
    return isMobile(context) ? kToolbarHeight : (isTablet(context) ? kToolbarHeight + 10 : kToolbarHeight + 20);
  }

  // Dialog dimensions
  static double getDialogWidth(BuildContext context) {
    if (isMobile(context)) return getScreenWidth(context) * 0.9;
    if (isTablet(context)) return getScreenWidth(context) * 0.6;
    return getScreenWidth(context) * 0.4;
  }

  // Time chip styling
  static EdgeInsets getTimeChipPadding(BuildContext context) {
    double horizontal = isMobile(context) ? 8.0 : (isTablet(context) ? 10.0 : 12.0);
    double vertical = isMobile(context) ? 4.0 : (isTablet(context) ? 5.0 : 6.0);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static double getTimeChipIconSize(BuildContext context) {
    return getIconSize(context) * 0.7;
  }

  // History card styling
  static EdgeInsets getHistoryCardMargin(BuildContext context) {
    return EdgeInsets.only(bottom: getMediumSpacing(context));
  }

  // Responsive font sizes for specific components
  static double getTabFontSize(BuildContext context) {
    return isMobile(context) ? 14.0 : (isTablet(context) ? 16.0 : 18.0);
  }

  static double getStatusBadgeFontSize(BuildContext context) {
    return isMobile(context) ? 10.0 : (isTablet(context) ? 12.0 : 14.0);
  }

  static double getAttendanceRateFontSize(BuildContext context) {
    return isMobile(context) ? 14.0 : (isTablet(context) ? 16.0 : 18.0);
  }

  static double getHistoryTimeFontSize(BuildContext context) {
    return isMobile(context) ? 12.0 : (isTablet(context) ? 13.0 : 14.0);
  }

  // Animation Durations
  static const Duration splashAnimationDuration = Duration(seconds: 2);
  static const Duration splashScreenDuration = Duration(seconds: 3);
  static const Duration slideAnimationDuration = Duration(milliseconds: 800);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 300);

  // Grid configuration
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 4;
    return 4;
  }

  // TextField configuration
  static int getTextFieldMaxLines(BuildContext context) {
    return isMobile(context) ? 2 : 3;
  }

  // Button styling constants (kept for backward compatibility)
  static const double cardElevation = 8.0;
  static const double cardBorderRadius = 15.0;
  static const double inputBorderRadius = 10.0;
  static const double focusedBorderWidth = 2.0;
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 25.0;
  static const double buttonElevation = 5.0;
  static const double defaultSpacing = 20.0;
  static const double smallSpacing = 10.0;
  static const double mediumSpacing = 15.0;
  static const double largeSpacing = 50.0;
  static const double extraLargeSpacing = 30.0;
  static const double logoSize = 50.0;

  // Text style constants (kept for backward compatibility)
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: white,
    fontFamily: 'Roboto',
  );

  static const TextStyle FontStyle = TextStyle(
    fontSize: 28,
    color: white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );

  static const TextStyle splashSubtitleStyle = TextStyle(
    fontSize: 16,
    color: white70,
    fontFamily: 'Roboto',
  );
}