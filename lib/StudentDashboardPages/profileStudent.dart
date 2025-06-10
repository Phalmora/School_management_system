import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/customWidgets/appBar.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // 5% of screen width
              vertical: screenHeight * 0.02,  // 2% of screen height
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top spacing
                SizedBox(height: screenHeight * 0.03),

                // Welcome section
                _buildWelcomeSection(context, screenWidth),

                // Spacing between sections
                SizedBox(height: screenHeight * 0.04),

                // Dashboard grid
                Expanded(
                  child: _buildDashboardGrid(context, screenWidth, isTablet),
                ),

                // Bottom spacing
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Profile',
            style: TextStyle(
              fontSize: screenWidth * 0.06, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Manage your account settings and preferences',
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardGrid(BuildContext context, double screenWidth, bool isTablet) {
    final items = [
      _DashboardItem(
        'View Personal Info',
        Icons.person_outline,
        Colors.purple,
            () => Navigator.pushNamed(context, '/profile-info'),
      ),
      _DashboardItem(
        'Privacy & Security',
        Icons.security_outlined,
        Colors.blue,
            () => Navigator.pushNamed(context, '/privacy-security'),
      ),
      _DashboardItem(
        'Performance Summary',
        Icons.show_chart,
        Colors.teal,
            () => Navigator.pushNamed(context, '/privacy-security'),
      ),
      _DashboardItem(
        'Admission Form Page',
        Icons.school_outlined,
        Colors.red,
            () => Navigator.pushNamed(context, '/admission-main'),
      ),
      _DashboardItem(
        'Upload Missing Documents',
        Icons.upload,
        Colors.yellow,
            () => Navigator.pushNamed(context, '/admission-main'),
      ),
      _DashboardItem(
        'Change Password',
        Icons.lock_outline,
        Colors.green,
            () => Navigator.pushNamed(context, '/change-password'),
      ),
      _DashboardItem(
        'Forget Password',
        Icons.lock_reset,
        Colors.orange,
            () => Navigator.pushNamed(context, '/forget-password'),
      ),

    ];

    return GridView.builder(
      physics: BouncingScrollPhysics(), // Better scroll physics
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2, // Responsive grid
        crossAxisSpacing: screenWidth * 0.04,
        mainAxisSpacing: screenWidth * 0.04,
        childAspectRatio: isTablet ? 1.1 : 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _buildDashboardCard(
        items[index],
        screenWidth,
        index,
      ),
    );
  }

  Widget _buildDashboardCard(_DashboardItem item, double screenWidth, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)), // Staggered animation
      curve: Curves.easeOutBack,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Add haptic feedback
            HapticFeedback.lightImpact();
            item.onTap();
          },
          borderRadius: BorderRadius.circular(24),
          splashColor: item.color.withOpacity(0.1),
          highlightColor: item.color.withOpacity(0.05),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon container with gradient
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            item.color.withOpacity(0.1),
                            item.color.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: item.color.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        item.icon,
                        size: screenWidth * 0.08, // Responsive icon size
                        color: item.color,
                      ),
                    ),

                    SizedBox(height: screenWidth * 0.03),

                    // Title text
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: screenWidth * 0.02),

                    // Subtle arrow indicator
                    Icon(
                      Icons.arrow_forward_ios,
                      size: screenWidth * 0.03,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),

                // Badge if present
                if (item.badge != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade400, Colors.red.shade600],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        item.badge!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

class _DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? badge;

  _DashboardItem(this.title, this.icon, this.color, this.onTap, {this.badge});
}

