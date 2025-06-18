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
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: AppTheme.isMobile(context)
                    ? 0
                    : (AppTheme.getScreenWidth(context) - AppTheme.getMaxWidth(context)) / 2,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.getDashboardHorizontalPadding(context),
                  vertical: AppTheme.getDashboardVerticalPadding(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Hero Section with Logo and Welcome
                    _buildHeroSection(context),

                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                    // Quick Actions Card
                    _buildQuickActionsCard(context),

                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                    // Admission Process Section
                    _buildAdmissionProcessSection(context),

                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                    // Info Cards Section (New)
                    _buildInfoCardsSection(context),

                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                    _buildFooter(context),
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
        // Enhanced Logo Container with responsive sizing
        Container(
          padding: EdgeInsets.all(AppTheme.getWelcomeSectionPadding(context)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: AppTheme.isSmallPhone(context) ? 15 :
                AppTheme.isMediumPhone(context) ? 20 :
                AppTheme.isTablet(context) ? 25 : 30,
                offset: Offset(0, AppTheme.isSmallPhone(context) ? 6 :
                AppTheme.isMediumPhone(context) ? 8 : 12),
              ),
            ],
          ),
          child: Image.asset(
            'assets/school.png',
            width: AppTheme.getWelcomeAvatarIconSize(context) * 1.8,
            height: AppTheme.getWelcomeAvatarIconSize(context) * 1.8,
          ),
        ),

        SizedBox(height: AppTheme.getMediumSpacing(context)),

        // Welcome Text with responsive typography
        Text(
          'Welcome to',
          style: TextStyle(
            fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
            AppTheme.isMediumPhone(context) ? 14.0 :
            AppTheme.isLargePhone(context) ? 16.0 :
            AppTheme.isTablet(context) ? 18.0 : 20.0,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: AppTheme.getSmallSpacing(context) / 2),

        // Main Title with proper responsive sizing
        Text(
          'Student Admission Portal',
          style: TextStyle(
            fontSize: AppTheme.isSmallPhone(context) ? 20.0 :
            AppTheme.isMediumPhone(context) ? 24.0 :
            AppTheme.isLargePhone(context) ? 28.0 :
            AppTheme.isTablet(context) ? 34.0 : 40.0,
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

        SizedBox(height: AppTheme.getSmallSpacing(context)),

        // Subtitle with responsive sizing
        Text(
          'Your educational journey starts here',
          style: TextStyle(
            fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
            AppTheme.isMediumPhone(context) ? 14.0 :
            AppTheme.isLargePhone(context) ? 16.0 :
            AppTheme.isTablet(context) ? 18.0 : 20.0,
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
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppTheme.getCardElevation(context) * 3,
            offset: Offset(0, AppTheme.getCardElevation(context)),
          ),
        ],
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppTheme.getQuickStatsIconPadding(context)),
                  decoration: BoxDecoration(
                    color: AppTheme.blue600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                  ),
                  child: Icon(
                    Icons.flash_on_rounded,
                    color: AppTheme.blue600,
                    size: AppTheme.getQuickStatsIconSize(context),
                  ),
                ),
                SizedBox(width: AppTheme.getMediumSpacing(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: AppTheme.getDashboardCardTitleStyle(context).copyWith(
                          color: AppTheme.blue600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Access your account or check status',
                        style: AppTheme.getDashboardCardSubtitleStyle(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppTheme.getMediumSpacing(context) + 8),

            // Responsive Button Layout
            _buildResponsiveActionButtons(context),

            SizedBox(height: AppTheme.getSmallSpacing(context)),

            // Create Account Button
            _buildAnimatedButton(
              context,
              text: 'Create New Account',
              isPrimary: false,
              icon: Icons.person_add_rounded,
              onPressed: () => Navigator.pushNamed(context, '/main-signup'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveActionButtons(BuildContext context) {
    final buttons = [
      _ActionButtonData(
        icon: Icons.search_rounded,
        text: 'Check Status',
        color: Colors.green,
        onPressed: () => Navigator.pushNamed(context, '/check-admission-status'),
      ),
      _ActionButtonData(
        icon: Icons.login_rounded,
        text: 'Sign In',
        color: AppTheme.blue600,
        onPressed: () => Navigator.pushNamed(context, '/login'),
      ),
    ];

    // Use grid layout for better responsiveness
    if (AppTheme.isSmallPhone(context)) {
      return Column(
        children: buttons
            .map((button) => Container(
          margin: EdgeInsets.only(bottom: AppTheme.getSmallSpacing(context)),
          child: _buildQuickActionButton(context, button),
        ))
            .toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppTheme.isMediumPhone(context) ? 1 : 2,
          crossAxisSpacing: AppTheme.getQuickStatsSpacing(context),
          mainAxisSpacing: AppTheme.getQuickStatsSpacing(context),
          childAspectRatio: AppTheme.isMediumPhone(context) ? 6.0 : 4.5,
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) => _buildQuickActionButton(context, buttons[index]),
      );
    }
  }

  Widget _buildQuickActionButton(BuildContext context, _ActionButtonData buttonData) {
    return Container(
      height: AppTheme.getButtonHeight(context) - 5,
      child: ElevatedButton(
        onPressed: buttonData.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonData.color.withOpacity(0.1),
          foregroundColor: buttonData.color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
            side: BorderSide(color: buttonData.color.withOpacity(0.2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(buttonData.icon, size: AppTheme.getQuickStatsIconSize(context) * 0.75),
            SizedBox(width: AppTheme.getSmallSpacing(context) / 2),
            Flexible(
              child: Text(
                buttonData.text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppTheme.getDashboardCardSubtitleStyle(context).fontSize! + 1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionProcessSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppTheme.getCardElevation(context) * 3,
            offset: Offset(0, AppTheme.getCardElevation(context)),
          ),
        ],
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppTheme.getQuickStatsIconPadding(context)),
                  decoration: BoxDecoration(
                    color: AppTheme.blue600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: AppTheme.blue600,
                    size: AppTheme.getQuickStatsIconSize(context),
                  ),
                ),
                SizedBox(width: AppTheme.getMediumSpacing(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admission Process',
                        style: AppTheme.getDashboardCardTitleStyle(context).copyWith(
                          color: AppTheme.blue600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Complete in 4 simple steps',
                        style: AppTheme.getDashboardCardSubtitleStyle(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppTheme.getMediumSpacing(context) + 8),

            // Process Steps with responsive layout
            _buildResponsiveProcessSteps(context),

            SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

            // Action Buttons
            _buildAnimatedButton(
              context,
              text: 'Start Your Application',
              isPrimary: true,
              icon: Icons.arrow_forward_rounded,
              onPressed: () => Navigator.pushNamed(context, '/admission-basic'),
            ),

            SizedBox(height: AppTheme.getSmallSpacing(context)),

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

  Widget _buildResponsiveProcessSteps(BuildContext context) {
    final steps = [
      _ProcessStepData(
        stepNumber: 1,
        icon: Icons.person_rounded,
        title: 'Basic Information',
        subtitle: 'Student details & academic background',
        onTap: () => Navigator.pushNamed(context, '/admission-basic'),
      ),
      _ProcessStepData(
        stepNumber: 2,
        icon: Icons.family_restroom_rounded,
        title: 'Parent/Guardian Details',
        subtitle: 'Family information & emergency contacts',
        onTap: () => Navigator.pushNamed(context, '/admission-parent'),
      ),
      _ProcessStepData(
        stepNumber: 3,
        icon: Icons.location_on_rounded,
        title: 'Contact & Address',
        subtitle: 'Residential & correspondence address',
        onTap: () => Navigator.pushNamed(context, '/admission-contact'),
      ),
      _ProcessStepData(
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

  Widget _buildProcessStep(BuildContext context, _ProcessStepData stepData) {
    return InkWell(
      onTap: stepData.onTap,
      borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context) + 4),
      child: Container(
        padding: EdgeInsets.all(AppTheme.getActivityItemPadding(context)),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context) + 4),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Step Number Circle with responsive sizing
            Container(
              width: AppTheme.getDashboardCardIconSize(context),
              height: AppTheme.getDashboardCardIconSize(context),
              decoration: BoxDecoration(
                color: stepData.isCompleted ? Colors.green : AppTheme.blue600,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (stepData.isCompleted ? Colors.green : AppTheme.blue600).withOpacity(0.3),
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
                  size: AppTheme.getDashboardCardIconSize(context) * 0.6,
                )
                    : Text(
                  stepData.stepNumber.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppTheme.getDashboardCardSubtitleStyle(context).fontSize! + 2,
                  ),
                ),
              ),
            ),

            SizedBox(width: AppTheme.getMediumSpacing(context)),

            // Icon Container
            Container(
              padding: EdgeInsets.all(AppTheme.getActivityIconPadding(context)),
              decoration: BoxDecoration(
                color: AppTheme.blue600.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.getSmallSpacing(context)),
              ),
              child: Icon(
                stepData.icon,
                color: AppTheme.blue600,
                size: AppTheme.getActivityIconSize(context),
              ),
            ),

            SizedBox(width: AppTheme.getMediumSpacing(context)),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepData.title,
                    style: AppTheme.getDashboardCardTitleStyle(context).copyWith(
                      fontSize: AppTheme.getDashboardCardTitleStyle(context).fontSize! - 2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    stepData.subtitle,
                    style: AppTheme.getDashboardCardSubtitleStyle(context),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Container(
              padding: EdgeInsets.all(AppTheme.getSmallSpacing(context) / 2),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.getDashboardCardSubtitleStyle(context).fontSize! + 2,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepConnector(BuildContext context) {
    double leftPadding = AppTheme.getDashboardCardIconSize(context) / 2 +
        AppTheme.getActivityItemPadding(context) - 1;

    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding,
        top: AppTheme.getSmallSpacing(context) / 2,
        bottom: AppTheme.getSmallSpacing(context) / 2,
      ),
      child: Container(
        width: 2,
        height: AppTheme.getMediumSpacing(context),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildInfoCardsSection(BuildContext context) {
    final infoCards = [
      _InfoCardData(
        icon: Icons.schedule_rounded,
        title: 'Application Deadline',
        subtitle: 'March 31, 2024',
        color: Colors.orange,
      ),
      _InfoCardData(
        icon: Icons.people_rounded,
        title: 'Available Seats',
        subtitle: '250+ Seats',
        color: Colors.green,
      ),
      _InfoCardData(
    icon: Icons.call,
    title: 'Contact Us',
    subtitle: 'Any Query contact us',
    color: Colors.teal,
    ),
      _InfoCardData(
        icon: Icons.support_agent_rounded,
        title: '24/7 Support',
        subtitle: 'Always here to help',
        color: AppTheme.primaryPurple,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppTheme.getDashboardGridCrossAxisCount(context),
        crossAxisSpacing: AppTheme.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppTheme.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: AppTheme.getDashboardGridChildAspectRatio(context) + 0.3,
      ),
      itemCount: infoCards.length,
      itemBuilder: (context, index) => _buildInfoCard(context, infoCards[index]),
    );
  }

  Widget _buildInfoCard(BuildContext context, _InfoCardData cardData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: AppTheme.getCardElevation(context) * 2,
            offset: Offset(0, AppTheme.getCardElevation(context) / 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.getDashboardCardPadding(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.getDashboardCardIconPadding(context)),
              decoration: BoxDecoration(
                color: cardData.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              ),
              child: Icon(
                cardData.icon,
                color: cardData.color,
                size: AppTheme.getDashboardCardIconSize(context),
              ),
            ),
            SizedBox(height: AppTheme.getSmallSpacing(context)),
            Text(
              cardData.title,
              style: AppTheme.getDashboardCardTitleStyle(context).copyWith(
                fontSize: AppTheme.getDashboardCardTitleStyle(context).fontSize! - 2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              cardData.subtitle,
              style: AppTheme.getDashboardCardSubtitleStyle(context),
              textAlign: TextAlign.center,
            ),
          ],
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
      height: AppTheme.getButtonHeight(context) + 2,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.blue600 : Colors.white,
          foregroundColor: isPrimary ? Colors.white : AppTheme.blue600,
          elevation: isPrimary ? AppTheme.getButtonElevation(context) : 0,
          shadowColor: isPrimary ? AppTheme.blue600.withOpacity(0.3) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context) + 4),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
              color: AppTheme.blue600.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppTheme.getIconSize(context) * 0.8),
              SizedBox(width: AppTheme.getSmallSpacing(context)),
            ],
            Text(
              text,
              style: AppTheme.getButtonTextStyle(context).copyWith(
                color: isPrimary ? Colors.white : AppTheme.blue600,
                fontSize: AppTheme.getBodyTextStyle(context).fontSize! + 1,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppTheme.getMediumSpacing(context)),
      child: Column(
        children: [
          Icon(
            Icons.school_rounded,
            color: Colors.white.withOpacity(0.6),
            size: AppTheme.getIconSize(context),
          ),
          SizedBox(height: AppTheme.getSmallSpacing(context)),
          Text(
            '© 2024 School Management System',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: AppTheme.getCaptionTextStyle(context).fontSize! - 1,
            ),
          ),
          Text(
            'Empowering Education Through Technology',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: AppTheme.getCaptionTextStyle(context).fontSize! - 2,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Data Classes
class _ActionButtonData {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  _ActionButtonData({
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });
}

class _ProcessStepData {
  final int stepNumber;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback onTap;

  _ProcessStepData({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    required this.onTap,
  });
}

class _InfoCardData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  _InfoCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}