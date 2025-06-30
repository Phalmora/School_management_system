import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';


class WelcomeSection extends StatelessWidget {
  final String name;
  final String classInfo;
  final bool isActive;
  final bool isVerified;
  final bool isSuperUser;
  final IconData icon; // NEW

  const WelcomeSection({
    super.key,
    required this.name,
    required this.classInfo,
    this.isActive = true,
    this.isVerified = false,
    this.isSuperUser = false,
    this.icon = Icons.person_rounded, // Default icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardPadding(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppThemeResponsiveness.getCardElevation(context),
            offset: Offset(0, AppThemeResponsiveness.getCardElevation(context) * 0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Hero(
            tag: 'profile_avatar',
            child: Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 0.4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.purple.shade400],
                ),
              ),
              child: CircleAvatar(
                radius: AppThemeResponsiveness.getWelcomeAvatarRadius(context),
                backgroundColor: Colors.white,
                child: Icon(
                  icon, // CUSTOM ICON HERE
                  size: AppThemeResponsiveness.getWelcomeAvatarIconSize(context),
                  color: Colors.indigo.shade600,
                ),
              ),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getDefaultSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: AppThemeResponsiveness.getWelcomeBackTextStyle(context),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.4),
                Text(
                  name,
                  style: AppThemeResponsiveness.getWelcomeNameTextStyle(context),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.8),
                Wrap(
                  spacing: AppThemeResponsiveness.getSmallSpacing(context) * 0.8,
                  runSpacing: AppThemeResponsiveness.getSmallSpacing(context) * 0.4,
                  children: [
                    _buildTag(
                      context,
                      text: classInfo,
                      backgroundColor: Colors.indigo.shade100,
                      textColor: Colors.indigo.shade700,
                    ),
                    if (isActive)
                      _buildIconTag(
                        context,
                        icon: Icons.check_circle,
                        text: 'Active',
                        backgroundColor: Colors.green.shade100,
                        iconColor: Colors.green.shade700,
                        textColor: Colors.green.shade700,
                      ),
                    if (isSuperUser)
                      _buildIconTag(
                        context,
                        icon: Icons.shield_rounded,
                        text: 'Super User',
                        backgroundColor: Colors.red.shade100,
                        iconColor: Colors.red.shade700,
                        textColor: Colors.red.shade700,
                      ),
                  ],
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.4),
                if (isVerified)
                  _buildIconTag(
                    context,
                    icon: Icons.verified_rounded,
                    text: 'Verified',
                    backgroundColor: Colors.yellow.shade100,
                    iconColor: Colors.yellow.shade700,
                    textColor: Colors.yellow.shade700,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(
      BuildContext context, {
        required String text,
        required Color backgroundColor,
        required Color textColor,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getSmallSpacing(context) * 1.2,
        vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
      ),
      child: Text(
        text,
        style: AppThemeResponsiveness.getWelcomeClassTextStyle(context).copyWith(color: textColor),
      ),
    );
  }

  Widget _buildIconTag(
      BuildContext context, {
        required IconData icon,
        required String text,
        required Color backgroundColor,
        required Color iconColor,
        required Color textColor,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getSmallSpacing(context) * 1.2,
        vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppThemeResponsiveness.getCaptionTextStyle(context).fontSize! + 2,
            color: iconColor,
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) * 0.4),
          Text(
            text,
            style: AppThemeResponsiveness.getWelcomeClassTextStyle(context).copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
