import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/dashboard/adminProfileModel.dart';


class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample admin data
  final AdminProfile adminData = AdminProfile(
    name: 'Mr. Rajesh Kumar',
    email: 'rajesh.kumar@royalpublic.edu',
    phone: '+91 98765 43210',
    employeeId: 'ADM001',
    designation: 'Principal',
    department: 'Administration',
    experience: '15 years',
    qualification: 'M.Ed, MBA Education Management',
    address: '456 Administrative Block, Mumbai, Maharashtra',
    joinDate: 'June 1, 2010',
    permissions: ['User Management', 'Academic Control', 'Financial Management', 'System Settings'],
    totalTeachers: 45,
    totalStudents: 1250,
    totalClasses: 24,
    schoolRating: 4.8,
    profileImageUrl: '', // Empty for default avatar
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppThemeColor.slideAnimationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          _buildProfileCard(context),
                          _buildStatsCard(context),
                          _buildInfoSection(context),
                          _buildMenuSection(context),
                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      child: Row(
        children: [
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Profile',
                  style: AppThemeResponsiveness.getFontStyle(context),
                ),
                Text(
                  'Manage your administrative account',
                  style: AppThemeResponsiveness.getSplashSubtitleStyle(context),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showEditDialog(context),
            child: Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
              decoration: BoxDecoration(
                color: AppThemeColor.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
              child: Icon(
                Icons.edit,
                color: AppThemeColor.white,
                size: AppThemeResponsiveness.getIconSize(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getMediumSpacing(context)),
      child: Card(
        elevation: AppThemeColor.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppThemeColor.white, AppThemeColor.blue50],
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: AppThemeResponsiveness.getResponsiveRadius(context, 50),
                    backgroundColor: AppThemeColor.primaryIndigo.withOpacity(0.2),
                    child: adminData.profileImageUrl.isEmpty
                        ? Text(
                      adminData.name.split(' ').map((e) => e[0]).take(2).join(),
                      style: TextStyle(
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: AppThemeColor.primaryIndigo,
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 50)),
                      child: Image.network(
                        adminData.profileImageUrl,
                        width: AppThemeResponsiveness.getResponsiveSize(context, 100, 120, 140),
                        height: AppThemeResponsiveness.getResponsiveSize(context, 100, 120, 140),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) / 1.5),
                      decoration: const BoxDecoration(
                        gradient: AppThemeColor.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: AppThemeColor.white,
                        size: AppThemeResponsiveness.getResponsiveIconSize(context, 16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                        vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 12)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.admin_panel_settings,
                            color: AppThemeColor.white,
                            size: AppThemeResponsiveness.getResponsiveIconSize(context, 12),
                          ),
                          SizedBox(width: 2),
                          Text(
                            'ADMIN',
                            style: TextStyle(
                              color: AppThemeColor.white,
                              fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 10),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Text(
                adminData.name,
                style: TextStyle(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 24),
                  fontWeight: FontWeight.bold,
                  color: AppThemeColor.blue800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                adminData.designation,
                style: TextStyle(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
                  color: AppThemeColor.primaryIndigo,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                adminData.department,
                style: TextStyle(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 14),
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
      child: Card(
        elevation: AppThemeColor.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          child: Column(
            children: [
              Row(
                children: [
                  _buildStatItem(
                    context,
                    Icons.group,
                    '${adminData.totalStudents}',
                    'Students',
                    AppThemeColor.primaryBlue,
                  ),
                  _buildStatDivider(),
                  _buildStatItem(
                    context,
                    Icons.person,
                    '${adminData.totalTeachers}',
                    'Teachers',
                    AppThemeColor.primaryIndigo,
                  ),
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Row(
                children: [
                  _buildStatItem(
                    context,
                    Icons.class_,
                    '${adminData.totalClasses}',
                    'Classes',
                    Colors.orange,
                  ),
                  _buildStatDivider(),
                  _buildStatItem(
                    context,
                    Icons.star,
                    '${adminData.schoolRating}',
                    'Rating',
                    Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) + 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: AppThemeResponsiveness.getHeaderIconSize(context)),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppThemeResponsiveness.getStatValueStyle(context),
          ),
          Text(
            label,
            style: AppThemeResponsiveness.getStatTitleStyle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getMediumSpacing(context)),
      child: Card(
        elevation: AppThemeColor.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Administrative Information',
                style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(color: AppThemeColor.blue800),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              _buildInfoRow(context, Icons.email, 'Email', adminData.email),
              _buildInfoRow(context, Icons.phone, 'Phone', adminData.phone),
              _buildInfoRow(context, Icons.badge, 'Employee ID', adminData.employeeId),
              _buildInfoRow(context, Icons.school, 'Qualification', adminData.qualification),
              _buildInfoRow(context, Icons.work, 'Experience', adminData.experience),
              _buildInfoRow(context, Icons.calendar_today, 'Join Date', adminData.joinDate),
              _buildInfoRow(context, Icons.location_on, 'Address', adminData.address),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              _buildPermissionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppThemeResponsiveness.getSmallSpacing(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppThemeResponsiveness.getResponsiveIconSize(context, 20), color: AppThemeColor.primaryIndigo),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.security, size: AppThemeResponsiveness.getResponsiveIconSize(context, 20), color: AppThemeColor.primaryIndigo),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Administrative Permissions',
              style: TextStyle(
                fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: AppThemeResponsiveness.getSmallSpacing(context) - 2,
          runSpacing: AppThemeResponsiveness.getSmallSpacing(context) - 2,
          children: adminData.permissions.map((permission) => Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getSmallSpacing(context) + 2,
                vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppThemeColor.primaryIndigo, Colors.deepPurple],
              ),
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user,
                  color: AppThemeColor.white,
                  size: AppThemeResponsiveness.getResponsiveIconSize(context, 12),
                ),
                SizedBox(width: 4),
                Text(
                  permission,
                  style: TextStyle(
                    color: AppThemeColor.white,
                    fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      MenuItemData(Icons.edit, 'Edit Profile', 'Update personal information', '/'),
      MenuItemData(Icons.lock, 'Change Password', 'Update your password', '/'),
      MenuItemData(Icons.settings, 'System Settings', 'Manage system configurations', '/'),
      MenuItemData(Icons.people, 'User Management', 'Manage teachers and students', '/'),
      MenuItemData(Icons.analytics, 'Reports & Analytics', 'View school performance reports', '/'),
      MenuItemData(Icons.backup, 'Data Backup', 'Backup and restore data', '/'),
      MenuItemData(Icons.notifications, 'Notifications', 'Manage notification settings', '/'),
      MenuItemData(Icons.help, 'Help & Support', 'Get help and support', '/'),
      MenuItemData(Icons.logout, 'Logout', 'Sign out of your account', '/', isLogout: true),
    ];

    return Container(
      margin: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
      child: Card(
        elevation: AppThemeColor.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Column(
          children: menuItems.map((item) => _buildMenuItem(context, item)).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItemData item) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
        decoration: BoxDecoration(
          color: item.isLogout ? Colors.red.withOpacity(0.1) : AppThemeColor.primaryIndigo.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        child: Icon(
          item.icon,
          color: item.isLogout ? Colors.red : AppThemeColor.primaryIndigo,
          size: AppThemeResponsiveness.getIconSize(context),
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: item.isLogout ? Colors.red : Colors.black87,
          fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
        ),
      ),
      subtitle: Text(
        item.subtitle,
        style: TextStyle(
          fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: AppThemeResponsiveness.getResponsiveIconSize(context, 16),
        color: item.isLogout ? Colors.red : Colors.grey,
      ),
      onTap: () => _handleMenuTap(item),
    );
  }

  void _handleMenuTap(MenuItemData item) {
    if (item.isLogout) {
      _showLogoutDialog();
    } else {
      // Handle other menu items
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.title} tapped'),
          backgroundColor: AppThemeColor.primaryIndigo,
        ),
      );
    }
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
        ),
        title: Text('Edit Admin Profile', style: AppThemeResponsiveness.getDialogTitleStyle(context)),
        content: Text('Admin profile editing functionality would be implemented here.',
            style: AppThemeResponsiveness.getDialogContentStyle(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppThemeColor.primaryIndigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context) / 2),
              ),
            ),
            child: const Text('Save', style: TextStyle(color: AppThemeColor.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
        ),
        title: Text('Admin Logout', style: AppThemeResponsiveness.getDialogTitleStyle(context)),
        content: Text('Are you sure you want to logout from admin panel?',
            style: AppThemeResponsiveness.getDialogContentStyle(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle admin logout logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context) / 2),
              ),
            ),
            child: const Text('Logout', style: TextStyle(color: AppThemeColor.white)),
          ),
        ],
      ),
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLogout;
  final String path;

  MenuItemData(this.icon, this.title, this.subtitle, this.path, {this.isLogout = false});
}