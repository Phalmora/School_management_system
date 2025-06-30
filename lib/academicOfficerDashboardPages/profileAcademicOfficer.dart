import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/profileAcademicOfficerModel.dart';


class AcademicOfficerProfilePage extends StatefulWidget {
  const AcademicOfficerProfilePage({Key? key}) : super(key: key);

  @override
  State<AcademicOfficerProfilePage> createState() => _AcademicOfficerProfilePageState();
}

class _AcademicOfficerProfilePageState extends State<AcademicOfficerProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample academic officer data
  final AcademicOfficerProfile officerData = AcademicOfficerProfile(
    name: 'Dr. Michael Rodriguez',
    email: 'michael.rodriguez@royalpublic.edu',
    phone: '+91 98765 43211',
    employeeId: 'AO001',
    department: 'Academic Affairs',
    designation: 'Senior Academic Officer',
    experience: '12 years',
    qualification: 'Ph.D Education Administration, M.Ed',
    address: '456 Academic Street, Mumbai, Maharashtra',
    joinDate: 'June 10, 2012',
    responsibilities: ['Curriculum Development', 'Academic Planning', 'Quality Assurance', 'Faculty Coordination'],
    managedDepartments: ['Mathematics', 'Science', 'English', 'Social Studies'],
    totalFaculty: 45,
    activeCourses: 32,
    completedProjects: 18,
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
                  'Academic Officer Profile',
                  style: AppThemeResponsiveness.getFontStyle(context),
                ),
                Text(
                  'Manage your administrative profile',
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
                    backgroundColor: AppThemeColor.blue100,
                    child: officerData.profileImageUrl.isEmpty
                        ? Text(
                      officerData.name.split(' ').map((e) => e[0]).take(2).join(),
                      style: TextStyle(
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                        color: AppThemeColor.blue800,
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 50)),
                      child: Image.network(
                        officerData.profileImageUrl,
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
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Text(
                officerData.name,
                style: TextStyle(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 24),
                  fontWeight: FontWeight.bold,
                  color: AppThemeColor.blue800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                officerData.designation,
                style: TextStyle(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
                  color: AppThemeColor.blue600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                officerData.department,
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
          child: Row(
            children: [
              _buildStatItem(
                context,
                Icons.people,
                '${officerData.totalFaculty}',
                'Faculty',
                AppThemeColor.primaryBlue,
              ),
              _buildStatDivider(),
              _buildStatItem(
                context,
                Icons.library_books,
                '${officerData.activeCourses}',
                'Courses',
                AppThemeColor.primaryIndigo,
              ),
              _buildStatDivider(),
              _buildStatItem(
                context,
                Icons.assignment_turned_in,
                '${officerData.completedProjects}',
                'Projects',
                Colors.green,
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
                'Professional Information',
                style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(color: AppThemeColor.blue800),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              _buildInfoRow(context, Icons.email, 'Email', officerData.email),
              _buildInfoRow(context, Icons.phone, 'Phone', officerData.phone),
              _buildInfoRow(context, Icons.badge, 'Employee ID', officerData.employeeId),
              _buildInfoRow(context, Icons.school, 'Qualification', officerData.qualification),
              _buildInfoRow(context, Icons.work, 'Experience', officerData.experience),
              _buildInfoRow(context, Icons.calendar_today, 'Join Date', officerData.joinDate),
              _buildInfoRow(context, Icons.location_on, 'Address', officerData.address),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              _buildResponsibilitiesSection(context),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              _buildDepartmentsSection(context),
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
          Icon(icon, size: AppThemeResponsiveness.getResponsiveIconSize(context, 20), color: AppThemeColor.blue600),
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

  Widget _buildResponsibilitiesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.assignment, size: AppThemeResponsiveness.getResponsiveIconSize(context, 20), color: AppThemeColor.blue600),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Key Responsibilities',
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
          children: officerData.responsibilities.map((responsibility) => Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getSmallSpacing(context) + 2,
                vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2
            ),
            decoration: BoxDecoration(
              gradient: AppThemeColor.primaryGradient,
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 20)),
            ),
            child: Text(
              responsibility,
              style: TextStyle(
                color: AppThemeColor.white,
                fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDepartmentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.business, size: AppThemeResponsiveness.getResponsiveIconSize(context, 20), color: AppThemeColor.blue600),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Managed Departments',
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
          children: officerData.managedDepartments.map((department) => Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getSmallSpacing(context) + 2,
                vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2
            ),
            decoration: BoxDecoration(
              color: AppThemeColor.blue100,
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 20)),
              border: Border.all(color: AppThemeColor.blue200),
            ),
            child: Text(
              department,
              style: TextStyle(
                color: AppThemeColor.blue800,
                fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      MenuItemData(Icons.edit, 'Edit Profile', 'Update professional information', '/'),
      MenuItemData(Icons.lock, 'Change Password', 'Update your password', '/'),
      MenuItemData(Icons.analytics, 'Academic Reports', 'View department analytics', '/'),
      MenuItemData(Icons.schedule, 'Course Management', 'Manage academic schedules', '/'),
      MenuItemData(Icons.group, 'Faculty Management', 'Manage faculty members', '/'),
      MenuItemData(Icons.notifications, 'Notifications', 'Manage notification settings', '/'),
      MenuItemData(Icons.language, 'Language', 'Change app language', '/'),
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
          color: item.isLogout ? Colors.red.withOpacity(0.1) : AppThemeColor.blue50,
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        child: Icon(
          item.icon,
          color: item.isLogout ? Colors.red : AppThemeColor.blue600,
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
          backgroundColor: AppThemeColor.primaryBlue,
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
        title: Text('Edit Profile', style: AppThemeResponsiveness.getDialogTitleStyle(context)),
        content: Text('Profile editing functionality would be implemented here.',
            style: AppThemeResponsiveness.getDialogContentStyle(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppThemeColor.primaryBlue,
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
        title: Text('Logout', style: AppThemeResponsiveness.getDialogTitleStyle(context)),
        content: Text('Are you sure you want to logout?',
            style: AppThemeResponsiveness.getDialogContentStyle(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout logic here
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