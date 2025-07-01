import 'package:flutter/material.dart';
import 'package:school/CommonLogic/tabBar.dart';
import 'package:school/model/dashboard/resultModelTeacher.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

class ResultEntryPage extends StatefulWidget {
  const ResultEntryPage({Key? key}) : super(key: key);

  @override
  State<ResultEntryPage> createState() => _ResultEntryPageState();
}

class _ResultEntryPageState extends State<ResultEntryPage>
    with SingleTickerProviderStateMixin {
  final ResultService _resultService = ResultService();
  late TabController _tabController;

  List<Student> _students = [];
  List<Subject> _subjects = [];
  List<Exam> _exams = [];

  Exam? _selectedExam;
  Subject? _selectedSubject;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final students = await _resultService.getStudents();
      final subjects = await _resultService.getSubjects();
      final exams = await _resultService.getExams();

      setState(() {
        _students = students;
        _subjects = subjects;
        _exams = exams;
        _selectedExam = exams.isNotEmpty ? exams.first : null;
        _selectedSubject = subjects.isNotEmpty ? subjects.first : null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error loading data: $e', isError: true); // Added error message
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveResult(ExamResult result) async {
    final success = await _resultService.saveResult(result);
    if (success) {
      _showSnackBar('Result saved successfully!');
      // Reload data to reflect changes in view results and statistics tabs
      _loadData();
    } else {
      _showSnackBar('Failed to save result.', isError: true);
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return Colors.green;
      case 'B+':
      case 'B':
        return Colors.lightGreen;
      case 'C+':
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.amber;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(gradient: AppThemeColor.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context), // Pass context
              CustomTabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Entry'),
                  Tab(text: 'Result'),
                  Tab(text: 'Statistics'),
                ],
                getSpacing: AppThemeResponsiveness.getDefaultSpacing,
                getBorderRadius: AppThemeResponsiveness.getInputBorderRadius,
                getFontSize: AppThemeResponsiveness.getTabFontSize,
                backgroundColor: AppThemeColor.blue50,
                selectedColor: AppThemeColor.primaryBlue,
                unselectedColor: AppThemeColor.blue600,
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                    child: CircularProgressIndicator(color: AppThemeColor.white))
                    : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMarksEntryTab(context), // Pass context
                    _buildViewResultsTab(context), // Pass context
                    _buildStatisticsTab(context), // Pass context
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Container(
        // Constrain max width for larger screens
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
              Icons.assessment,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getHeaderIconSize(context), // Responsive icon size
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)), // Responsive spacing
            Flexible( // Use Flexible to prevent overflow on small screens
              child: Text(
                'Results & Marks',
                style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(
                      context,
                      AppThemeResponsiveness.getSectionTitleStyle(context).fontSize! + 4 // Adjust font size
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

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.blue50,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppThemeColor.primaryBlue,
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          boxShadow: [
            BoxShadow(
              color: AppThemeColor.primaryBlue.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppThemeColor.white,
        unselectedLabelColor: AppThemeColor.blue600,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: AppThemeResponsiveness.getTabFontSize(context),
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppThemeResponsiveness.getTabFontSize(context),
        ),
        tabs: const [
          Tab(text: 'Entry'),
          Tab(text: 'Result'),
          Tab(text: 'Statistics',)
        ],
      ),
    );
  }

  Widget _buildMarksEntryTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
      child: Column(
        children: [
          _buildExamSubjectSelector(context), // Pass context
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive spacing
          if (_selectedExam != null && _selectedSubject != null)
            _buildStudentMarksEntryList(context), // Pass context
        ],
      ),
    );
  }

  Widget _buildExamSubjectSelector(BuildContext context) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Exam & Subject',
              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith( // Responsive font size
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
            DropdownButtonFormField<Exam>(
              value: _selectedExam,
              decoration: InputDecoration(
                labelText: 'Select Exam',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)), // Responsive border radius
                ),
                prefixIcon: Icon(Icons.quiz, size: AppThemeResponsiveness.getIconSize(context) * 0.8), // Responsive icon size
              ),
              items: _exams.map((exam) {
                return DropdownMenuItem(
                  value: exam,
                  child: Text(
                    '${exam.name} (${exam.type.replaceAll('_', ' ').toUpperCase()})',
                    style: AppThemeResponsiveness.getBodyTextStyle(context), // Responsive text style
                  ),
                );
              }).toList(),
              onChanged: (exam) {
                setState(() => _selectedExam = exam);
              },
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
            DropdownButtonFormField<Subject>(
              value: _selectedSubject,
              decoration: InputDecoration(
                labelText: 'Select Subject',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)), // Responsive border radius
                ),
                prefixIcon: Icon(Icons.book, size: AppThemeResponsiveness.getIconSize(context) * 0.8), // Responsive icon size
              ),
              items: _subjects.map((subject) {
                return DropdownMenuItem(
                  value: subject,
                  child: Text(
                    '${subject.name} (${subject.code})',
                    style: AppThemeResponsiveness.getBodyTextStyle(context), // Responsive text style
                  ),
                );
              }).toList(),
              onChanged: (subject) {
                setState(() => _selectedSubject = subject);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentMarksEntryList(BuildContext context) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enter Marks',
                  style: AppThemeResponsiveness.getHeadingStyle(context).copyWith( // Responsive font size
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Max: ${_selectedSubject!.maxMarks}',
                  style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith( // Responsive font size
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _students.length,
              separatorBuilder: (context, index) => SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)), // Responsive spacing
              itemBuilder: (context, index) {
                final student = _students[index];
                return _buildStudentMarksCard(context, student); // Pass context
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentMarksCard(BuildContext context, Student student) {
    return FutureBuilder<ExamResult?>(
      future: _resultService.getResult(
        student.id,
        _selectedSubject!.id,
        _selectedExam!.id,
      ),
      builder: (context, snapshot) {
        final existingResult = snapshot.data;
        return _StudentMarksEntryCard(
          student: student,
          subject: _selectedSubject!,
          exam: _selectedExam!,
          existingResult: existingResult,
          onSave: (result) => _saveResult(result),
        );
      },
    );
  }

  Widget _buildViewResultsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
      child: Column(
        children: [
          _buildResultsExamSelector(context), // Pass context
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive spacing
          if (_selectedExam != null)
            _buildStudentResultsDisplay(context), // New responsive method
        ],
      ),
    );
  }

  Widget _buildResultsExamSelector(BuildContext context) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View Results',
              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith( // Responsive font size
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
            DropdownButtonFormField<Exam>(
              value: _selectedExam,
              decoration: InputDecoration(
                labelText: 'Select Exam',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)), // Responsive border radius
                ),
                prefixIcon: Icon(Icons.quiz, size: AppThemeResponsiveness.getIconSize(context) * 0.8), // Responsive icon size
              ),
              items: _exams.map((exam) {
                return DropdownMenuItem(
                  value: exam,
                  child: Text(
                    '${exam.name} (${exam.type.replaceAll('_', ' ').toUpperCase()})',
                    style: AppThemeResponsiveness.getBodyTextStyle(context), // Responsive text style
                  ),
                );
              }).toList(),
              onChanged: (exam) {
                setState(() => _selectedExam = exam);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentResultsDisplay(BuildContext context) {
    return FutureBuilder<List<ExamResult>>(
      future: _resultService.getResultsByExam(_selectedExam!.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return Card(
            elevation: AppThemeColor.cardElevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppThemeResponsiveness.getLargeSpacing(context)), // Responsive padding
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.assignment, size: AppThemeResponsiveness.getHeaderIconSize(context), color: Colors.grey), // Responsive icon size
                    SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
                    Text(
                      'No results found for this exam',
                      style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(color: Colors.grey), // Responsive text style
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Group results by student
        final studentResults = <String, List<ExamResult>>{};
        for (final result in results) {
          studentResults[result.studentId] ??= [];
          studentResults[result.studentId]!.add(result);
        }

        // Conditional rendering for Grid vs List based on screen size
        return AppThemeResponsiveness.isDesktop(context)
            ? GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero, // Padding handled by parent
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppThemeResponsiveness.getGridCrossAxisCount(context), // Responsive grid count
            crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context), // Responsive spacing
            mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context), // Responsive spacing
            childAspectRatio: AppThemeResponsiveness.getGridChildAspectRatio(context) * 1.2, // Adjust aspect ratio for content
          ),
          itemCount: studentResults.length,
          itemBuilder: (context, index) {
            final studentId = studentResults.keys.elementAt(index);
            final student = _students.firstWhere((s) => s.id == studentId);
            return FutureBuilder<StudentResultSummary>(
              future: _resultService.getStudentSummary(studentId, _selectedExam!.id),
              builder: (context, summarySnapshot) {
                final summary = summarySnapshot.data;
                return _buildStudentResultGridCard(context, student, summary); // New grid card widget
              },
            );
          },
        )
            : ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: studentResults.length,
          separatorBuilder: (context, index) => SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)), // Responsive spacing
          itemBuilder: (context, index) {
            final studentId = studentResults.keys.elementAt(index);
            final student = _students.firstWhere((s) => s.id == studentId);
            return FutureBuilder<StudentResultSummary>(
              future: _resultService.getStudentSummary(studentId, _selectedExam!.id),
              builder: (context, summarySnapshot) {
                final summary = summarySnapshot.data;
                return _buildStudentResultCard(context, student, summary); // Pass context
              },
            );
          },
        );
      },
    );
  }

  Widget _buildStudentResultCard(BuildContext context, Student student, StudentResultSummary? summary) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppThemeColor.primaryBlue,
          radius: AppThemeResponsiveness.getDashboardCardIconSize(context) * 0.5, // Responsive size
          child: Text(
            student.name.substring(0, 1).toUpperCase(),
            style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
              color: AppThemeColor.white,
              fontSize: AppThemeResponsiveness.getDashboardCardTitleStyle(context).fontSize! * 0.8, // Adjust font for avatar
            ),
          ),
        ),
        title: Text(
          student.name,
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context), // Responsive font size
        ),
        subtitle: Text(
          'Roll No: ${student.rollNumber}',
          style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context), // Responsive font size
        ),
        trailing: summary != null
            ? Container(
          padding: AppThemeResponsiveness.getStatusBadgePadding(context), // Responsive padding
          decoration: BoxDecoration(
            color: _getGradeColor(summary.overallGrade),
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getStatusBadgeBorderRadius(context)), // Responsive border radius
          ),
          child: Text(
            '${summary.percentage.toStringAsFixed(1)}% (${summary.overallGrade})',
            style: TextStyle(
              color: AppThemeColor.white,
              fontWeight: FontWeight.bold,
              fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context), // Responsive font size
            ),
          ),
        )
            : null,
        children: [
          if (summary != null)
            Padding(
              padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildResultStat(context, 'Total', // Pass context
                          '${summary.totalMarksObtained.toInt()}/${summary.totalMaxMarks.toInt()}'),
                      _buildResultStat(context, 'Percentage', // Pass context
                          '${summary.percentage.toStringAsFixed(1)}%'),
                      _buildResultStat(context, 'Grade', summary.overallGrade), // Pass context
                      _buildResultStat(context, 'Pass/Total', // Pass context
                          '${summary.subjectsPassed}/${summary.totalSubjects}'),
                    ],
                  ),
                  SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive spacing
                ],
              ),
            ),
        ],
      ),
    );
  }

  // New Widget for Grid layout for results
  Widget _buildStudentResultGridCard(BuildContext context, Student student, StudentResultSummary? summary) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      child: InkWell(
        onTap: () {
          // You can expand this to show a dialog with more details like in SubjectAndMarks
        },
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getGridItemPadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppThemeColor.primaryBlue,
                radius: AppThemeResponsiveness.getGridItemIconSize(context) * 0.4, // Adjust size
                child: Text(
                  student.name.substring(0, 1).toUpperCase(),
                  style: AppThemeResponsiveness.getGridItemTitleStyle(context).copyWith(color: AppThemeColor.white, fontSize: AppThemeResponsiveness.getGridItemTitleStyle(context).fontSize! * 0.8),
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Text(
                student.name,
                style: AppThemeResponsiveness.getGridItemTitleStyle(context),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Roll No: ${student.rollNumber}',
                style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
              ),
              if (summary != null) ...[
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                Container(
                  padding: AppThemeResponsiveness.getStatusBadgePadding(context),
                  decoration: BoxDecoration(
                    color: _getGradeColor(summary.overallGrade),
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getStatusBadgeBorderRadius(context)),
                  ),
                  child: Text(
                    '${summary.percentage.toStringAsFixed(1)}% (${summary.overallGrade})',
                    style: TextStyle(
                      color: AppThemeColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppThemeResponsiveness.getStatValueStyle(context), // Responsive font size
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2), // Responsive spacing
        Text(
          label,
          style: AppThemeResponsiveness.getStatTitleStyle(context), // Responsive font size
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatisticsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
      child: Column(
        children: [
          _buildStatisticsExamSelector(context), // Pass context
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive spacing
          if (_selectedExam != null)
            _buildClassStatisticsCard(context), // Pass context
        ],
      ),
    );
  }

  Widget _buildStatisticsExamSelector(BuildContext context) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Statistics',
              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith( // Responsive font size
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
            DropdownButtonFormField<Exam>(
              value: _selectedExam,
              decoration: InputDecoration(
                labelText: 'Select Exam',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)), // Responsive border radius
                ),
                prefixIcon: Icon(Icons.quiz, size: AppThemeResponsiveness.getIconSize(context) * 0.8), // Responsive icon size
              ),
              items: _exams.map((exam) {
                return DropdownMenuItem(
                  value: exam,
                  child: Text(
                    '${exam.name} (${exam.type.replaceAll('_', ' ').toUpperCase()})',
                    style: AppThemeResponsiveness.getBodyTextStyle(context), // Responsive text style
                  ),
                );
              }).toList(),
              onChanged: (exam) {
                setState(() {
                  _selectedExam = exam;
                  // Optionally reload statistics for the new exam
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassStatisticsCard(BuildContext context) {
    if (_selectedExam == null) {
      return const SizedBox.shrink();
    }

    // Call getClassStatistics within the FutureBuilder or ensure it's reactive
    // For simplicity, assuming _resultService.getClassStatistics is a synchronous getter for now
    // If it's asynchronous, you'd need another FutureBuilder here.
    final classStats = _resultService.getClassStatistics(_selectedExam!.id);

    if (classStats['totalStudents'] == 0) {
      return Card(
        elevation: AppThemeColor.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getLargeSpacing(context)), // Responsive padding
          child: Center(
            child: Column(
              children: [
                Icon(Icons.bar_chart, size: AppThemeResponsiveness.getHeaderIconSize(context), color: Colors.grey), // Responsive icon size
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
                Text(
                  'No statistics available for this exam yet.',
                  style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(color: Colors.grey), // Responsive text style
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Class Performance for ${_selectedExam!.name}',
              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith( // Responsive font size
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)), // Responsive spacing
            _buildStatRow(context, 'Total Students', classStats['totalStudents'].toString()), // Pass context
            _buildStatRow(context, 'Average Percentage', '${classStats['averagePercentage'].toStringAsFixed(1)}%'), // Pass context
            _buildStatRow(context, 'Highest Marks', '${classStats['highestMarks'].toStringAsFixed(1)}%'), // Pass context
            _buildStatRow(context, 'Lowest Marks', '${classStats['lowestMarks'].toStringAsFixed(1)}%'), // Pass context
            _buildStatRow(context, 'Students Passed', classStats['passedStudents'].toString()), // Pass context
            _buildStatRow(context, 'Students Failed', classStats['failedStudents'].toString()), // Pass context
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2), // Responsive padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(color: Colors.grey[700]), // Responsive font size
          ),
          Text(
            value,
            style: AppThemeResponsiveness.getStatValueStyle(context), // Responsive font size
          ),
        ],
      ),
    );
  }
}

// Separate Widget for Student Marks Entry Card
class _StudentMarksEntryCard extends StatefulWidget {
  final Student student;
  final Subject subject;
  final Exam exam;
  final ExamResult? existingResult;
  final ValueChanged<ExamResult> onSave;

  const _StudentMarksEntryCard({
    Key? key,
    required this.student,
    required this.subject,
    required this.exam,
    this.existingResult,
    required this.onSave,
  }) : super(key: key);

  @override
  State<_StudentMarksEntryCard> createState() => _StudentMarksEntryCardState();
}

class _StudentMarksEntryCardState extends State<_StudentMarksEntryCard> {
  late TextEditingController _marksController;
  late String _currentGrade;
  late bool _isPassed;

  @override
  void initState() {
    super.initState();
    _marksController = TextEditingController(
        text: widget.existingResult?.marksObtained.toString() ?? '');
    _updateGradeAndPassStatus(widget.existingResult?.marksObtained ?? 0.0);

    _marksController.addListener(_onMarksChanged);
  }

  @override
  void didUpdateWidget(covariant _StudentMarksEntryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.existingResult != oldWidget.existingResult) {
      _marksController.text = widget.existingResult?.marksObtained.toString() ?? '';
      _updateGradeAndPassStatus(widget.existingResult?.marksObtained ?? 0.0);
    }
  }

  @override
  void dispose() {
    _marksController.removeListener(_onMarksChanged);
    _marksController.dispose();
    super.dispose();
  }

  void _onMarksChanged() {
    final marks = double.tryParse(_marksController.text) ?? 0.0;
    _updateGradeAndPassStatus(marks);
  }

  void _updateGradeAndPassStatus(double marks) {
    setState(() {
      _currentGrade = _calculateGrade(marks);
      _isPassed = marks >= (widget.subject.maxMarks * 0.33); // Assuming 33% is passing
    });
  }

  String _calculateGrade(double marks) {
    if (marks >= 90) return 'A+';
    if (marks >= 80) return 'A';
    if (marks >= 70) return 'B+';
    if (marks >= 60) return 'B';
    if (marks >= 50) return 'C+';
    if (marks >= 40) return 'C';
    if (marks >= 33) return 'D';
    return 'F';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)), // Responsive border radius
        side: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)), // Responsive padding
        child: Row(
          children: [
            Expanded(
              flex: AppThemeResponsiveness.isMobile(context) ? 3 : 2, // Adjust flex based on screen size
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.student.name,
                    style: AppThemeResponsiveness.getDashboardCardTitleStyle(context), // Responsive text style
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Roll No: ${widget.student.rollNumber}',
                    style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context), // Responsive text style
                  ),
                ],
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)), // Responsive spacing
            Expanded(
              flex: AppThemeResponsiveness.isMobile(context) ? 2 : 1, // Adjust flex based on screen size
              child: TextFormField(
                controller: _marksController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Marks',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                    vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.8,
                  ), // Responsive content padding
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)), // Responsive border radius
                  ),
                ),
                onFieldSubmitted: (value) => _saveMarks(),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)), // Responsive spacing
            Expanded(
              flex: 1,
              child: Text(
                _currentGrade,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getGradeColor(_currentGrade),
                  fontSize: AppThemeResponsiveness.getBodyTextStyle(context).fontSize, // Responsive font size
                ),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)), // Responsive spacing
            IconButton(
              icon: Icon(Icons.save, color: AppThemeColor.primaryBlue, size: AppThemeResponsiveness.getIconSize(context) * 0.8), // Responsive icon size
              onPressed: _saveMarks,
            ),
          ],
        ),
      ),
    );
  }

  void _saveMarks() {
    final marks = double.tryParse(_marksController.text);
    if (marks == null || marks < 0 || marks > widget.subject.maxMarks) {
      _showSnackBar('Please enter valid marks (0-${widget.subject.maxMarks})', isError: true);
      return;
    }

    final newResult = ExamResult(
      id: widget.existingResult?.id ??
          '${widget.student.id}_${widget.subject.id}_${widget.exam.id}',
      studentId: widget.student.id,
      subjectId: widget.subject.id,
      examId: widget.exam.id,
      marksObtained: marks,
      maxMarks: widget.subject.maxMarks.toDouble(),
      grade: _calculateGrade(marks),
      dateEntered: DateTime.now(),
      enteredBy: 'Admin', // This could be dynamic based on logged-in user
    );
    widget.onSave(newResult);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return Colors.green;
      case 'B+':
      case 'B':
        return Colors.lightGreen;
      case 'C+':
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.amber;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
