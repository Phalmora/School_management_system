import 'package:flutter/material.dart';
import 'package:school/customWidgets/button.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/mainFooter.dart';

class AdmissionMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppThemeResponsiveness.getMaxWidth(context),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.isMobile(context)
                    ? 0
                    : (AppThemeResponsiveness.getScreenWidth(context) - AppThemeResponsiveness.getMaxWidth(context)) / 2,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
                  vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Hero Section with Logo and Welcome
                    _buildHeroSection(context),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Quick Actions Card
                    _buildQuickActionsCard(context),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                    Text(
                      'Student Admission Portal',
                      style: TextStyle(
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 28.0),
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
                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Admission Process Section
                    _buildAdmissionProcessSection(context),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                    DashboardFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      children: [
        // Enhanced Logo Container with minimal padding
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: AppThemeResponsiveness.isSmallPhone(context)
                    ? 15
                    : AppThemeResponsiveness.isMediumPhone(context)
                    ? 20
                    : AppThemeResponsiveness.isTablet(context)
                    ? 25
                    : 30,
                offset: Offset(
                    0,
                    AppThemeResponsiveness.isSmallPhone(context)
                        ? 6
                        : AppThemeResponsiveness.isMediumPhone(context)
                        ? 8
                        : 12
                ),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/school.png',
              width: AppThemeResponsiveness.getWelcomeAvatarIconSize(context) * 3.0,
              height: AppThemeResponsiveness.getWelcomeAvatarIconSize(context) * 3.0,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

        // Welcome Text with responsive typography
        Text(
          'Welcome to',
          style: TextStyle(
            fontSize: AppThemeResponsiveness.getTabFontSize(context),
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),

        // Main Title with proper responsive sizing
        Text(
          'Royal Public School',
          style: TextStyle(
            fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 25.0),
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
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),

        // Subtitle with responsive sizing
        Text(
          'Your educational journey starts here',
          style: TextStyle(
            fontSize: AppThemeResponsiveness.isSmallPhone(context)
                ? 12.0
                : AppThemeResponsiveness.isMediumPhone(context)
                ? 14.0
                : AppThemeResponsiveness.isLargePhone(context)
                ? 16.0
                : AppThemeResponsiveness.isTablet(context)
                ? 18.0
                : 20.0,
            color: Colors.white.withOpacity(0.85),
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppThemeResponsiveness.getCardElevation(context) * 3,
            offset: Offset(0, AppThemeResponsiveness.getCardElevation(context)),
          ),
        ],
      ),
      child: Padding(
        padding: AppThemeResponsiveness.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.blue600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                  ),
                  child: Icon(
                    Icons.flash_on_rounded,
                    color: AppThemeColor.blue600,
                    size: AppThemeResponsiveness.getQuickStatsIconSize(context),
                  ),
                ),
                SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                          color: AppThemeColor.blue600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Access your account or check status',
                        style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context) + 8),

            // Responsive Button Layout using SecondaryButton
            _buildResponsiveActionButtons(context),

            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),

            // Create Account Button using SecondaryButton
            SecondaryButton(
              title: 'Create New Account',
              color: AppThemeColor.blue600,
              icon: Icon(
                Icons.person_add_rounded,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                color: AppThemeColor.blue600,
              ),
              onPressed: () => Navigator.pushNamed(context, '/main-signup'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveActionButtons(BuildContext context) {
    // Use grid layout for better responsiveness
    if (AppThemeResponsiveness.isSmallPhone(context)) {
      return Column(
        children: [
          SecondaryButton(
            title: 'Check Status',
            color: Colors.green,
            icon: Icon(
              Icons.search_rounded,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              color: Colors.green,
            ),
            onPressed: () => Navigator.pushNamed(context, '/check-admission-status'),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          SecondaryButton(
            title: 'Sign In',
            color: AppThemeColor.blue600,
            icon: Icon(
              Icons.login_rounded,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              color: AppThemeColor.blue600,
            ),
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: SecondaryButton(
              title: 'Check',
              color: Colors.green,
              icon: Icon(
                Icons.search_rounded,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                color: Colors.green,
              ),
              onPressed: () => Navigator.pushNamed(context, '/check-admission-status'),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getQuickStatsSpacing(context)),
          Expanded(
            child: SecondaryButton(
              title: 'Sign In',
              color: AppThemeColor.blue600,
              icon: Icon(
                Icons.login_rounded,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                color: AppThemeColor.blue600,
              ),
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildAdmissionProcessSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppThemeResponsiveness.getCardElevation(context) * 3,
            offset: Offset(0, AppThemeResponsiveness.getCardElevation(context)),
          ),
        ],
      ),
      child: Padding(
        padding: AppThemeResponsiveness.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.blue600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: AppThemeColor.blue600,
                    size: AppThemeResponsiveness.getQuickStatsIconSize(context),
                  ),
                ),
                SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admission Process',
                        style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                          color: AppThemeColor.blue600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Complete in 4 simple steps',
                        style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context) + 8),

            // Process Steps with responsive layout
            _buildResponsiveProcessSteps(context),

            SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

            // Action Buttons using Custom Buttons
            PrimaryButton(
              title: 'Start Your Application',
              icon: Icon(
                Icons.arrow_forward_rounded,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, '/admission-basic'),
            ),

            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),

            SecondaryButton(
              title: 'Learn More About School',
              color: AppThemeColor.blue600,
              icon: Icon(
                Icons.info_outline_rounded,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                color: AppThemeColor.blue600,
              ),
              onPressed: () => Navigator.pushNamed(context, '/school-details'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveProcessSteps(BuildContext context) {
    final steps = [
      ProcessStepData(
        stepNumber: 1,
        icon: Icons.person_rounded,
        title: 'Basic Information',
        subtitle: 'Student details & academic background',
        onTap: () => Navigator.pushNamed(context, '/admission-basic'),
      ),
      ProcessStepData(
        stepNumber: 2,
        icon: Icons.family_restroom_rounded,
        title: 'Parent/Guardian Details',
        subtitle: 'Family information & emergency contacts',
        onTap: () => Navigator.pushNamed(context, '/admission-parent'),
      ),
      ProcessStepData(
        stepNumber: 3,
        icon: Icons.location_on_rounded,
        title: 'Contact & Address',
        subtitle: 'Residential & correspondence address',
        onTap: () => Navigator.pushNamed(context, '/admission-contact'),
      ),
      ProcessStepData(
        stepNumber: 4,
        icon: Icons.upload_file_rounded,
        title: 'Document Upload',
        subtitle: 'Certificates, photos & required documents',
        onTap: () => Navigator.pushNamed(context, '/admission-documents'),
      ),
    ];

    return Column(
      children: List.generate(steps.length, (index) {
        return Column(
          children: [
            _buildProcessStep(context, steps[index]),
            if (index < steps.length - 1) _buildStepConnector(context),
          ],
        );
      }),
    );
  }

  Widget _buildProcessStep(BuildContext context, ProcessStepData stepData) {
    return GestureDetector(
      onTap: stepData.onTap,
      child: Container(
        padding: EdgeInsets.all(AppThemeResponsiveness.getActivityItemPadding(context)),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) + 4),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Step Number Circle with responsive sizing
            Container(
              width: AppThemeResponsiveness.getDashboardCardIconSize(context),
              height: AppThemeResponsiveness.getDashboardCardIconSize(context),
              decoration: BoxDecoration(
                color: stepData.isCompleted ? Colors.green : AppThemeColor.blue600,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (stepData.isCompleted ? Colors.green : AppThemeColor.blue600).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: stepData.isCompleted
                    ? Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: AppThemeResponsiveness.getDashboardCardIconSize(context) * 0.6,
                )
                    : Text(
                  stepData.stepNumber.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).fontSize! + 2,
                  ),
                ),
              ),
            ),

            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),

            // Icon Container
            Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getActivityIconPadding(context)),
              decoration: BoxDecoration(
                color: AppThemeColor.blue600.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getSmallSpacing(context)),
              ),
              child: Icon(
                stepData.icon,
                color: AppThemeColor.blue600,
                size: AppThemeResponsiveness.getActivityIconSize(context),
              ),
            ),

            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepData.title,
                    style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                      fontSize: AppThemeResponsiveness.getDashboardCardTitleStyle(context).fontSize! - 2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    stepData.subtitle,
                    style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) / 2),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).fontSize! + 2,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepConnector(BuildContext context) {
    double leftPadding = AppThemeResponsiveness.getDashboardCardIconSize(context) / 2 +
        AppThemeResponsiveness.getActivityItemPadding(context) - 1;

    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding,
        top: AppThemeResponsiveness.getSmallSpacing(context) / 2,
        bottom: AppThemeResponsiveness.getSmallSpacing(context) / 2,
      ),
      child: Container(
        width: 2,
        height: AppThemeResponsiveness.getMediumSpacing(context),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

class ProcessStepData {
  final int stepNumber;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback onTap;

  ProcessStepData({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    required this.onTap,
  });
}