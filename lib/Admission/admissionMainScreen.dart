import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.defaultSpacing,
                vertical: AppTheme.smallSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hero Section with Logo and Welcome
                  _buildHeroSection(),

                  SizedBox(height: AppTheme.extraLargeSpacing),

                  // Quick Actions Card
                  _buildQuickActionsCard(context),

                  SizedBox(height: AppTheme.extraLargeSpacing),

                  // Admission Process Section
                  _buildAdmissionProcessSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        // Enhanced Logo Container
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Image.asset(
            'assets/school.png',
            width: AppTheme.logoSize * 0.8,
            height: AppTheme.logoSize * 0.8,
          ),
        ),

        SizedBox(height: AppTheme.mediumSpacing),

        // Welcome Text
        Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 4),

        Text(
          'Student Admission Portal',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 8),

        Text(
          'Your educational journey starts here',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.blue600,
                letterSpacing: -0.3,
              ),
            ),

            SizedBox(height: 4),

            Text(
              'Access your account or check status',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    context,
                    icon: Icons.search_rounded,
                    text: 'Check Status',
                    color: Colors.green,
                    onPressed: () => Navigator.pushNamed(context, '/check-admission-status'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionButton(
                    context,
                    icon: Icons.login_rounded,
                    text: 'Sign In',
                    color: AppTheme.blue600,
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            _buildAnimatedButton(
              context,
              text: 'Create New Account',
              isPrimary: false,
              onPressed: () => Navigator.pushNamed(context, '/main-signup'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
      BuildContext context, {
        required IconData icon,
        required String text,
        required Color color,
        required VoidCallback onPressed,
      }) {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withOpacity(0.2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionProcessSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.blue600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: AppTheme.blue600,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admission Process',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blue600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'Complete in 4 simple steps',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Process Steps
            _buildProcessStep(
              context,
              stepNumber: 1,
              icon: Icons.person_rounded,
              title: 'Basic Information',
              subtitle: 'Student details & academic background',
              isCompleted: false,
              onTap: () => Navigator.pushNamed(context, '/admission-basic'),
            ),

            _buildStepConnector(),

            _buildProcessStep(
              context,
              stepNumber: 2,
              icon: Icons.family_restroom_rounded,
              title: 'Parent/Guardian Details',
              subtitle: 'Family information & emergency contacts',
              isCompleted: false,
              onTap: () => Navigator.pushNamed(context, '/admission-parent'),
            ),

            _buildStepConnector(),

            _buildProcessStep(
              context,
              stepNumber: 3,
              icon: Icons.location_on_rounded,
              title: 'Contact & Address',
              subtitle: 'Residential & correspondence address',
              isCompleted: false,
              onTap: () => Navigator.pushNamed(context, '/admission-contact'),
            ),

            _buildStepConnector(),

            _buildProcessStep(
              context,
              stepNumber: 4,
              icon: Icons.upload_file_rounded,
              title: 'Document Upload',
              subtitle: 'Certificates, photos & required documents',
              isCompleted: false,
              onTap: () => Navigator.pushNamed(context, '/admission-documents'),
            ),

            SizedBox(height: 32),

            // Action Buttons
            _buildAnimatedButton(
              context,
              text: 'Start Your Application',
              isPrimary: true,
              icon: Icons.arrow_forward_rounded,
              onPressed: () => Navigator.pushNamed(context, '/admission-basic'),
            ),

            SizedBox(height: 12),

            _buildAnimatedButton(
              context,
              text: 'Learn More About School',
              isPrimary: false,
              icon: Icons.info_outline_rounded,
              onPressed: () => Navigator.pushNamed(context, '/school-details'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessStep(
      BuildContext context, {
        required int stepNumber,
        required IconData icon,
        required String title,
        required String subtitle,
        required bool isCompleted,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Step Number Circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : AppTheme.blue600,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isCompleted ? Colors.green : AppTheme.blue600).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: isCompleted
                    ? Icon(Icons.check_rounded, color: Colors.white, size: 20)
                    : Text(
                  stepNumber.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            SizedBox(width: 16),

            // Icon Container
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.blue600.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppTheme.blue600,
                size: 20,
              ),
            ),

            SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepConnector() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
      child: Container(
        width: 2,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(
      BuildContext context, {
        required String text,
        required VoidCallback onPressed,
        bool isPrimary = true,
        IconData? icon,
      }) {
    return Container(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.blue600 : Colors.white,
          foregroundColor: isPrimary ? Colors.white : AppTheme.blue600,
          elevation: isPrimary ? 8 : 0,
          shadowColor: isPrimary ? AppTheme.blue600.withOpacity(0.3) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary ? BorderSide.none : BorderSide(
              color: AppTheme.blue600.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}