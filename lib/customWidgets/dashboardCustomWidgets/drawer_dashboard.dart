import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeColor.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';

class ModernDrawerSection {
  final String title;
  final List<ModernDrawerItem> items;

  ModernDrawerSection({required this.title, required this.items});
}

class ModernDrawerItem {
  final IconData icon;
  final String title;
  final String? route;
  final String? badge;
  final VoidCallback? onTap;
  final bool isDestructive;

  ModernDrawerItem({
    required this.icon,
    required this.title,
    this.route,
    this.badge,
    this.onTap,
    this.isDestructive = false,
  });
}

class ModernDrawer extends StatelessWidget {
  final IconData headerIcon;
  final String headerTitle;
  final String headerSubtitle;
  final List<ModernDrawerSection> sections;

  const ModernDrawer({
    Key? key,
    required this.headerIcon,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.sections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(gradient: AppThemeColor.primaryGradient),
        child: Column(
          children: [
            _buildDrawerHeader(context),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                    topRight: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: AppThemeResponsiveness.getDefaultSpacing(context),
                  ),
                  children: [
                    ...sections.map((section) => _buildDrawerSection(context, section)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      height: AppThemeResponsiveness.getDrawerHeaderHeight(context),
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'profile_avatar',
            child: Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 0.4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: AppThemeResponsiveness.isMobile(context) ? 2 : 3,
                ),
              ),
              child: CircleAvatar(
                radius: AppThemeResponsiveness.getDrawerAvatarRadius(context),
                backgroundColor: Colors.white,
                child: Icon(
                  headerIcon,
                  size: AppThemeResponsiveness.getDrawerAvatarRadius(context) * 1.2,
                  color: Colors.indigo.shade600,
                ),
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Text(
            headerTitle,
            style: AppThemeResponsiveness.getHeadingTextStyle(context).copyWith(color: Colors.white),
          ),
          Text(
            headerSubtitle,
            style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerSection(BuildContext context, ModernDrawerSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
            vertical: AppThemeResponsiveness.getSmallSpacing(context),
          ),
          child: Text(
            section.title,
            style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...section.items.map((item) => _buildDrawerItem(context, item)).toList(),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 1.5),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context, ModernDrawerItem item) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getSmallSpacing(context) * 1.2,
        vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.2,
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 0.8),
          decoration: BoxDecoration(
            color: item.isDestructive ? Colors.red.shade50 : Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
          child: Icon(
            item.icon,
            color: item.isDestructive ? Colors.red.shade600 : Colors.indigo.shade600,
            size: AppThemeResponsiveness.getIconSize(context),
          ),
        ),
        title: Text(
          item.title,
          style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
            color: item.isDestructive ? Colors.red.shade700 : Colors.grey.shade800,
          ),
        ),
        trailing: item.badge != null
            ? Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeResponsiveness.getSmallSpacing(context),
            vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.4,
          ),
          decoration: BoxDecoration(
            color: Colors.red.shade500,
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
          child: Text(
            item.badge!,
            style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        onTap: item.onTap ??
                () {
              if (item.route != null) {
                Navigator.pushNamed(context, item.route!);
              }
            },
      ),
    );
  }
}
