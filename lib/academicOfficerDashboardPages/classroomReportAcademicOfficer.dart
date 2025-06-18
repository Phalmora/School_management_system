import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class ClassroomReportsScreen extends StatefulWidget {
  @override
  _ClassroomReportsScreenState createState() => _ClassroomReportsScreenState();
}

class _ClassroomReportsScreenState extends State<ClassroomReportsScreen> {
  // Sample data for classroom reports
  final List<ClassReport> classReports = [
    ClassReport(
      className: "Class 10-A",
      totalStudents: 35,
      averagePerformance: 85.5,
      absenteeRate: 12.0,
      topPerformer: "Sarah Johnson",
      recentActivity: "Math Quiz - 92% average",
      subject: "Mathematics",
    ),
    ClassReport(
      className: "Class 9-B",
      totalStudents: 32,
      averagePerformance: 78.2,
      absenteeRate: 8.5,
      topPerformer: "Michael Chen",
      recentActivity: "Science Project - 87% average",
      subject: "Science",
    ),
    ClassReport(
      className: "Class 8-C",
      totalStudents: 30,
      averagePerformance: 82.7,
      absenteeRate: 15.2,
      topPerformer: "Emma Davis",
      recentActivity: "English Essay - 79% average",
      subject: "English",
    ),
    ClassReport(
      className: "Class 11-A",
      totalStudents: 28,
      averagePerformance: 88.9,
      absenteeRate: 6.8,
      topPerformer: "Alex Rodriguez",
      recentActivity: "Physics Test - 91% average",
      subject: "Physics",
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
                  SizedBox(height: AppTheme.defaultSpacing,),
              Row(
                children: [
                  SizedBox(width: AppTheme.smallSpacing,),
                  Icon(
                    Icons.pending_actions,
                    size: 32.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: AppTheme.smallSpacing,),
                  Text('Classroom  Report', style: TextStyle(fontSize: 25, color: Colors.white),),

                ],
              ),
              // Reports List
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.defaultSpacing),
                  child: ListView.builder(
                    itemCount: classReports.length,
                    itemBuilder: (context, index) {
                      return _buildClassReportCard(classReports[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassReportCard(ClassReport report) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      child: Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getSubjectIcon(report.subject),
                      color: AppTheme.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.mediumSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.className,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${report.totalStudents} Students • ${report.subject}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showDetailedReport(report),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.defaultSpacing),

              // Performance Metrics
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Performance',
                      '${report.averagePerformance.toStringAsFixed(1)}%',
                      Icons.trending_up,
                      _getPerformanceColor(report.averagePerformance),
                    ),
                  ),
                  const SizedBox(width: AppTheme.smallSpacing),
                  Expanded(
                    child: _buildMetricCard(
                      'Absentee Rate',
                      '${report.absenteeRate.toStringAsFixed(1)}%',
                      Icons.person_off,
                      _getAbsenteeColor(report.absenteeRate),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.mediumSpacing),

              // Additional Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.blue50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Top Performer: ${report.topPerformer}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: AppTheme.blue600,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Recent: ${report.recentActivity}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSubjectIcon(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
        return Icons.calculate;
      case 'science':
        return Icons.science;
      case 'english':
        return Icons.menu_book;
      case 'physics':
        return Icons.electrical_services;
      default:
        return Icons.school;
    }
  }

  Color _getPerformanceColor(double performance) {
    if (performance >= 85) return Colors.green;
    if (performance >= 75) return Colors.orange;
    return Colors.red;
  }

  Color _getAbsenteeColor(double absenteeRate) {
    if (absenteeRate <= 5) return Colors.green;
    if (absenteeRate <= 10) return Colors.orange;
    return Colors.red;
  }

  void _showDetailedReport(ClassReport report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    '${report.className} Detailed Report',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),

            // Detailed content would go here
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Total Students', '${report.totalStudents}'),
                    _buildDetailRow('Average Performance', '${report.averagePerformance}%'),
                    _buildDetailRow('Absentee Rate', '${report.absenteeRate}%'),
                    _buildDetailRow('Top Performer', report.topPerformer),
                    _buildDetailRow('Subject', report.subject),
                    _buildDetailRow('Recent Activity', report.recentActivity),

                    const SizedBox(height: 20),
                    const Text(
                      'Performance Breakdown',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Performance indicators
                    _buildPerformanceIndicator('Excellent (90-100%)', 8, Colors.green),
                    _buildPerformanceIndicator('Good (80-89%)', 15, Colors.blue),
                    _buildPerformanceIndicator('Average (70-79%)', 10, Colors.orange),
                    _buildPerformanceIndicator('Below Average (<70%)', 2, Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceIndicator(String category, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(category),
          ),
          Text(
            '$count students',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ClassReport {
  final String className;
  final int totalStudents;
  final double averagePerformance;
  final double absenteeRate;
  final String topPerformer;
  final String recentActivity;
  final String subject;

  ClassReport({
    required this.className,
    required this.totalStudents,
    required this.averagePerformance,
    required this.absenteeRate,
    required this.topPerformer,
    required this.recentActivity,
    required this.subject,
  });
}