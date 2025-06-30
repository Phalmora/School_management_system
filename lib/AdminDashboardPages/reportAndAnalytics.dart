import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

class ReportsAnalyticsPage extends StatelessWidget {
  const ReportsAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: AppThemeResponsiveness.getScreenHeight(context) -
                    MediaQuery.of(context).padding.top -
                    AppThemeResponsiveness.getAppBarHeight(context),
              ),
              child: Column(
                children: [
                  SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),

                  // Header Section
                  Container(
                    margin: AppThemeResponsiveness.getHorizontalPadding(context),
                    padding: AppThemeResponsiveness.getCardPadding(context),
                    decoration: BoxDecoration(
                      color: AppThemeColor.white,
                      borderRadius: BorderRadius.circular(
                        AppThemeResponsiveness.getCardBorderRadius(context),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: AppThemeResponsiveness.getCardElevation(context),
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
                                style: AppThemeResponsiveness.getTitleTextStyle(context),
                              ),
                              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                              Text(
                                'Generate and view detailed reports',
                                style: AppThemeResponsiveness.getSubHeadingStyle(context),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                        Icon(
                          Icons.analytics,
                          color: AppThemeColor.primaryBlue,
                          size: AppThemeResponsiveness.getHeaderIconSize(context),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                  // Content Container
                  Container(
                    margin: AppThemeResponsiveness.getHorizontalPadding(context),
                    decoration: BoxDecoration(
                      color: AppThemeColor.white,
                      borderRadius: BorderRadius.circular(
                        AppThemeResponsiveness.getCardBorderRadius(context),
                      ),
                    ),
                    child: Padding(
                      padding: AppThemeResponsiveness.getCardPadding(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Reports Grid
                          GridView.count(
                            crossAxisCount: AppThemeResponsiveness.getDashboardGridCrossAxisCount(context),
                            crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
                            mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
                            childAspectRatio: AppThemeResponsiveness.getDashboardGridChildAspectRatio(context),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildReportCard(
                                context: context,
                                title: 'Attendance Summary',
                                icon: Icons.calendar_today,
                                color: AppThemeColor.primaryBlue,
                                onTap: () => _navigateToAttendanceReport(context),
                              ),
                              _buildReportCard(
                                context: context,
                                title: 'Financial Reports',
                                icon: Icons.trending_up,
                                color: Colors.green.shade600,
                                onTap: () => _navigateToFinancialReport(context),
                              ),
                              _buildReportCard(
                                context: context,
                                title: 'Fee Collection',
                                icon: Icons.payment,
                                color: Colors.orange.shade600,
                                onTap: () => _navigateToFeeCollectionReport(context),
                              ),
                              _buildReportCard(
                                context: context,
                                title: 'Student Analytics',
                                icon: Icons.bar_chart,
                                color: AppThemeColor.primaryIndigo,
                                onTap: () => _navigateToStudentAnalytics(context),
                              ),
                            ],
                          ),

                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          // Quick Actions Section
                          Text(
                            'Quick Actions',
                            style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                              color: AppThemeColor.primaryIndigo,
                            ),
                          ),
                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          _buildQuickActions(context),
                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: AppThemeResponsiveness.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        child: Container(
          height: 180, // ✅ Increased height to fix overflow
          padding: AppThemeResponsiveness.getDashboardCardPadding(context) > 20
              ? EdgeInsets.all(AppThemeResponsiveness.getDashboardCardPadding(context))
              : AppThemeResponsiveness.getCardPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    AppThemeResponsiveness.getResponsiveRadius(context, 10.0),
                  ),
                ),
                child: Icon(
                  icon,
                  size: AppThemeResponsiveness.getDashboardCardIconSize(context),
                  color: color,
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),

              // Title text
              Text(
                title,
                style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                  color: color,
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16.0),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),


            ],
          ),
        ),
      ),
    );
  }


  Widget _buildQuickActions(BuildContext context) {
    if (AppThemeResponsiveness.isTablet(context) || AppThemeResponsiveness.isDesktop(context)) {
      return Row(
        children: [
          Expanded(
            child: _buildActionButton(
              context: context,
              title: 'Export All Reports',
              icon: Icons.download,
              onPressed: () => _exportAllReports(context),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: _buildActionButton(
              context: context,
              title: 'Email Reports',
              icon: Icons.email,
              onPressed: () => _emailReports(context),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: _buildActionButton(
              context: context,
              title: 'Schedule Reports',
              icon: Icons.schedule,
              onPressed: () => _scheduleReports(context),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context: context,
                  title: AppThemeResponsiveness.isSmallPhone(context) ? 'Export' : 'Export All',
                  icon: Icons.download,
                  onPressed: () => _exportAllReports(context),
                ),
              ),
              SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
              Expanded(
                child: _buildActionButton(
                  context: context,
                  title: AppThemeResponsiveness.isSmallPhone(context) ? 'Email' : 'Email Reports',
                  icon: Icons.email,
                  onPressed: () => _emailReports(context),
                ),
              ),
            ],
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          SizedBox(
            width: double.infinity,
            child: _buildActionButton(
              context: context,
              title: 'Schedule Reports',
              icon: Icons.schedule,
              onPressed: () => _scheduleReports(context),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppThemeColor.white,
        size: AppThemeResponsiveness.getIconSize(context) * 0.8,
      ),
      label: Flexible(
        child: Text(
          title,
          style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
            fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 14.0),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeColor.primaryBlue,
        padding: EdgeInsets.symmetric(
          vertical: AppThemeResponsiveness.getDefaultSpacing(context) * 0.7,
          horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
        ),
        elevation: AppThemeResponsiveness.getButtonElevation(context),
        minimumSize: Size(0, AppThemeResponsiveness.getButtonHeight(context) * 0.8),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
          ),
          title: Text(
            title,
            style: AppThemeResponsiveness.getDialogTitleStyle(context),
          ),
          content: SizedBox(
            width: AppThemeResponsiveness.getDialogWidth(context),
            child: Text(
              content,
              style: AppThemeResponsiveness.getDialogContentStyle(context),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppThemeColor.primaryBlue,
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 14.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAttendanceReport(BuildContext context) {
    _showInfoDialog(
      context,
      'Attendance Summary',
      'Opening detailed attendance reports with daily and monthly analytics...',
    );
  }

  void _navigateToFinancialReport(BuildContext context) {
    _showInfoDialog(
      context,
      'Financial Reports',
      'Opening comprehensive financial analysis including income and expense breakdowns...',
    );
  }

  void _navigateToFeeCollectionReport(BuildContext context) {
    _showInfoDialog(
      context,
      'Fee Collection',
      'Opening fee collection reports with payment status and due amount details...',
    );
  }

  void _navigateToStudentAnalytics(BuildContext context) {
    _showInfoDialog(
      context,
      'Student Analytics',
      'Opening student performance analytics and comprehensive overview reports...',
    );
  }

  void _exportAllReports(BuildContext context) {
    _showInfoDialog(
      context,
      'Export Reports',
      'Preparing all reports for export. This may take a few moments...',
    );
  }

  void _emailReports(BuildContext context) {
    _showInfoDialog(
      context,
      'Email Reports',
      'Preparing reports for email delivery. Please configure your email settings...',
    );
  }

  void _scheduleReports(BuildContext context) {
    _showInfoDialog(
      context,
      'Schedule Reports',
      'Opening report scheduler to set up automated report generation...',
    );
  }
}
