import 'package:flutter/material.dart';
import 'package:school/AdminDashboardPages/academicOption.dart';
import 'package:school/AdminDashboardPages/academicResults.dart';
import 'package:school/AdminDashboardPages/addDesignation.dart';
import 'package:school/AdminDashboardPages/addTeacher.dart';
import 'package:school/AdminDashboardPages/adminAddNewApplicant.dart';
import 'package:school/AdminDashboardPages/classAndSectionManagement.dart';
import 'package:school/AdminDashboardPages/employmentManagement.dart';
import 'package:school/AdminDashboardPages/feeManagement.dart';
import 'package:school/AdminDashboardPages/reportAndAnalytics.dart';
import 'package:school/AdminDashboardPages/studentManagement.dart';
import 'package:school/AdminDashboardPages/systemControl.dart';
import 'package:school/AdminDashboardPages/userRequest.dart';
import 'package:school/Admission/admissionBasicInfo.dart';
import 'package:school/Admission/admissionContactScreen.dart';
import 'package:school/Admission/admissionDocumentsScreen.dart';
import 'package:school/Admission/admissionMainScreen.dart';
import 'package:school/Admission/admissionParentInfo.dart';
import 'package:school/Admission/admissionPaymentsScreen.dart';
import 'package:school/Admission/checkAddmissionStatus.dart';
import 'package:school/Dashboard/academicOfficerDashboard.dart';
import 'package:school/Dashboard/adminDashboard.dart';
import 'package:school/Dashboard/parentsDashBoard.dart';
import 'package:school/Dashboard/studentDashboard.dart';
import 'package:school/Dashboard/teacherDashboard.dart';
import 'package:school/Help/parentHelp.dart';
import 'package:school/Help/schoolHelp.dart';
import 'package:school/Screens/Notifications.dart';
import 'package:school/Screens/changePasswordScreen.dart';
import 'package:school/Screens/forgetPassword.dart';
import 'package:school/Screens/loginScreen.dart';
import 'package:school/Screens/mainChat.dart';
import 'package:school/Screens/registerScreen.dart';
import 'package:school/Screens/setting.dart';
import 'package:school/SignUp/academicOfficerSignUp.dart';
import 'package:school/SignUp/adminSignUp.dart';
import 'package:school/SignUp/mainSignUpPage.dart';
import 'package:school/SignUp/parentSignUp.dart';
import 'package:school/SignUp/studentSignUp.dart';
import 'package:school/SignUp/teacherSignUp.dart';
import 'package:school/StudentDashboardPages/feeManagementStudent.dart';
import 'package:school/StudentDashboardPages/noticeAndMessages.dart';
import 'package:school/StudentDashboardPages/profileStudent.dart';
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/StudentDashboardPages/timeTableStudent.dart';
import 'package:school/academicOfficerDashboardPages/classroomReportAcademicOfficer.dart';
import 'package:school/academicOfficerDashboardPages/sendNotificationAcademciOfficer.dart';
import 'package:school/academicOfficerDashboardPages/teacherPerformance.dart';
import 'package:school/parentDashboardPages/feeManagementParent.dart';
import 'package:school/schoolDetails.dart';
import 'package:school/splashScreen.dart';
import 'package:school/teacherDashboardPages/attendanceTeacher.dart';
import 'package:school/teacherDashboardPages/messageTeacher.dart';
import 'package:school/teacherDashboardPages/profileTeacher.dart';
import 'package:school/teacherDashboardPages/resultEntryTeacher.dart';
import 'package:school/teacherDashboardPages/studentList.dart';
import 'package:school/teacherDashboardPages/timeTableTeacher.dart';
import 'academicOfficerDashboardPages/ExamManagementAcademicOfficer.dart';


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
      // home: AppSettingsPage(),
      // home: SubjectsMarksScreen(),
      // home: AcademicResultsScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/change-password': (context) => ChangePasswordPage(),
        '/school-details' : (context) => AboutSchool(),
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
        '/academic-officer-dashboard':(context) => academicOfficerDashboard(),
        '/parent-dashboard':(context) => ParentDashboard(),
        '/admission-main': (context) => AdmissionMainScreen(),
        '/admission-basic': (context) => AdmissionBasicInfoScreen(),
        '/admission-parent': (context) => AdmissionParentInfoScreen(),
        '/admission-contact': (context) => AdmissionContactScreen(),
        '/admission-documents': (context) => AdmissionDocumentsScreen(),
        '/payment-page': (context) => AdmissionPaymentsScreen(),
        '/check-admission-status': (context) => AdmissionStatusScreen(),
        '/forget-password': (context) => ForgotPasswordScreen(),
        '/admin-employee-management': (context) => EmployeeManagementPage(),
        '/admin-student-management':(context) => ClassManagementPage(),
        '/admin-student-management-student-list': (context) => ClassManagementPage(),
        '/admin-class-section-management':(context) => ClassSectionManagementPage(),
        '/admin-academic-result-screen':(context) => AcademicResultsScreen(),
        '/admin-report-analytics':(context) => ReportsAnalyticsPage(),
        '/admin-system-control':(context) => SystemControlsPage(),
        '/admin-fee-management':(context) => FeeManagementPage(),
        '/admin-add-student-applicant': (context) => AddNewApplicantScreen(),
        '/admin-add-teacher': (context) => AddTeacherScreen(),
        '/admin-add-designation': (context) => AddDesignationPage(),
        '/admin-user-request': (context) => UserRequestsPage(),
        '/academic-options': (context) => AcademicScreen(),
        '/student-subject-marks':(context) => SubjectsMarksScreen(),
        '/student-notice-message':(context) => NoticesMessage(),
        '/student-fee-management':(context) => FeeManagementScreenStudent(),
        '/student-profile': (context) => StudentProfile(),
        '/student-timetable': (context) => TimeTableStudentScreen(),
        '/teacher-student-list': (context) => StudentListScreen(),
        '/teacher-attendance':(context) => AttendancePageTeacher(),
        '/teacher-result-entry': (context) => ResultEntryPage(),
        '/teacher-message': (context) => MessagePageTeacher(),
        '/teacher-timetable': (context) => TeacherTimetablePage(),
        '/teacher-profile': (context) => TeacherProfilePage(),
        '/academic-officer-teacher-performance': (context) => TeacherPerformanceScreen(),
        '/academic-officer-classroom-report': (context) => ClassroomReportsScreen(),
        '/academic-officer-exam-management-screen': (context) => ExamManagementScreen(),
        '/academic-officer-notification': (context) => NotificationsScreen(),
        '/parent-fee-management': (context) => FeePaymentParentPage(),
        '/notifications': (context) => Notifications(),
        '/main-chat': (context) => MainChat(),
      },
    );
  }
}
