import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'dart:math';


// result_models.dart
class Subject {
  final String id;
  final String name;
  final String code;
  final int maxMarks;
  final int passingMarks;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.maxMarks,
    required this.passingMarks,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      maxMarks: json['maxMarks'],
      passingMarks: json['passingMarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'maxMarks': maxMarks,
      'passingMarks': passingMarks,
    };
  }
}

class Student {
  final String id;
  final String name;
  final String rollNumber;
  final String className;
  final String? imageUrl;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.className,
    this.imageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      rollNumber: json['rollNumber'],
      className: json['className'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'className': className,
      'imageUrl': imageUrl,
    };
  }
}

class ExamResult {
  final String id;
  final String studentId;
  final String subjectId;
  final String examId;
  final double marksObtained;
  final double maxMarks;
  final String grade;
  final String? remarks;
  final DateTime dateEntered;
  final String enteredBy;

  ExamResult({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.examId,
    required this.marksObtained,
    required this.maxMarks,
    required this.grade,
    this.remarks,
    required this.dateEntered,
    required this.enteredBy,
  });

  double get percentage => (marksObtained / maxMarks) * 100;

  bool get isPassed => marksObtained >= (maxMarks * 0.33); // 33% passing criteria

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      id: json['id'],
      studentId: json['studentId'],
      subjectId: json['subjectId'],
      examId: json['examId'],
      marksObtained: json['marksObtained'].toDouble(),
      maxMarks: json['maxMarks'].toDouble(),
      grade: json['grade'],
      remarks: json['remarks'],
      dateEntered: DateTime.parse(json['dateEntered']),
      enteredBy: json['enteredBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'subjectId': subjectId,
      'examId': examId,
      'marksObtained': marksObtained,
      'maxMarks': maxMarks,
      'grade': grade,
      'remarks': remarks,
      'dateEntered': dateEntered.toIso8601String(),
      'enteredBy': enteredBy,
    };
  }
}

class Exam {
  final String id;
  final String name;
  final String type; // 'unit_test', 'mid_term', 'final', 'practical'
  final DateTime examDate;
  final String className;
  final bool isActive;

  Exam({
    required this.id,
    required this.name,
    required this.type,
    required this.examDate,
    required this.className,
    required this.isActive,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      examDate: DateTime.parse(json['examDate']),
      className: json['className'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'examDate': examDate.toIso8601String(),
      'className': className,
      'isActive': isActive,
    };
  }
}

class StudentResultSummary {
  final Student student;
  final List<ExamResult> results;
  final double totalMarksObtained;
  final double totalMaxMarks;
  final double percentage;
  final String overallGrade;
  final int subjectsPassed;
  final int totalSubjects;

  StudentResultSummary({
    required this.student,
    required this.results,
    required this.totalMarksObtained,
    required this.totalMaxMarks,
    required this.percentage,
    required this.overallGrade,
    required this.subjectsPassed,
    required this.totalSubjects,
  });
}


class ResultService {
  static final ResultService _instance = ResultService._internal();
  factory ResultService() => _instance;
  ResultService._internal();

  List<Student> _students = [];
  List<Subject> _subjects = [];
  List<Exam> _exams = [];
  List<ExamResult> _results = [];

  void initializeSampleData() {
    // Initialize subjects
    _subjects = [
      Subject(id: 'sub1', name: 'Mathematics', code: 'MATH', maxMarks: 100, passingMarks: 33),
      Subject(id: 'sub2', name: 'Physics', code: 'PHY', maxMarks: 100, passingMarks: 33),
      Subject(id: 'sub3', name: 'Chemistry', code: 'CHEM', maxMarks: 100, passingMarks: 33),
      Subject(id: 'sub4', name: 'English', code: 'ENG', maxMarks: 100, passingMarks: 33),
      Subject(id: 'sub5', name: 'Biology', code: 'BIO', maxMarks: 100, passingMarks: 33),
    ];

    // Initialize students
    _students = [
      Student(id: 'std1', name: 'Alice Johnson', rollNumber: '001', className: 'Class 10-A'),
      Student(id: 'std2', name: 'Bob Smith', rollNumber: '002', className: 'Class 10-A'),
      Student(id: 'std3', name: 'Charlie Brown', rollNumber: '003', className: 'Class 10-A'),
      Student(id: 'std4', name: 'Diana Prince', rollNumber: '004', className: 'Class 10-A'),
      Student(id: 'std5', name: 'Edward Wilson', rollNumber: '005', className: 'Class 10-A'),
    ];

    // Initialize exams
    _exams = [
      Exam(
        id: 'exam1',
        name: 'Unit Test 1',
        type: 'unit_test',
        examDate: DateTime.now().subtract(const Duration(days: 30)),
        className: 'Class 10-A',
        isActive: true,
      ),
      Exam(
        id: 'exam2',
        name: 'Mid Term Exam',
        type: 'mid_term',
        examDate: DateTime.now().subtract(const Duration(days: 15)),
        className: 'Class 10-A',
        isActive: true,
      ),
      Exam(
        id: 'exam3',
        name: 'Final Exam',
        type: 'final',
        examDate: DateTime.now().add(const Duration(days: 30)),
        className: 'Class 10-A',
        isActive: true,
      ),
    ];

    // Initialize some sample results
    _generateSampleResults();
  }

  void _generateSampleResults() {
    final random = Random();
    for (int i = 0; i < _students.length; i++) {
      final student = _students[i];
      for (final subject in _subjects) {
        // Only generate results for first 3 students for first 3 subjects for exam1
        if (i < 3 && _exams.isNotEmpty && _subjects.indexOf(subject) < 3) {
          final marks = 50 + random.nextInt(40); // Random marks between 50-89
          _results.add(ExamResult(
            id: 'result_${student.id}_${subject.id}_${_exams[0].id}',
            studentId: student.id,
            subjectId: subject.id,
            examId: _exams[0].id,
            marksObtained: marks.toDouble(),
            maxMarks: subject.maxMarks.toDouble(),
            grade: _calculateGrade(marks.toDouble()),
            remarks: marks > 80 ? 'Excellent performance' : marks > 60 ? 'Good work' : 'Needs improvement',
            dateEntered: DateTime.now().subtract(Duration(days: random.nextInt(10))),
            enteredBy: 'Teacher',
          ));
        }
      }
    }
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

  Future<List<Student>> getStudents() async {
    if (_students.isEmpty) initializeSampleData();
    return _students;
  }

  Future<List<Subject>> getSubjects() async {
    if (_subjects.isEmpty) initializeSampleData();
    return _subjects;
  }

  Future<List<Exam>> getExams() async {
    if (_exams.isEmpty) initializeSampleData();
    return _exams;
  }

  Future<List<ExamResult>> getResultsByExam(String examId) async {
    return _results.where((result) => result.examId == examId).toList();
  }

  Future<List<ExamResult>> getResultsByStudent(String studentId) async {
    return _results.where((result) => result.studentId == studentId).toList();
  }

  Future<ExamResult?> getResult(String studentId, String subjectId, String examId) async {
    try {
      return _results.firstWhere(
            (result) => result.studentId == studentId &&
            result.subjectId == subjectId &&
            result.examId == examId,
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveResult(ExamResult result) async {
    try {
      // Remove existing result if any
      _results.removeWhere((r) =>
      r.studentId == result.studentId &&
          r.subjectId == result.subjectId &&
          r.examId == result.examId);

      // Add new result
      _results.add(result);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteResult(String resultId) async {
    try {
      _results.removeWhere((result) => result.id == resultId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<StudentResultSummary> getStudentSummary(String studentId, String examId) async {
    final student = _students.firstWhere((s) => s.id == studentId);
    final results = _results.where((r) => r.studentId == studentId && r.examId == examId).toList();

    final totalMarksObtained = results.fold(0.0, (sum, result) => sum + result.marksObtained);
    final totalMaxMarks = results.fold(0.0, (sum, result) => sum + result.maxMarks);
    final percentage = totalMaxMarks > 0 ? (totalMarksObtained / totalMaxMarks) * 100 : 0.0;

    final overallGrade = _calculateGrade(percentage);
    final subjectsPassed = results.where((r) => r.isPassed).length;

    return StudentResultSummary(
      student: student,
      results: results,
      totalMarksObtained: totalMarksObtained,
      totalMaxMarks: totalMaxMarks,
      percentage: percentage,
      overallGrade: overallGrade,
      subjectsPassed: subjectsPassed,
      totalSubjects: results.length,
    );
  }

  Map<String, dynamic> getClassStatistics(String examId) {
    final examResults = _results.where((r) => r.examId == examId).toList();
    if (examResults.isEmpty) {
      return {
        'totalStudents': 0,
        'averagePercentage': 0.0,
        'highestMarks': 0.0,
        'lowestMarks': 0.0,
        'passedStudents': 0,
        'failedStudents': 0,
      };
    }

    final studentIds = examResults.map((r) => r.studentId).toSet();
    final percentages = <double>[];

    for (final studentId in studentIds) {
      final studentResults = examResults.where((r) => r.studentId == studentId).toList();
      final totalObtained = studentResults.fold(0.0, (sum, r) => sum + r.marksObtained);
      final totalMax = studentResults.fold(0.0, (sum, r) => sum + r.maxMarks);
      if (totalMax > 0) {
        percentages.add((totalObtained / totalMax) * 100);
      }
    }

    final averagePercentage = percentages.isNotEmpty
        ? percentages.reduce((a, b) => a + b) / percentages.length
        : 0.0;
    final highestMarks = percentages.isNotEmpty ? percentages.reduce((a, b) => a > b ? a : b) : 0.0;
    final lowestMarks = percentages.isNotEmpty ? percentages.reduce((a, b) => a < b ? a : b) : 0.0;
    final passedStudents = percentages.where((p) => p >= 33).length;

    return {
      'totalStudents': studentIds.length,
      'averagePercentage': averagePercentage,
      'highestMarks': highestMarks,
      'lowestMarks': lowestMarks,
      'passedStudents': passedStudents,
      'failedStudents': studentIds.length - passedStudents,
    };
  }
}


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
      _showSnackBar('Error loading data', isError: true);
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

  // --- New and Corrected Methods ---

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

  // --- End New and Corrected Methods ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: _isLoading
                    ? const Center(
                    child: CircularProgressIndicator(color: AppTheme.white))
                    : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMarksEntryTab(),
                    _buildViewResultsTab(),
                    _buildStatisticsTab(), // Now correctly defined
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          const SizedBox(width: AppTheme.smallSpacing),
          const Icon(Icons.assessment, color: AppTheme.white, size: 30),
          const SizedBox(width: AppTheme.smallSpacing),
          const Text('Results & Marks', style: AppTheme.FontStyle),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        labelColor: AppTheme.primaryBlue,
        unselectedLabelColor: AppTheme.white,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        tabs: const [
          Tab(text: 'Entry'),
          Tab(text: 'Results'),
          Tab(text: 'Statistics'),
        ],
      ),
    );
  }

  Widget _buildMarksEntryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Column(
        children: [
          _buildExamSubjectSelector(),
          const SizedBox(height: AppTheme.defaultSpacing),
          if (_selectedExam != null && _selectedSubject != null)
            _buildStudentMarksEntryList(),
        ],
      ),
    );
  }

  Widget _buildExamSubjectSelector() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Exam & Subject',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            DropdownButtonFormField<Exam>(
              value: _selectedExam,
              decoration: InputDecoration(
                labelText: 'Select Exam',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                prefixIcon: const Icon(Icons.quiz),
              ),
              items: _exams.map((exam) {
                return DropdownMenuItem(
                  value: exam,
                  child: Text('${exam.name} (${exam.type.replaceAll('_', ' ').toUpperCase()})'),
                );
              }).toList(),
              onChanged: (exam) {
                setState(() => _selectedExam = exam);
              },
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            DropdownButtonFormField<Subject>(
              value: _selectedSubject,
              decoration: InputDecoration(
                labelText: 'Select Subject',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                prefixIcon: const Icon(Icons.book),
              ),
              items: _subjects.map((subject) {
                return DropdownMenuItem(
                  value: subject,
                  child: Text('${subject.name} (${subject.code})'),
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

  Widget _buildStudentMarksEntryList() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enter Marks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Max: ${_selectedSubject!.maxMarks}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _students.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppTheme.smallSpacing),
              itemBuilder: (context, index) {
                final student = _students[index];
                return _buildStudentMarksCard(student);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentMarksCard(Student student) {
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

  Widget _buildViewResultsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Column(
        children: [
          _buildResultsExamSelector(),
          const SizedBox(height: AppTheme.defaultSpacing),
          if (_selectedExam != null)
            _buildStudentResultsList(),
        ],
      ),
    );
  }

  Widget _buildResultsExamSelector() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            DropdownButtonFormField<Exam>(
              value: _selectedExam,
              decoration: InputDecoration(
                labelText: 'Select Exam',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                prefixIcon: const Icon(Icons.quiz),
              ),
              items: _exams.map((exam) {
                return DropdownMenuItem(
                  value: exam,
                  child: Text('${exam.name} (${exam.type.replaceAll('_', ' ').toUpperCase()})'),
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

  Widget _buildStudentResultsList() {
    return FutureBuilder<List<ExamResult>>(
      future: _resultService.getResultsByExam(_selectedExam!.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return Card(
            elevation: AppTheme.cardElevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            ),
            child: const Padding(
              padding: EdgeInsets.all(AppTheme.largeSpacing),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.assignment, size: 60, color: Colors.grey),
                    SizedBox(height: AppTheme.mediumSpacing),
                    Text(
                      'No results found for this exam',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: studentResults.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppTheme.smallSpacing),
          itemBuilder: (context, index) {
            final studentId = studentResults.keys.elementAt(index);
            final student = _students.firstWhere((s) => s.id == studentId);
            return FutureBuilder<StudentResultSummary>(
              future: _resultService.getStudentSummary(studentId, _selectedExam!.id),
              builder: (context, summarySnapshot) {
                final summary = summarySnapshot.data;
                return _buildStudentResultCard(student, summary);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildStudentResultCard(Student student, StudentResultSummary? summary) {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryBlue,
          child: Text(
            student.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          student.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Roll No: ${student.rollNumber}'),
        trailing: summary != null
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getGradeColor(summary.overallGrade),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${summary.percentage.toStringAsFixed(1)}% (${summary.overallGrade})',
            style: const TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        )
            : null,
        children: [
          if (summary != null)
            Padding(
              padding: const EdgeInsets.all(AppTheme.defaultSpacing),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildResultStat('Total',
                          '${summary.totalMarksObtained.toInt()}/${summary.totalMaxMarks.toInt()}'),
                      _buildResultStat('Percentage',
                          '${summary.percentage.toStringAsFixed(1)}%'),
                      _buildResultStat('Grade', summary.overallGrade),
                      _buildResultStat('Pass/Total',
                          '${summary.subjectsPassed}/${summary.totalSubjects}'),
                    ],
                  ),
                  const SizedBox(height: AppTheme.defaultSpacing),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Column(
        children: [
          _buildStatisticsExamSelector(),
          const SizedBox(height: AppTheme.defaultSpacing),
          if (_selectedExam != null)
            _buildClassStatisticsCard(),
        ],
      ),
    );
  }

  Widget _buildStatisticsExamSelector() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Statistics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            DropdownButtonFormField<Exam>(
              value: _selectedExam,
              decoration: InputDecoration(
                labelText: 'Select Exam',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                prefixIcon: const Icon(Icons.quiz),
              ),
              items: _exams.map((exam) {
                return DropdownMenuItem(
                  value: exam,
                  child: Text('${exam.name} (${exam.type.replaceAll('_', ' ').toUpperCase()})'),
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

  Widget _buildClassStatisticsCard() {
    if (_selectedExam == null) {
      return const SizedBox.shrink(); // Or a message indicating no exam selected
    }

    final classStats = _resultService.getClassStatistics(_selectedExam!.id);

    if (classStats['totalStudents'] == 0) {
      return Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: const Padding(
          padding: EdgeInsets.all(AppTheme.largeSpacing),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.bar_chart, size: 60, color: Colors.grey),
                SizedBox(height: AppTheme.mediumSpacing),
                Text(
                  'No statistics available for this exam yet.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Class Performance for ${_selectedExam!.name}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            _buildStatRow('Total Students', classStats['totalStudents'].toString()),
            _buildStatRow('Average Percentage', '${classStats['averagePercentage'].toStringAsFixed(1)}%'),
            _buildStatRow('Highest Marks', '${classStats['highestMarks'].toStringAsFixed(1)}%'),
            _buildStatRow('Lowest Marks', '${classStats['lowestMarks'].toStringAsFixed(1)}%'),
            _buildStatRow('Students Passed', classStats['passedStudents'].toString()),
            _buildStatRow('Students Failed', classStats['failedStudents'].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.smallSpacing / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      _isPassed = marks >= (widget.subject.maxMarks * 0.33);
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
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        side: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.smallSpacing),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.student.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Roll No: ${widget.student.rollNumber}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _marksController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Marks',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  ),
                ),
                onFieldSubmitted: (value) => _saveMarks(),
              ),
            ),
            const SizedBox(width: AppTheme.smallSpacing),
            Expanded(
              flex: 1,
              child: Text(
                _currentGrade,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getGradeColor(_currentGrade),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.smallSpacing),
            IconButton(
              icon: const Icon(Icons.save, color: AppTheme.primaryBlue),
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
