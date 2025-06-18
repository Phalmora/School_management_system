import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black87,
      ),
      elevation: 0,
      scrolledUnderElevation: 0, // Prevents elevation when scrolling
      surfaceTintColor: Colors.transparent, // Prevents tint color changes
      title: _buildResponsiveTitle(context),
      centerTitle: false,
      titleSpacing: 16, // Consistent spacing
    );
  }

  Widget _buildResponsiveTitle(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        // Adjust sizes based on screen size
        final logoSize = isDesktop ? 40.0 : isTablet ? 36.0 : 32.0;
        final fontSize = isDesktop ? 22.0 : isTablet ? 21.0 : 18.0;
        final spacing = isDesktop ? 20.0 : isTablet ? 18.0 : 12.0;

        return Row(
          children: [
            _buildSchoolLogo(context, logoSize),
            SizedBox(width: spacing),
            Expanded(
              child: _buildSchoolTitle(context, fontSize, screenWidth),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSchoolLogo(BuildContext context, double size) {
    return GestureDetector(
      onTap: () => _navigateToSchoolDetails(context),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/school.png',
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildFallbackLogo(size);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackLogo(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade100,
            Colors.orange.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.school_rounded,
        color: Colors.orange.shade700,
        size: size * 0.6, // Proportional icon size
      ),
    );
  }

  Widget _buildSchoolTitle(BuildContext context, double fontSize, double screenWidth) {
    const schoolName = 'Royal Public School';

    return GestureDetector(
      onTap: () => _navigateToStudentDashboard(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate if text will overflow
          final textPainter = TextPainter(
            text: TextSpan(
              text: schoolName,
              style: _getTextStyle(fontSize),
            ),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(maxWidth: constraints.maxWidth);

          final willOverflow = textPainter.didExceedMaxLines;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Text(
              schoolName,
              style: _getTextStyle(fontSize),
              overflow: willOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
              maxLines: 1,
            ),
          );
        },
      ),
    );
  }

  TextStyle _getTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      shadows: [
        Shadow(
          offset: const Offset(0.5, 0.5),
          blurRadius: 2.0,
          color: Colors.grey.withOpacity(0.3),
        ),
      ],
    );
  }

  void _navigateToSchoolDetails(BuildContext context) {
    try {
      Navigator.pushNamed(context, '/school-details');
    } catch (e) {
      // Handle navigation error gracefully
      debugPrint('Navigation error: $e');
    }
  }

  void _navigateToStudentDashboard(BuildContext context) {
    try {
      Navigator.pushNamed(context, '/student-dashboard');
    } catch (e) {
      // Handle navigation error gracefully
      debugPrint('Navigation error: $e');
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Extension for additional responsive utilities
extension ResponsiveExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 768;
  bool get isTablet => MediaQuery.of(this).size.width >= 768 && MediaQuery.of(this).size.width < 1024;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}