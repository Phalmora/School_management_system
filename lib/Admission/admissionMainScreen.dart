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
            child: Padding(
              padding: EdgeInsets.all(AppTheme.defaultSpacing),
              child: Column(
                children: [
                  Image.asset(
                    'assets/school.png',
                    width: AppTheme.logoSize,
                    height: AppTheme.logoSize,
                  ),
                  SizedBox(height: AppTheme.smallSpacing),
                  Text(
                    'Student Admission',
                    style: AppTheme.FontStyle,
                  ),
                  SizedBox(height: AppTheme.defaultSpacing),
                  Card(
                    elevation: AppTheme.cardElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.defaultSpacing),
                      child: Column(
                        children: [
                          Text(
                            'Complete your admission in simple steps',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.blue600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppTheme.extraLargeSpacing),
                          _buildStepCard(
                            context,
                            icon: Icons.person,
                            title: 'Basic Information',
                            subtitle: 'Student details & academic info',
                            onTap: () => Navigator.pushNamed(context, '/admission-basic'),
                          ),
                          SizedBox(height: AppTheme.mediumSpacing),
                          _buildStepCard(
                            context,
                            icon: Icons.family_restroom,
                            title: 'Parent/Guardian Details',
                            subtitle: 'Family information',
                            onTap: () => Navigator.pushNamed(context, '/admission-parent'),
                          ),
                          SizedBox(height: AppTheme.mediumSpacing),
                          _buildStepCard(
                            context,
                            icon: Icons.location_on,
                            title: 'Contact & Address',
                            subtitle: 'Contact details & address',
                            onTap: () => Navigator.pushNamed(context, '/admission-contact'),
                          ),
                          SizedBox(height: AppTheme.mediumSpacing),
                          _buildStepCard(
                            context,
                            icon: Icons.upload_file,
                            title: 'Document Upload',
                            subtitle: 'Required certificates & photos',
                            onTap: () => Navigator.pushNamed(context, '/admission-documents'),
                          ),
                          SizedBox(height: AppTheme.extraLargeSpacing),
                          _buildAnimatedButton(
                            context,
                            text: 'Start Application',
                            onPressed: () => Navigator.pushNamed(context, '/admission-basic'),
                          ),
                          SizedBox(height: AppTheme.defaultSpacing),
                          _buildAnimatedButton(
                              context,
                              text: 'Check admission status',
                              onPressed: () => {Navigator.pushNamed(context, '/check-admission-status')}),
                          SizedBox(height: AppTheme.defaultSpacing),
                          _buildAnimatedButton(
                            context,
                              text: 'Signup',
                              onPressed: () => {Navigator.pushNamed(context, '/main-signup')}),
                          SizedBox(height: AppTheme.defaultSpacing),
                          _buildAnimatedButton(
                            context,
                            text: 'Learn More',
                            onPressed: () => {Navigator.pushNamed(context, '/school-details')},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.blue600.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.blue600),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAnimatedButton(BuildContext context, {
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: AppTheme.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.blue600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
        child: Text(
          text,
          style: AppTheme.buttonTextStyle,
        ),
      ),
    );
  }
}