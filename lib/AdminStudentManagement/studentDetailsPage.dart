import 'package:flutter/material.dart';
import 'package:school/AdminStudentManagement/studentModel.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

class StudentDetailsPage extends StatelessWidget {
  final Student student;

  const StudentDetailsPage({Key? key, required this.student}) : super(key: key);

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildDetailCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      elevation: AppThemeResponsiveness.getCardElevation(context),
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getSmallSpacing(context)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppThemeColor.primaryBlue,
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppThemeResponsiveness.getInputLabelStyle(context).copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                  Text(
                    value,
                    style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: AppThemeResponsiveness.getMaxWidth(context),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
        ),
        padding: EdgeInsets.symmetric(
          vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getHeaderIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Flexible(
              child: Text(
                'Student Details',
                style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(
                    context,
                    AppThemeResponsiveness.getSectionTitleStyle(context).fontSize! + 4,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: AppThemeResponsiveness.getMaxWidth(context),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
      ),
      child: Card(
        elevation: AppThemeResponsiveness.getCardElevation(context) * 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppThemeResponsiveness.getLargeSpacing(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
            gradient: LinearGradient(
              colors: [AppThemeColor.primaryBlue, AppThemeColor.primaryBlue.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: AppThemeResponsiveness.getResponsiveSize(context, 35, 45, 55),
                backgroundColor: Colors.white,
                child: Text(
                  student.name.substring(0, 1).toUpperCase(),
                  style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                    fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 32),
                    fontWeight: FontWeight.bold,
                    color: AppThemeColor.primaryBlue,
                  ),
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Text(
                student.name,
                style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 24),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                student.className,
                style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppThemeResponsiveness.getMediumSpacing(context),
                  vertical: AppThemeResponsiveness.getSmallSpacing(context),
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(student.admissionStatus).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                  border: Border.all(
                    color: _getStatusColor(student.admissionStatus),
                    width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                  ),
                ),
                child: Text(
                  student.admissionStatus,
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: AppThemeResponsiveness.getMaxWidth(context),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
      ),
      child: Card(
        elevation: AppThemeResponsiveness.getCardElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Information',
                style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                  color: AppThemeColor.primaryBlue,
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

              _buildDetailCard(context, 'Student ID', student.id, Icons.badge),
              _buildDetailCard(context, 'Email Address', student.email, Icons.email),
              _buildDetailCard(context, 'Phone Number', student.phone, Icons.phone),
              _buildDetailCard(
                  context,
                  'Date of Birth',
                  '${student.dateOfBirth.day}/${student.dateOfBirth.month}/${student.dateOfBirth.year}',
                  Icons.cake
              ),
              _buildDetailCard(
                  context,
                  'Age',
                  '${_calculateAge(student.dateOfBirth)} years old',
                  Icons.person
              ),
              _buildDetailCard(context, 'Class', student.className, Icons.school),
              _buildDetailCard(
                  context,
                  'Address',
                  student.address.isEmpty ? 'Not provided' : student.address,
                  Icons.location_on
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: AppThemeResponsiveness.getMaxWidth(context),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
      ),
      child: AppThemeResponsiveness.isDesktop(context) || AppThemeResponsiveness.isTablet(context)
          ? Row(
        children: [
          Expanded(
            child: _buildEditButton(context),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: _buildBackButton(context),
          ),
        ],
      )
          : Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: _buildEditButton(context),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          SizedBox(
            width: double.infinity,
            child: _buildBackButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      height: AppThemeResponsiveness.getButtonHeight(context),
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Edit functionality can be added here'),
              backgroundColor: Colors.green,
            ),
          );
        },
        icon: Icon(
          Icons.edit,
          size: AppThemeResponsiveness.getIconSize(context) * 0.8,
        ),
        label: Text(
          'Edit Student',
          style: AppThemeResponsiveness.getButtonTextStyle(context),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppThemeColor.primaryBlue,
          foregroundColor: Colors.white,
          elevation: AppThemeResponsiveness.getButtonElevation(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      height: AppThemeResponsiveness.getButtonHeight(context),
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: AppThemeResponsiveness.getIconSize(context) * 0.8,
        ),
        label: Text(
          'Back to List',
          style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppThemeColor.primaryBlue,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppThemeColor.primaryBlue,
          side: BorderSide(
            color: AppThemeColor.primaryBlue,
            width: AppThemeResponsiveness.getFocusedBorderWidth(context),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
        ),
      ),
    );
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
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              bottom: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              left: AppThemeResponsiveness.getSmallSpacing(context),
              right: AppThemeResponsiveness.getSmallSpacing(context),
            ),
            child: Column(
              children: [
                // Header
                _buildHeader(context),

                // Profile Card
                _buildProfileCard(context),

                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                // Details Section
                _buildDetailsSection(context),

                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                // Action Buttons
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}