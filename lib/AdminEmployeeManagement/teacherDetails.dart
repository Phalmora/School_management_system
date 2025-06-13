import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
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
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(AppTheme.defaultSpacing),
                child: Row(
                  children: [
                    SizedBox(width: AppTheme.smallSpacing),
                    Icon(Icons.person, color: AppTheme.white, size: 28),
                    SizedBox(width: AppTheme.mediumSpacing),
                    Text(
                      'Teacher Details',
                      style: AppTheme.FontStyle,
                    ),
                  ],
                ),
              ),

              // Details Card
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(AppTheme.defaultSpacing),
                    child: Column(
                      children: [
                        // Profile Header
                        Container(
                          padding: EdgeInsets.all(AppTheme.defaultSpacing),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.blue50, AppTheme.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: AppTheme.primaryBlue,
                                child: Text(
                                  teacher.name.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: AppTheme.mediumSpacing),
                              Text(
                                teacher.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.blue800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: AppTheme.smallSpacing),
                              Text(
                                teacher.role,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.blue600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: AppTheme.defaultSpacing),

                        // Information Cards
                        _buildInfoCard('Teacher ID', teacher.id, Icons.badge),
                        _buildInfoCard('Department', teacher.department, Icons.school),
                        _buildInfoCard('Phone', teacher.phone, Icons.phone),
                        _buildInfoCard('Email', teacher.email, Icons.email),

                        SizedBox(height: AppTheme.defaultSpacing),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _makePhoneCall(teacher.phone),
                                icon: Icon(Icons.phone),
                                label: Text('Call'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: AppTheme.white,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppTheme.mediumSpacing),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _sendEmail(teacher.email),
                                icon: Icon(Icons.email),
                                label: Text('Email'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryBlue,
                                  foregroundColor: AppTheme.white,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      padding: EdgeInsets.all(AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.blue200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.blue50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          SizedBox(width: AppTheme.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.blue600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.blue800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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