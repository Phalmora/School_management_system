import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class Student {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String className;
  final String admissionStatus;
  final DateTime dateOfBirth;
  final String address;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
    required this.admissionStatus,
    required this.dateOfBirth,
    required this.address,
  });
}

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

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.mediumSpacing),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryBlue, size: 24),
            SizedBox(width: AppTheme.mediumSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppTheme.defaultSpacing),
            child: Column(
              children: [
                // Header Card with Avatar
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppTheme.largeSpacing),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryBlue, AppTheme.primaryBlue.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Text(
                            student.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        ),
                        SizedBox(height: AppTheme.mediumSpacing),
                        Text(
                          student.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          student.className,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        SizedBox(height: AppTheme.smallSpacing),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _getStatusColor(student.admissionStatus).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _getStatusColor(student.admissionStatus),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            student.admissionStatus,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppTheme.defaultSpacing),

                // Details Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.mediumSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                        SizedBox(height: AppTheme.mediumSpacing),

                        _buildDetailCard('Student ID', student.id, Icons.badge),
                        _buildDetailCard('Email Address', student.email, Icons.email),
                        _buildDetailCard('Phone Number', student.phone, Icons.phone),
                        _buildDetailCard(
                            'Date of Birth',
                            '${student.dateOfBirth.day}/${student.dateOfBirth.month}/${student.dateOfBirth.year}',
                            Icons.cake
                        ),
                        _buildDetailCard('Age', '${_calculateAge(student.dateOfBirth)} years old', Icons.person),
                        _buildDetailCard('Class', student.className, Icons.school),
                        _buildDetailCard('Address', student.address.isEmpty ? 'Not provided' : student.address, Icons.location_on),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppTheme.defaultSpacing),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // You can add edit functionality here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Edit functionality can be added here')),
                          );
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Edit Student'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppTheme.mediumSpacing),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        label: Text('Back to List'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryBlue,
                          side: BorderSide(color: AppTheme.primaryBlue),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
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
    );
  }
}