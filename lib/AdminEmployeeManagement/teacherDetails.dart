import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/employeeModel.dart';

class TeacherDetailsPage extends StatelessWidget {
  final Employee teacher;

  const TeacherDetailsPage({Key? key, required this.teacher}) : super(key: key);

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
            child: Padding(
              padding: AppThemeResponsiveness.getScreenPadding(context),
              child: Column(
                children: [
                  _buildHeader(context),
                  SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                  _buildDetailsCard(context),
                  SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'teacher_icon',
          child: Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getResponsiveSize(context, 20, 24, 28)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              size: AppThemeResponsiveness.getResponsiveIconSize(context, 45),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        Text(
          'Teacher Details',
          style: AppThemeResponsiveness.getHeadlineTextStyle(context).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeResponsiveness.getResponsiveSize(context, 16, 20, 24),
            vertical: AppThemeResponsiveness.getResponsiveSize(context, 8, 10, 12),
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Text(
            'Complete teacher information',
            style: AppThemeResponsiveness.getSubTitleTextStyle(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: AppThemeResponsiveness.getMaxWidth(context),
      ),
      child: Card(
        elevation: AppThemeResponsiveness.getCardElevation(context) + 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context) + 4),
        ),
        shadowColor: Colors.black.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context) + 4),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey[50]!,
              ],
            ),
          ),
          child: Padding(
            padding: AppThemeResponsiveness.getCardPadding(context),
            child: Column(
              children: [
                _buildProfileHeader(context),
                SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                _buildPersonalInfoSection(context),
                SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                _buildContactInfoSection(context),
                SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getResponsiveSize(context, 24, 28, 32)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppThemeColor.blue50, AppThemeColor.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Hero(
            tag: 'teacher_avatar_${teacher.id}',
            child: CircleAvatar(
              radius: AppThemeResponsiveness.getResponsiveSize(context, 45, 55, 65),
              backgroundColor: AppThemeColor.primaryBlue,
              child: Text(
                teacher.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: AppThemeColor.white,
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          Text(
            teacher.name,
            style: AppThemeResponsiveness.getTitleTextStyle(context).copyWith(
              fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 22),
              fontWeight: FontWeight.bold,
              color: AppThemeColor.blue800,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppThemeResponsiveness.getResponsiveSize(context, 12, 16, 20),
              vertical: AppThemeResponsiveness.getResponsiveSize(context, 6, 8, 10),
            ),
            decoration: BoxDecoration(
              color: AppThemeColor.blue600.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppThemeColor.blue600.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              teacher.role,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 14),
                color: AppThemeColor.blue600,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader(
          context,
          'Personal Information',
          Icons.person_rounded,
          Colors.blue,
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        _buildInfoCard(
          context,
          'Teacher ID',
          teacher.id,
          Icons.badge_rounded,
          delay: 100,
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        _buildInfoCard(
          context,
          'Department',
          teacher.department,
          Icons.school_rounded,
          delay: 200,
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader(
          context,
          'Contact Information',
          Icons.contact_phone_rounded,
          Colors.green,
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        _buildInfoCard(
          context,
          'Phone',
          teacher.phone,
          Icons.phone_rounded,
          delay: 300,
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        _buildInfoCard(
          context,
          'Email',
          teacher.email,
          Icons.email_rounded,
          delay: 400,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppThemeResponsiveness.getResponsiveSize(context, 14, 16, 18),
        horizontal: AppThemeResponsiveness.getResponsiveSize(context, 18, 20, 22),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 12)),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: AppThemeResponsiveness.getResponsiveIconSize(context, 22),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
          Text(
            title,
            style: AppThemeResponsiveness.getTitleTextStyle(context).copyWith(
              fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 17),
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context,
      String title,
      String value,
      IconData icon, {
        int delay = 0,
      }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, animationValue, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - animationValue)),
          child: Opacity(
            opacity: animationValue,
            child: Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getResponsiveSize(context, 16, 18, 20)),
              decoration: BoxDecoration(
                color: AppThemeColor.white,
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 12)),
                border: Border.all(color: AppThemeColor.blue200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppThemeResponsiveness.getResponsiveSize(context, 10, 12, 14)),
                    decoration: BoxDecoration(
                      color: AppThemeColor.blue50,
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 10)),
                    ),
                    child: Icon(
                      icon,
                      color: AppThemeColor.primaryBlue,
                      size: AppThemeResponsiveness.getResponsiveIconSize(context, 20),
                    ),
                  ),
                  SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                            fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                            color: AppThemeColor.blue600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          value,
                          style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                            fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
                            color: AppThemeColor.blue800,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: _getResponsiveButtonLayout(context),
        );
      },
    );
  }

  Widget _getResponsiveButtonLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    if (isSmallScreen) {
      // Stack buttons vertically on small screens
      return Column(
        children: [
          _buildCallButton(context),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          _buildEmailButton(context),
        ],
      );
    } else {
      // Place buttons side by side on larger screens
      return Row(
        children: [
          Expanded(child: _buildCallButton(context)),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(child: _buildEmailButton(context)),
        ],
      );
    }
  }

  Widget _buildCallButton(BuildContext context) {
    return Container(
      height: AppThemeResponsiveness.getButtonHeight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => _makePhoneCall(teacher.phone),
        icon: Icon(
          Icons.phone_rounded,
          size: AppThemeResponsiveness.getResponsiveIconSize(context, 20),
        ),
        label: Text(
          'Call',
          style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: AppThemeColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return Container(
      height: AppThemeResponsiveness.getButtonHeight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: AppThemeColor.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => _sendEmail(teacher.email),
        icon: Icon(
          Icons.email_rounded,
          size: AppThemeResponsiveness.getResponsiveIconSize(context, 20),
        ),
        label: Text(
          'Email',
          style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppThemeColor.primaryBlue,
          foregroundColor: AppThemeColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _makePhoneCall(String phone) {
    // Add phone call functionality here
    print('Calling: $phone');
  }

  void _sendEmail(String email) {
    // Add email functionality here
    print('Sending email to: $email');
  }
}