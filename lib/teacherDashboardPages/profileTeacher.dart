import 'package:flutter/material.dart';
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';


class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({Key? key}) : super(key: key);

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample teacher data
  final TeacherProfile teacherData = TeacherProfile(
    name: 'Dr. Sarah Johnson',
    email: 'sarah.johnson@royalpublic.edu',
    phone: '+91 98765 43210',
    employeeId: 'EMP001',
    department: 'Mathematics & Science',
    designation: 'Senior Teacher',
    experience: '8 years',
    qualification: 'M.Sc Mathematics, B.Ed',
    address: '123 Education Lane, Mumbai, Maharashtra',
    joinDate: 'August 15, 2016',
    subjects: ['Mathematics', 'Physics', 'Computer Science'],
    classes: ['Class 10A', 'Class 11B', 'Class 12C'],
    totalStudents: 125,
    completedLessons: 245,
    attendanceRate: 96.5,
    profileImageUrl: '', // Empty for default avatar
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.slideAnimationDuration,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
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
                          _buildProfileCard(),
                          _buildStatsCard(),
                          _buildInfoSection(),
                          _buildMenuSection(),
                          const SizedBox(height: AppTheme.defaultSpacing),
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
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.smallSpacing),
              decoration: BoxDecoration(
                color: AppTheme.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppTheme.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.mediumSpacing),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: AppTheme.FontStyle,
                ),
                Text(
                  'Manage your account information',
                  style: AppTheme.splashSubtitleStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showEditDialog(context),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.smallSpacing),
              decoration: BoxDecoration(
                color: AppTheme.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
              ),
              child: const Icon(
                Icons.edit,
                color: AppTheme.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
      child: Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.defaultSpacing),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.white, AppTheme.blue50],
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.blue100,
                    child: teacherData.profileImageUrl.isEmpty
                        ? Text(
                      teacherData.name.split(' ').map((e) => e[0]).take(2).join(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blue800,
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        teacherData.profileImageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppTheme.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.mediumSpacing),
              Text(
                teacherData.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blue800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                teacherData.designation,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.blue600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                teacherData.department,
                style: const TextStyle(
                  fontSize: 14,
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

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.mediumSpacing),
      child: Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.defaultSpacing),
          child: Row(
            children: [
              _buildStatItem(
                Icons.group,
                '${teacherData.totalStudents}',
                'Students',
                AppTheme.primaryBlue,
              ),
              _buildStatDivider(),
              _buildStatItem(
                Icons.book,
                '${teacherData.completedLessons}',
                'Lessons',
                AppTheme.primaryPurple,
              ),
              _buildStatDivider(),
              _buildStatItem(
                Icons.trending_up,
                '${teacherData.attendanceRate}%',
                'Attendance',
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
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

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
      child: Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blue800,
                ),
              ),
              const SizedBox(height: AppTheme.mediumSpacing),
              _buildInfoRow(Icons.email, 'Email', teacherData.email),
              _buildInfoRow(Icons.phone, 'Phone', teacherData.phone),
              _buildInfoRow(Icons.badge, 'Employee ID', teacherData.employeeId),
              _buildInfoRow(Icons.school, 'Qualification', teacherData.qualification),
              _buildInfoRow(Icons.work, 'Experience', teacherData.experience),
              _buildInfoRow(Icons.calendar_today, 'Join Date', teacherData.joinDate),
              _buildInfoRow(Icons.location_on, 'Address', teacherData.address),
              const SizedBox(height: AppTheme.mediumSpacing),
              _buildSubjectsSection(),
              const SizedBox(height: AppTheme.mediumSpacing),
              _buildClassesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.smallSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppTheme.blue600),
          const SizedBox(width: AppTheme.smallSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
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

  Widget _buildSubjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.subject, size: 20, color: AppTheme.blue600),
            const SizedBox(width: AppTheme.smallSpacing),
            const Text(
              'Teaching Subjects',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: teacherData.subjects.map((subject) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              subject,
              style: const TextStyle(
                color: AppTheme.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildClassesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.class_, size: 20, color: AppTheme.blue600),
            const SizedBox(width: AppTheme.smallSpacing),
            const Text(
              'Assigned Classes',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: teacherData.classes.map((className) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.blue100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.blue200),
            ),
            child: Text(
              className,
              style: TextStyle(
                color: AppTheme.blue800,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    final menuItems = [
      MenuItemData(Icons.edit, 'Edit Profile', 'Update personal information'),
      MenuItemData(Icons.lock, 'Change Password', 'Update your password'),
      MenuItemData(Icons.notifications, 'Notifications', 'Manage notification settings'),
      MenuItemData(Icons.language, 'Language', 'Change app language'),
      MenuItemData(Icons.help, 'Help & Support', 'Get help and support'),
      MenuItemData(Icons.logout, 'Logout', 'Sign out of your account', isLogout: true),
    ];

    return Container(
      margin: const EdgeInsets.all(AppTheme.mediumSpacing),
      child: Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Column(
          children: menuItems.map((item) => _buildMenuItem(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MenuItemData item) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: item.isLogout ? Colors.red.withOpacity(0.1) : AppTheme.blue50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item.icon,
          color: item.isLogout ? Colors.red : AppTheme.blue600,
          size: 20,
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: item.isLogout ? Colors.red : Colors.black87,
        ),
      ),
      subtitle: Text(
        item.subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
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
          backgroundColor: AppTheme.primaryBlue,
        ),
      );
    }
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        title: const Text('Edit Profile'),
        content: const Text('Profile editing functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Save', style: TextStyle(color: AppTheme.white)),
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
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
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
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout', style: TextStyle(color: AppTheme.white)),
          ),
        ],
      ),
    );
  }
}

class TeacherProfile {
  final String name;
  final String email;
  final String phone;
  final String employeeId;
  final String department;
  final String designation;
  final String experience;
  final String qualification;
  final String address;
  final String joinDate;
  final List<String> subjects;
  final List<String> classes;
  final int totalStudents;
  final int completedLessons;
  final double attendanceRate;
  final String profileImageUrl;

  TeacherProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.employeeId,
    required this.department,
    required this.designation,
    required this.experience,
    required this.qualification,
    required this.address,
    required this.joinDate,
    required this.subjects,
    required this.classes,
    required this.totalStudents,
    required this.completedLessons,
    required this.attendanceRate,
    required this.profileImageUrl,
  });
}

class MenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLogout;

  MenuItemData(this.icon, this.title, this.subtitle, {this.isLogout = false});
}