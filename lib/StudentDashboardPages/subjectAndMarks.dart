import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';

class SubjectsMarksScreen extends StatefulWidget {
  const SubjectsMarksScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsMarksScreen> createState() => _SubjectsMarksScreenState();
}

class _SubjectsMarksScreenState extends State<SubjectsMarksScreen> with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;

  // Sample data for subjects
  final List<Subject> subjects = [
    Subject('Mathematics', 'A+', 95, Icons.calculate, Colors.green),
    Subject('English', 'A', 88, Icons.book, AppTheme.primaryBlue),
    Subject('Science', 'A+', 92, Icons.science, Colors.green),
    Subject('History', 'B+', 82, Icons.history_edu, Colors.orange),
    Subject('Geography', 'A', 86, Icons.public, AppTheme.primaryBlue),
    Subject('Computer Science', 'A+', 94, Icons.computer, Colors.green),
    Subject('Physical Education', 'A', 89, Icons.sports, AppTheme.primaryBlue),
    Subject('Art', 'B+', 84, Icons.palette, Colors.orange),
  ];

  // Sample exam results data
  final List<ExamResult> examResults = [
    ExamResult('Mid-Term Exam', 'September 2024', 87.5, 'A'),
    ExamResult('Unit Test 1', 'August 2024', 91.2, 'A+'),
    ExamResult('Final Exam', 'December 2024', 89.8, 'A'),
    ExamResult('Unit Test 2', 'October 2024', 85.6, 'A'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25, left: 8, right: 8),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                    decoration: const BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppTheme.cardBorderRadius),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Enhanced Tab Bar
                        Container(
                          margin: const EdgeInsets.all(AppTheme.defaultSpacing),
                          decoration: BoxDecoration(
                            color: AppTheme.blue50,
                            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: AppTheme.primaryBlue,
                              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                            ),
                            labelColor: AppTheme.white,
                            unselectedLabelColor: AppTheme.blue600,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            tabs: const [
                              Tab(text: 'Subject List'),
                              Tab(text: 'Grades & Results'),
                            ],
                          ),
                        ),

                        // Tab Content
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildSubjectListTab(),
                              _buildGradesResultsTab(),
                            ],
                          ),
                        ),

                        // Action Buttons
                        _buildActionButtons(),
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

  Widget _buildSubjectListTab() {
    return Column(
      children: [
        // Summary Card
        Container(
          margin: const EdgeInsets.all(AppTheme.defaultSpacing),
          padding: const EdgeInsets.all(AppTheme.mediumSpacing),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryBlue.withOpacity(0.1), AppTheme.primaryPurple.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Total Subjects', '${subjects.length}', Icons.subject),
              _buildSummaryItem('Average', '${_calculateAverage().toStringAsFixed(1)}%', Icons.trending_up),
              _buildSummaryItem('Overall Grade', _getOverallGrade(), Icons.star),
            ],
          ),
        ),

        // Subject List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return _buildSubjectCard(subjects[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGradesResultsTab() {
    return Column(
      children: [
        // Overall Performance Card
        Container(
          margin: const EdgeInsets.all(AppTheme.defaultSpacing),
          padding: const EdgeInsets.all(AppTheme.defaultSpacing),
          decoration: BoxDecoration(
            color: AppTheme.blue50,
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Academic Performance Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: AppTheme.mediumSpacing),
              Row(
                children: [
                  Expanded(
                    child: _buildPerformanceMetric('Current GPA', '3.7/4.0', Icons.school, Colors.green),
                  ),
                  Expanded(
                    child: _buildPerformanceMetric('Class Rank', '12/45', Icons.emoji_events, Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Exam Results List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: examResults.length,
            itemBuilder: (context, index) {
              return _buildExamResultCard(examResults[index]);
            },
          ),
        ),

        // Progress Chart Section
        Container(
          margin: const EdgeInsets.all(AppTheme.defaultSpacing),
          padding: const EdgeInsets.all(AppTheme.defaultSpacing),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Performance Trend',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: AppTheme.mediumSpacing),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryBlue.withOpacity(0.3),
                      AppTheme.primaryPurple.withOpacity(0.3)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    '📈 Showing consistent improvement',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetric(String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Subject subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppTheme.mediumSpacing),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.blue50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(subject.icon, color: AppTheme.primaryBlue, size: 24),
        ),
        title: Text(
          subject.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Percentage: ${subject.percentage}%',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: subject.percentage / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(subject.gradeColor),
              minHeight: 4,
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: subject.gradeColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            subject.grade,
            style: const TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        onTap: () {
          _showSubjectDetails(context, subject);
        },
      ),
    );
  }

  Widget _buildExamResultCard(ExamResult result) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppTheme.mediumSpacing),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getGradeColor(result.grade).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.assignment,
            color: _getGradeColor(result.grade),
            size: 24,
          ),
        ),
        title: Text(
          result.examName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.date,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Score: ${result.percentage}%',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getGradeColor(result.grade),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            result.grade,
            style: const TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: AppTheme.buttonHeight,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading mark sheet...')),
                  );
                },
                icon: const Icon(Icons.download, color: AppTheme.white),
                label: const Text('Download', style: AppTheme.buttonTextStyle),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  elevation: AppTheme.buttonElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.mediumSpacing),
          Expanded(
            child: SizedBox(
              height: AppTheme.buttonHeight,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing report...')),
                  );
                },
                icon: Icon(Icons.share, color: AppTheme.primaryBlue),
                label: Text(
                  'Share Report',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.primaryBlue, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubjectDetails(BuildContext context, Subject subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Row(
            children: [
              Icon(subject.icon, color: AppTheme.primaryBlue),
              const SizedBox(width: 10),
              Text(subject.name),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Grade: ${subject.grade}'),
              Text('Percentage: ${subject.percentage}%'),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: subject.percentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(subject.gradeColor),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  double _calculateAverage() {
    if (subjects.isEmpty) return 0.0;
    double total = subjects.fold(0.0, (sum, subject) => sum + subject.percentage);
    return total / subjects.length;
  }

  String _getOverallGrade() {
    double average = _calculateAverage();
    if (average >= 95) return 'A+';
    if (average >= 90) return 'A';
    if (average >= 85) return 'A-';
    if (average >= 80) return 'B+';
    if (average >= 75) return 'B';
    return 'B-';
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green;
      case 'A':
      case 'A-':
        return AppTheme.primaryBlue;
      case 'B+':
        return Colors.orange;
      case 'B':
      case 'B-':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}

// Data Models
class Subject {
  final String name;
  final String grade;
  final double percentage;
  final IconData icon;
  final Color gradeColor;

  Subject(this.name, this.grade, this.percentage, this.icon, this.gradeColor);
}

class ExamResult {
  final String examName;
  final String date;
  final double percentage;
  final String grade;

  ExamResult(this.examName, this.date, this.percentage, this.grade);
}

// Theme class (copy from your theme.dart file)
class AppTheme {
  static const Color primaryBlue = Color(0xFF42A5F5);
  static const Color primaryPurple = Color(0xFF8E24AA);
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue200 = Color(0xFF90CAF9);
  static final Color blue800 = Colors.blue.shade800;
  static final Color blue600 = Colors.blue.shade600;

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryPurple],
  );

  static const double cardElevation = 8.0;
  static const double cardBorderRadius = 15.0;
  static const double inputBorderRadius = 10.0;
  static const double focusedBorderWidth = 2.0;
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 25.0;
  static const double buttonElevation = 5.0;

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: white,
    fontFamily: 'Roboto',
  );

  static const TextStyle FontStyle = TextStyle(
    fontSize: 28,
    color: white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );

  static const TextStyle splashSubtitleStyle = TextStyle(
    fontSize: 16,
    color: white70,
    fontFamily: 'Roboto',
  );

  static const Duration splashAnimationDuration = Duration(seconds: 2);
  static const Duration splashScreenDuration = Duration(seconds: 3);
  static const Duration slideAnimationDuration = Duration(milliseconds: 800);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 300);

  static const double defaultSpacing = 20.0;
  static const double smallSpacing = 10.0;
  static const double mediumSpacing = 15.0;
  static const double largeSpacing = 50.0;
  static const double extraLargeSpacing = 30.0;
  static const double logoSize = 50.0;
}