import 'package:flutter/material.dart';
import 'package:school/CommonLogic/tabBar.dart';
import 'package:school/customWidgets/pagesMainHeading.dart';
import 'package:school/model/studentAndMarksModel.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

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
    Subject('English', 'A', 88, Icons.book, AppThemeColor.primaryBlue),
    Subject('Science', 'A+', 92, Icons.science, Colors.green),
    Subject('History', 'B+', 82, Icons.history_edu, Colors.orange),
    Subject('Geography', 'A', 86, Icons.public, AppThemeColor.primaryBlue),
    Subject('Computer Science', 'A+', 94, Icons.computer, Colors.green),
    Subject('Physical Education', 'A', 89, Icons.sports, AppThemeColor.primaryBlue),
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
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              bottom: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              left: AppThemeResponsiveness.getSmallSpacing(context),
              right: AppThemeResponsiveness.getSmallSpacing(context),
            ),
            child: Column(
              children: [
                HeaderSection(
                  title: 'Subjects list',
                  icon: Icons.book_outlined,
                ),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: AppThemeResponsiveness.getMaxWidth(context),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppThemeColor.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Tab Bar
                        CustomTabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(text: 'Subject List'),
                            Tab(text: 'Grades and Results'),
                          ],
                          getSpacing: AppThemeResponsiveness.getDefaultSpacing,
                          getBorderRadius: AppThemeResponsiveness.getInputBorderRadius,
                          getFontSize: AppThemeResponsiveness.getTabFontSize,
                          backgroundColor: AppThemeColor.blue50,
                          selectedColor: AppThemeColor.primaryBlue,
                          unselectedColor: AppThemeColor.blue600,
                        ),

                        // Tab Content
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildSubjectListTab(context),
                              _buildGradesResultsTab(context),
                            ],
                          ),
                        ),

                        // Responsive Action Buttons
                        _buildActionButtons(context),
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



  Widget _buildSubjectListTab(BuildContext context) {
    return Column(
      children: [
        // Responsive Summary Card
        Container(
          margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppThemeColor.primaryBlue.withOpacity(0.1),
                AppThemeColor.primaryIndigo.withOpacity(0.1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
            border: Border.all(color: AppThemeColor.primaryBlue.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppThemeResponsiveness.isMobile(context)
              ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem(context, 'Total Subjects', '${subjects.length}', Icons.subject),
                  _buildSummaryItem(context, 'Average', '${_calculateAverage().toStringAsFixed(1)}%', Icons.trending_up),
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              _buildSummaryItem(context, 'Overall Grade', _getOverallGrade(), Icons.star),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(context, 'Total Subjects', '${subjects.length}', Icons.subject),
              _buildSummaryItem(context, 'Average', '${_calculateAverage().toStringAsFixed(1)}%', Icons.trending_up),
              _buildSummaryItem(context, 'Overall Grade', _getOverallGrade(), Icons.star),
            ],
          ),
        ),

        // Responsive Subject List
        Expanded(
          child: AppThemeResponsiveness.isDesktop(context) || AppThemeResponsiveness.isTablet(context)
              ? _buildSubjectGrid(context)
              : _buildSubjectList(context),
        ),
      ],
    );
  }

  Widget _buildSubjectGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getDefaultSpacing(context)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppThemeResponsiveness.getGridCrossAxisCount(context),
        crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: AppThemeResponsiveness.getGridChildAspectRatio(context),
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return _buildSubjectGridCard(context, subjects[index]);
      },
    );
  }

  Widget _buildSubjectList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getDefaultSpacing(context)),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(context, subjects[index]);
      },
    );
  }

  Widget _buildSubjectGridCard(BuildContext context, Subject subject) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showSubjectDetails(context, subject),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getGridItemPadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context)),
                decoration: BoxDecoration(
                  color: AppThemeColor.blue50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  subject.icon,
                  color: AppThemeColor.primaryBlue,
                  size: AppThemeResponsiveness.getGridItemIconSize(context),
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Text(
                subject.name,
                style: AppThemeResponsiveness.getGridItemTitleStyle(context),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                '${subject.percentage}%',
                style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: subject.gradeColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  subject.grade,
                  style: TextStyle(
                    color: AppThemeColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildGradesResultsTab(BuildContext context) {
    return Column(
      children: [
        // Responsive Overall Performance Card
        Container(
          margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          decoration: BoxDecoration(
            color: AppThemeColor.blue50,
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
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
              Text(
                'Academic Performance Overview',
                style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(color: Colors.black87),
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              AppThemeResponsiveness.isMobile(context)
                  ? Row(
                    children: [
                      _buildPerformanceMetric(context, 'Current GPA', '3.7/4.0', Icons.school, Colors.green),
                      SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
                      _buildPerformanceMetric(context, 'Class Rank', '12/45', Icons.emoji_events, Colors.orange),
                    ],
                  )
                  : Row(
                children: [
                  Expanded(
                    child: _buildPerformanceMetric(context, 'Current GPA', '3.7/4.0', Icons.school, Colors.green),
                  ),
                  SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                  Expanded(
                    child: _buildPerformanceMetric(context, 'Class Rank', '12/45', Icons.emoji_events, Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Responsive Exam Results List
        Expanded(
          child: AppThemeResponsiveness.isDesktop(context)
              ? _buildExamResultsGrid(context)
              : _buildExamResultsList(context),
        ),

        // Responsive Progress Chart Section
        _buildProgressChart(context),
      ],
    );
  }

  Widget _buildExamResultsGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getDefaultSpacing(context)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: 1.8,
      ),
      itemCount: examResults.length,
      itemBuilder: (context, index) {
        return _buildExamResultGridCard(context, examResults[index]);
      },
    );
  }

  Widget _buildExamResultsList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getDefaultSpacing(context)),
      itemCount: examResults.length,
      itemBuilder: (context, index) {
        return _buildExamResultCard(context, examResults[index]);
      },
    );
  }

  Widget _buildExamResultGridCard(BuildContext context, ExamResult result) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
                  decoration: BoxDecoration(
                    color: _getGradeColor(result.grade).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.assignment,
                    color: _getGradeColor(result.grade),
                    size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getGradeColor(result.grade),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    result.grade,
                    style: TextStyle(
                      color: AppThemeColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
            Text(
              result.examName,
              style: AppThemeResponsiveness.getHeadingStyle(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              result.date,
              style: AppThemeResponsiveness.getSubHeadingStyle(context),
            ),
            const Spacer(),
            Text(
              'Score: ${result.percentage}%',
              style: AppThemeResponsiveness.getStatValueStyle(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
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
          Text(
            'Performance Trend',
            style: AppThemeResponsiveness.getHeadingStyle(context),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          Container(
            height: AppThemeResponsiveness.isMobile(context) ? 60 : 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppThemeColor.primaryBlue.withOpacity(0.3),
                  AppThemeColor.primaryIndigo.withOpacity(0.3)
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '📈 Showing consistent improvement',
                style: TextStyle(
                  fontSize: AppThemeResponsiveness.getBodyTextStyle(context).fontSize! + 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppThemeColor.primaryBlue,
          size: AppThemeResponsiveness.getHeaderIconSize(context),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Text(
          value,
          style: AppThemeResponsiveness.getStatValueStyle(context),
        ),
        Text(
          title,
          style: AppThemeResponsiveness.getStatTitleStyle(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPerformanceMetric(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: AppThemeResponsiveness.getIconSize(context),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Text(
            value,
            style: TextStyle(
              fontSize: AppThemeResponsiveness.getStatValueStyle(context).fontSize,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppThemeResponsiveness.getStatTitleStyle(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, Subject subject) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
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
        contentPadding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
        leading: Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
          decoration: BoxDecoration(
            color: AppThemeColor.blue50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            subject.icon,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getDashboardCardIconSize(context),
          ),
        ),
        title: Text(
          subject.name,
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Percentage: ${subject.percentage}%',
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: subject.percentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(subject.gradeColor),
                minHeight: AppThemeResponsiveness.isMobile(context) ? 4 : 6,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: AppThemeResponsiveness.getStatusBadgePadding(context),
          decoration: BoxDecoration(
            color: subject.gradeColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            subject.grade,
            style: TextStyle(
              color: AppThemeColor.white,
              fontWeight: FontWeight.bold,
              fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
            ),
          ),
        ),
        onTap: () {
          _showSubjectDetails(context, subject);
        },
      ),
    );
  }

  Widget _buildExamResultCard(BuildContext context, ExamResult result) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
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
        contentPadding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
        leading: Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
          decoration: BoxDecoration(
            color: _getGradeColor(result.grade).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.assignment,
            color: _getGradeColor(result.grade),
            size: AppThemeResponsiveness.getDashboardCardIconSize(context),
          ),
        ),
        title: Text(
          result.examName,
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              result.date,
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Score: ${result.percentage}%',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppThemeResponsiveness.getBodyTextStyle(context).fontSize,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: AppThemeResponsiveness.getStatusBadgePadding(context),
          decoration: BoxDecoration(
            color: _getGradeColor(result.grade),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            result.grade,
            style: TextStyle(
              color: AppThemeColor.white,
              fontWeight: FontWeight.bold,
              fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      child: AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context)
          ? Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading mark sheet...')),
                );
              },
              icon: Icon(
                Icons.download,
                color: AppThemeColor.white,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              label: Text('Download', style: AppThemeResponsiveness.getButtonTextStyle(context)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeColor.primaryBlue,
                elevation: AppThemeResponsiveness.getButtonElevation(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          SizedBox(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sharing report...')),
                );
              },
              icon: Icon(
                Icons.share,
                color: AppThemeColor.primaryBlue,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              label: Text(
                'Share',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  color: AppThemeColor.primaryBlue,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppThemeColor.primaryBlue,
                  width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
              ),
            ),
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: SizedBox(
              height: AppThemeResponsiveness.getButtonHeight(context),
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading mark sheet...')),
                  );
                },
                icon: Icon(
                  Icons.download,
                  color: AppThemeColor.white,
                  size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                ),
                label: Text('Download', style: AppThemeResponsiveness.getButtonTextStyle(context)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeColor.primaryBlue,
                  elevation: AppThemeResponsiveness.getButtonElevation(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: SizedBox(
              height: AppThemeResponsiveness.getButtonHeight(context),
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing report...')),
                  );
                },
                icon: Icon(
                  Icons.share,
                  color: AppThemeColor.primaryBlue,
                  size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                ),
                label: Text(
                  'Share Report',
                  style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                    color: AppThemeColor.primaryBlue,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppThemeColor.primaryBlue,
                    width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Helper methods (assuming these are part of your AppThemeResponsiveness or separate utils)
  // These are placeholders based on their usage in the provided snippet.
  // You would need to define Subject, ExamResult classes, and AppThemeResponsiveness methods.

  double _calculateAverage() {
    if (subjects.isEmpty) return 0.0;
    double totalPercentage = subjects.fold(0.0, (sum, item) => sum + item.percentage);
    return totalPercentage / subjects.length;
  }

  String _getOverallGrade() {
    double average = _calculateAverage();
    if (average >= 90) {
      return 'A+';
    } else if (average >= 80) {
      return 'A';
    } else if (average >= 70) {
      return 'B+';
    } else if (average >= 60) {
      return 'B';
    } else {
      return 'C';
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green;
      case 'A':
        return AppThemeColor.primaryBlue;
      case 'B+':
        return Colors.orange;
      case 'B':
        return Colors.orange;
      case 'C':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showSubjectDetails(BuildContext context, Subject subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(subject.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Grade: ${subject.grade}'),
              Text('Percentage: ${subject.percentage}%'),
              // Add more details if available in Subject class
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

