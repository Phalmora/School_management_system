import 'package:flutter/material.dart';
import 'package:school/Admission/admissionBasicInfo.dart';
import 'package:school/Admission/admissionContactScreen.dart';
import 'package:school/Admission/admissionDocumentsScreen.dart';
import 'package:school/Admission/admissionMainScreen.dart';
import 'package:school/Admission/admissionParentInfo.dart';
import 'package:school/Admission/admissionPaymentsScreen.dart';
import 'package:school/Admission/checkAddmissionStatus.dart';
import 'package:school/Dashboard/academicOfficerDashboard.dart';
import 'package:school/Dashboard/adminDashboard.dart';
import 'package:school/Dashboard/studentDashboard.dart';
import 'package:school/Dashboard/teacherDashboard.dart';
import 'package:school/Help/parentHelp.dart';
import 'package:school/Help/schoolHelp.dart';
import 'package:school/Screens/changePasswordScreen.dart';
import 'package:school/Screens/loginScreen.dart';
import 'package:school/Screens/registerScreen.dart';
import 'package:school/Screens/studentInformation.dart';
import 'package:school/SignUp/academicOfficerSignUp.dart';
import 'package:school/SignUp/adminSignUp.dart';
import 'package:school/SignUp/mainSignUpPage.dart';
import 'package:school/SignUp/parentSignUp.dart';
import 'package:school/SignUp/studentSignUp.dart';
import 'package:school/SignUp/teacherSignUp.dart';
import 'package:school/schoolDetails.dart';
import 'package:school/splashScreen.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
      // home: StudentInformation(),
      // home: AdmissionStatusScreen(),
      // home: teacherDashboard (),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/change-password': (context) => ChangePasswordPage(),
        '/school-details' : (context) => SchoolDetails(),
        '/school-help': (context) => SchoolHelp(),
        '/parent-help': (context) => ParentHelp(),
        '/main-signup': (context) => MainSignUpPage(),
        '/admin-signup': (context) => AdminSignupPage(),
        '/academic-officer-signup' : (context) => AcademicOfficerSignupPage(),
        '/teacher-signup': (context) => TeacherSignupPage(),
        '/student-signup': (context) => StudentSignupPage(),
        '/parent-signup': (context) => ParentSignUpPage(),
        '/admin-dashboard':(context) => adminDashboard(),
        '/student-dashboard': (context) => StudentDashboard(),
        '/teacher-dashboard': (context) => teacherDashboard(),
        'academicOfficer-dashboard':(context) => academicOfficerDashboard(),
        '/admission-main': (context) => AdmissionMainScreen(),
        '/admission-basic': (context) => AdmissionBasicInfoScreen(),
        '/admission-parent': (context) => AdmissionParentInfoScreen(),
        '/admission-contact': (context) => AdmissionContactScreen(),
        '/admission-documents': (context) => AdmissionDocumentsScreen(),
        '/payment-page': (context) => AdmissionPaymentsScreen(),
        '/check-admission-status': (context) => AdmissionStatusScreen(),

      },
    );
  }
}
