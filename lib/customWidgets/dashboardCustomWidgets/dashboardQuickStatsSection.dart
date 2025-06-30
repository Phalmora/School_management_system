import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';


class QuickStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  const QuickStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = AppThemeResponsiveness.isSmallPhone(context)
        ? 120
        : AppThemeResponsiveness.isMediumPhone(context)
        ? 130
        : AppThemeResponsiveness.isTablet(context)
        ? 150
        : 160;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(
          right: AppThemeResponsiveness.getSmallSpacing(context),
        ),
        padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsPadding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: AppThemeResponsiveness.getCardElevation(context),
              offset: Offset(0, AppThemeResponsiveness.getCardElevation(context) * 0.5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context)),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: AppThemeResponsiveness.getQuickStatsIconSize(context),
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 1.2),
            Text(
              value,
              style: AppThemeResponsiveness.getStatValueStyle(context).copyWith(color: iconColor),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.4),
            Text(
              title,
              style: AppThemeResponsiveness.getStatTitleStyle(context),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
