import 'package:flutter/material.dart';
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/customWidgets/appBar.dart';


class TeacherPerformanceScreen extends StatefulWidget {
  const TeacherPerformanceScreen({Key? key}) : super(key: key);

  @override
  State<TeacherPerformanceScreen> createState() => _TeacherPerformanceScreenState();
}

class _TeacherPerformanceScreenState extends State<TeacherPerformanceScreen> {
  bool _isLoading = false;

  // Sample data - replace with actual API calls
  final List<AttendanceEntry> _attendanceEntries = [
    AttendanceEntry(
      className: 'Class 10-A',
      subject: 'Mathematics',
      date: DateTime.now().subtract(const Duration(days: 0)),
      status: AttendanceStatus.completed,
      studentsPresent: 28,
      totalStudents: 30,
    ),
    AttendanceEntry(
      className: 'Class 9-B',
      subject: 'Physics',
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: AttendanceStatus.pending,
      studentsPresent: 0,
      totalStudents: 32,
    ),
    AttendanceEntry(
      className: 'Class 10-C',
      subject: 'Mathematics',
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: AttendanceStatus.completed,
      studentsPresent: 25,
      totalStudents: 28,
    ),
  ];

  final List<ResultEntry> _resultEntries = [
    ResultEntry(
      examName: 'Mid-Term Exam',
      className: 'Class 10-A',
      subject: 'Mathematics',
      totalStudents: 30,
      resultsEntered: 30,
      status: ResultStatus.completed,
      deadline: DateTime.now().add(const Duration(days: 5)),
    ),
    ResultEntry(
      examName: 'Unit Test 2',
      className: 'Class 9-B',
      subject: 'Physics',
      totalStudents: 32,
      resultsEntered: 15,
      status: ResultStatus.inProgress,
      deadline: DateTime.now().add(const Duration(days: 2)),
    ),
    ResultEntry(
      examName: 'Final Exam',
      className: 'Class 10-C',
      subject: 'Mathematics',
      totalStudents: 28,
      resultsEntered: 0,
      status: ResultStatus.pending,
      deadline: DateTime.now().add(const Duration(days: 10)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: AppTheme.defaultSpacing, left: AppTheme.defaultSpacing, right: AppTheme.defaultSpacing),
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          const SizedBox(width: AppTheme.smallSpacing),
          const Text(
            'Teacher Performance',
            style: AppTheme.FontStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh, color: AppTheme.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(AppTheme.defaultSpacing),
            decoration: BoxDecoration(
              color: AppTheme.blue50,
              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
              ),
              labelColor: AppTheme.white,
              unselectedLabelColor: AppTheme.blue600,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Attendance Entry'),
                Tab(text: 'Result Entry Status'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildAttendanceTab(),
                _buildResultTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(
            title: 'Attendance Summary',
            completed: _attendanceEntries.where((e) => e.status == AttendanceStatus.completed).length,
            pending: _attendanceEntries.where((e) => e.status == AttendanceStatus.pending).length,
            icon: Icons.fact_check_outlined,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(height: AppTheme.defaultSpacing),
          Text(
            'Recent Attendance Entries',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.blue800,
            ),
          ),
          const SizedBox(height: AppTheme.smallSpacing),
          Expanded(
            child: ListView.builder(
              itemCount: _attendanceEntries.length,
              itemBuilder: (context, index) {
                return _buildAttendanceCard(_attendanceEntries[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(
            title: 'Result Entry Summary',
            completed: _resultEntries.where((e) => e.status == ResultStatus.completed).length,
            pending: _resultEntries.where((e) => e.status == ResultStatus.pending).length,
            icon: Icons.assignment_turned_in_outlined,
            color: AppTheme.primaryPurple,
          ),
          const SizedBox(height: AppTheme.defaultSpacing),
          const Text(
            'Result Entry Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: AppTheme.smallSpacing),
          Expanded(
            child: ListView.builder(
              itemCount: _resultEntries.length,
              itemBuilder: (context, index) {
                return _buildResultCard(_resultEntries[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required int completed,
    required int pending,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: AppTheme.mediumSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      _buildStatusChip('Completed: $completed', Colors.green),
                      const SizedBox(width: 10),
                      _buildStatusChip('Pending: $pending', Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(AttendanceEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.smallSpacing),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${entry.className} - ${entry.subject}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                _buildStatusBadge(entry.status),
              ],
            ),
            const SizedBox(height: AppTheme.smallSpacing),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  _formatDate(entry.date),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            if (entry.status == AttendanceStatus.completed) ...[
              const SizedBox(height: AppTheme.smallSpacing),
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 5),
                  Text(
                    'Present: ${entry.studentsPresent}/${entry.totalStudents}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(ResultEntry entry) {
    double progress = entry.totalStudents > 0 ? entry.resultsEntered / entry.totalStudents : 0;

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.smallSpacing),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.examName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                _buildResultStatusBadge(entry.status),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '${entry.className} - ${entry.subject}',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: AppTheme.smallSpacing),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  'Deadline: ${_formatDate(entry.deadline)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.smallSpacing),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress: ${entry.resultsEntered}/${entry.totalStudents}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          entry.status == ResultStatus.completed
                              ? Colors.green
                              : entry.status == ResultStatus.inProgress
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(AttendanceStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case AttendanceStatus.completed:
        color = Colors.green;
        text = 'Completed';
        icon = Icons.check_circle;
        break;
      case AttendanceStatus.pending:
        color = Colors.orange;
        text = 'Pending';
        icon = Icons.pending;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultStatusBadge(ResultStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case ResultStatus.completed:
        color = Colors.green;
        text = 'Completed';
        icon = Icons.check_circle;
        break;
      case ResultStatus.inProgress:
        color = Colors.orange;
        text = 'In Progress';
        icon = Icons.hourglass_empty;
        break;
      case ResultStatus.pending:
        color = Colors.red;
        text = 'Pending';
        icon = Icons.pending;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _refreshData() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}

// Data Models
class AttendanceEntry {
  final String className;
  final String subject;
  final DateTime date;
  final AttendanceStatus status;
  final int studentsPresent;
  final int totalStudents;

  AttendanceEntry({
    required this.className,
    required this.subject,
    required this.date,
    required this.status,
    required this.studentsPresent,
    required this.totalStudents,
  });
}

class ResultEntry {
  final String examName;
  final String className;
  final String subject;
  final int totalStudents;
  final int resultsEntered;
  final ResultStatus status;
  final DateTime deadline;

  ResultEntry({
    required this.examName,
    required this.className,
    required this.subject,
    required this.totalStudents,
    required this.resultsEntered,
    required this.status,
    required this.deadline,
  });
}

enum AttendanceStatus { completed, pending }
enum ResultStatus { completed, inProgress, pending }