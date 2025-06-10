import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class ReportsAnalyticsPage extends StatelessWidget {
  const ReportsAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final crossAxisCount = isTablet ? 3 : 2;

    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight - MediaQuery.of(context).padding.top - kToolbarHeight,
              ),
              child: Column(
                children: [
                  SizedBox(height: AppTheme.smallSpacing ?? 8),

                  // Header Section
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultSpacing ?? 16,
                    ),
                    padding: EdgeInsets.all(AppTheme.mediumSpacing ?? 12),
                    decoration: BoxDecoration(
                      color: AppTheme.white ?? Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppTheme.cardBorderRadius ?? 12,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reports & Analytics',
                                style: TextStyle(
                                  fontSize: isTablet ? 24 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryBlue ?? Colors.blue,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Generate and view detailed reports',
                                style: TextStyle(
                                  fontSize: isTablet ? 16 : 14,
                                  color: Colors.grey.shade600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.analytics,
                          color: AppTheme.primaryBlue ?? Colors.blue,
                          size: isTablet ? 32 : 28,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppTheme.defaultSpacing ?? 16),

                  // Content
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultSpacing ?? 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.white ?? Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppTheme.cardBorderRadius ?? 12,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.defaultSpacing ?? 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Reports Grid
                          SizedBox(
                            height: isTablet ? 400 : 320,
                            child: GridView.count(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: AppTheme.mediumSpacing ?? 12,
                              mainAxisSpacing: AppTheme.mediumSpacing ?? 12,
                              childAspectRatio: _calculateAspectRatio(screenWidth, isTablet),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _buildReportCard(
                                  title: 'Attendance Summary',
                                  subtitle: 'Daily & Monthly Reports',
                                  icon: Icons.calendar_today,
                                  color: AppTheme.primaryBlue ?? Colors.blue,
                                  onTap: () => _navigateToAttendanceReport(context),
                                ),
                                _buildReportCard(
                                  title: 'Financial Reports',
                                  subtitle: 'Income & Expense Analysis',
                                  icon: Icons.trending_up,
                                  color: Colors.green.shade600,
                                  onTap: () => _navigateToFinancialReport(context),
                                ),
                                _buildReportCard(
                                  title: 'Fee Collection',
                                  subtitle: 'Payment Status & Due',
                                  icon: Icons.payment,
                                  color: Colors.orange.shade600,
                                  onTap: () => _navigateToFeeCollectionReport(context),
                                ),
                                _buildReportCard(
                                  title: 'Student Analytics',
                                  subtitle: 'Performance Overview',
                                  icon: Icons.bar_chart,
                                  color: AppTheme.primaryPurple ?? Colors.purple,
                                  onTap: () => _navigateToStudentAnalytics(context),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AppTheme.mediumSpacing ?? 12),

                          // Quick Actions Section
                          Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: isTablet ? 20 : 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryPurple ?? Colors.purple,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          SizedBox(height: AppTheme.mediumSpacing ?? 12),

                          // Responsive button layout
                          if (isTablet)
                            Row(
                              children: [
                                Expanded(
                                  child: _buildActionButton(
                                    title: 'Export All Reports',
                                    icon: Icons.download,
                                    onPressed: () => _exportAllReports(context),
                                  ),
                                ),
                                SizedBox(width: AppTheme.mediumSpacing ?? 12),
                                Expanded(
                                  child: _buildActionButton(
                                    title: 'Email Reports',
                                    icon: Icons.email,
                                    onPressed: () => _emailReports(context),
                                  ),
                                ),
                                SizedBox(width: AppTheme.mediumSpacing ?? 12),
                                Expanded(
                                  child: _buildActionButton(
                                    title: 'Schedule Reports',
                                    icon: Icons.schedule,
                                    onPressed: () => _scheduleReports(context),
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildActionButton(
                                        title: 'Export All',
                                        icon: Icons.download,
                                        onPressed: () => _exportAllReports(context),
                                      ),
                                    ),
                                    SizedBox(width: AppTheme.mediumSpacing ?? 12),
                                    Expanded(
                                      child: _buildActionButton(
                                        title: 'Email Reports',
                                        icon: Icons.email,
                                        onPressed: () => _emailReports(context),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppTheme.smallSpacing ?? 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: _buildActionButton(
                                    title: 'Schedule Reports',
                                    icon: Icons.schedule,
                                    onPressed: () => _scheduleReports(context),
                                  ),
                                ),
                              ],
                            ),

                          SizedBox(height: AppTheme.defaultSpacing ?? 16),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: AppTheme.defaultSpacing ?? 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateAspectRatio(double screenWidth, bool isTablet) {
    if (isTablet) {
      return screenWidth > 800 ? 1.3 : 1.2;
    } else {
      return screenWidth > 400 ? 1.15 : 1.0;
    }
  }

  Widget _buildReportCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth > 600;

        return Card(
          elevation: AppTheme.cardElevation ?? 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppTheme.cardBorderRadius ?? 12,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              AppTheme.cardBorderRadius ?? 12,
            ),
            child: Container(
              padding: EdgeInsets.all(
                isTablet ? (AppTheme.defaultSpacing ?? 16) : (AppTheme.mediumSpacing ?? 12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(isTablet ? 14 : 10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      size: isTablet ? 32 : 28,
                      color: color,
                    ),
                  ),
                  SizedBox(height: AppTheme.smallSpacing ?? 8),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontFamily: 'Roboto',
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 2),
                  Flexible(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isTablet ? 12 : 10,
                        color: Colors.grey.shade600,
                        fontFamily: 'Roboto',
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth > 600;

        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: AppTheme.white ?? Colors.white,
            size: isTablet ? 18 : 16,
          ),
          label: Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: AppTheme.white ?? Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: isTablet ? 14 : 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue ?? Colors.blue,
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 14 : 10,
              horizontal: isTablet ? 16 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppTheme.buttonBorderRadius ?? 8,
              ),
            ),
            elevation: AppTheme.buttonElevation ?? 2,
          ),
        );
      },
    );
  }

  // Navigation methods
  void _navigateToAttendanceReport(BuildContext context) {
    // Navigate to attendance report page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Attendance Summary...')),
    );
  }

  void _emailReports(BuildContext context) {
    // TODO: Implement email logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preparing email reports...')),
    );
  }

  void _navigateToFinancialReport(BuildContext context) {
    // Navigate to financial report page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Financial Reports...')),
    );
  }

  void _navigateToFeeCollectionReport(BuildContext context) {
    // Navigate to fee collection report page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Fee Collection Reports...')),
    );
  }

  void _navigateToStudentAnalytics(BuildContext context) {
    // Navigate to student analytics page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Student Analytics...')),
    );
  }

  void _exportAllReports(BuildContext context) {
    // Export all reports functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting all reports...')),
    );
  }

  void _scheduleReports(BuildContext context) {
    // Schedule reports functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening report scheduler...')),
    );
  }
}