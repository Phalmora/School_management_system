import 'package:flutter/material.dart';
import 'package:school/SignUp/academicOfficerSignUp.dart';
import 'package:school/SignUp/adminSignUp.dart';
import 'package:school/SignUp/parentSignUp.dart';
import 'package:school/SignUp/studentSignUp.dart';
import 'package:school/SignUp/teacherSignUp.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class MainSignUpPage extends StatefulWidget {
  @override
  _MainSignUpPageState createState() => _MainSignUpPageState();
}

class _MainSignUpPageState extends State<MainSignUpPage> {
  String? selectedRole;
  List<String> roles = ['Student', 'Teacher', 'Academic Officer', 'Admin', 'Parent'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.defaultSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.deepPurpleAccent,
                    decorationStyle: TextDecorationStyle.dotted,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Main Card
                Card(
                  elevation: AppTheme.cardElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.extraLargeSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Your Role',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.blue800,
                          ),
                        ),
                        SizedBox(height: AppTheme.smallSpacing),
                        Text(
                          'Please select your role to continue with registration',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: AppTheme.extraLargeSpacing),

                        // Role Selection Dropdown
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person, color: AppTheme.blue600),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppTheme.mediumSpacing,
                                vertical: AppTheme.mediumSpacing,
                              ),
                              hintText: 'Select Your Role',
                            ),
                            value: selectedRole,
                            items: roles.map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRole = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your role';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: AppTheme.extraLargeSpacing),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: AppTheme.buttonHeight,
                          child: ElevatedButton(
                            onPressed: selectedRole != null ? _navigateToSelectedRole : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedRole != null
                                  ? AppTheme.primaryBlue
                                  : Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                              ),
                              elevation: AppTheme.buttonElevation,
                            ),
                            child: Text(
                              'Continue to Sign Up',
                              style: AppTheme.buttonTextStyle,
                            ),
                          ),
                        ),

                        SizedBox(height: AppTheme.mediumSpacing),

                        // Login Link
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Already have an account? Login here',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                fontSize: 16,
                              ),
                            ),
                          ),
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
    );
  }

  void _navigateToSelectedRole() {
    Widget destinationPage;

    switch (selectedRole) {
      case 'Student':
        destinationPage = StudentSignupPage();
        break;
      case 'Teacher':
        destinationPage = TeacherSignupPage();
        break;
      case 'Academic Officer':
        destinationPage = AcademicOfficerSignupPage();
        break;
      case 'Admin':
        destinationPage = AdminSignupPage();
        break;
      case 'Parent':
        destinationPage = ParentSignUpPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationPage),
    );
  }
}