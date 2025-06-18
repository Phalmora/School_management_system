import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:school/model/schoolInfo.dart';

class AboutSchool extends StatefulWidget {
  const AboutSchool({super.key});

  @override
  State<AboutSchool> createState() => _AboutSchoolState();
}

class _AboutSchoolState extends State<AboutSchool> {
  final ScrollController _scrollController = ScrollController();

  // School data - replace with your actual school information
  final SchoolInfo schoolInfo = SchoolInfo(
    name: "Sunrise Academy",
    established: "1985",
    motto: "Excellence in Education, Character in Life",
    vision: "To nurture young minds and develop future leaders who contribute positively to society through innovative education and strong moral values.",
    mission: "We are committed to providing a comprehensive, student-centered education that promotes academic excellence, critical thinking, creativity, and character development in a safe and supportive environment.",
    principalName: "Dr. Sarah Johnson",
    principalMessage: "Welcome to Sunrise Academy, where every student's potential is recognized and nurtured. We believe in creating an environment where academic excellence meets character development.",
    totalStudents: "1,200+",
    totalTeachers: "85",
    campusSize: "15 acres",
    establishmentYear: "1985",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),

            // Content Section
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppTheme.getMaxWidth(context),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: AppTheme.getScreenPadding(context),
                  child: Column(
                    children: [
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildSchoolOverviewCard(context),
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildVisionMissionCard(context),
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildPrincipalMessageCard(context),
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildStatsCard(context),
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildFacilitiesCard(context),
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildAchievementsCard(context),
                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
                      _buildContactCard(context),
                      SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: AppTheme.getCardPadding(context),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppTheme.getMediumSpacing(context)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
            ),
            child: Icon(
              Icons.school,
              color: AppTheme.white,
              size: AppTheme.getHeaderIconSize(context),
            ),
          ),
          SizedBox(width: AppTheme.getDefaultSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Our School',
                  style: AppTheme.getFontStyle(context),
                ),
                Text(
                  'Discover our story and values',
                  style: AppTheme.getSplashSubtitleStyle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolOverviewCard(BuildContext context) {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Container(
        padding: AppTheme.getCardPadding(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
          gradient: LinearGradient(
            colors: [AppTheme.blue50, AppTheme.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance,
                  color: AppTheme.blue800,
                  size: AppTheme.getIconSize(context),
                ),
                SizedBox(width: AppTheme.getMediumSpacing(context)),
                Expanded(
                  child: Text(
                    schoolInfo.name,
                    style: AppTheme.getHeadingStyle(context).copyWith(
                      fontSize: AppTheme.isMobile(context) ? 20.0 : (AppTheme.isTablet(context) ? 22.0 : 24.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.getMediumSpacing(context)),
            Container(
              padding: AppTheme.getStatusBadgePadding(context),
              decoration: BoxDecoration(
                color: AppTheme.blue100,
                borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
              ),
              child: Text(
                'Established ${schoolInfo.established}',
                style: TextStyle(
                  color: AppTheme.blue800,
                  fontWeight: FontWeight.w600,
                  fontSize: AppTheme.getStatusBadgeFontSize(context),
                ),
              ),
            ),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),
            Text(
              schoolInfo.motto,
              style: AppTheme.getSubHeadingStyle(context).copyWith(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisionMissionCard(BuildContext context) {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, Icons.visibility, 'Vision & Mission'),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            // Vision Section
            Container(
              padding: AppTheme.getCardPadding(context),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.green.shade700,
                        size: AppTheme.getIconSize(context) * 0.8,
                      ),
                      SizedBox(width: AppTheme.getSmallSpacing(context)),
                      Text(
                        'Our Vision',
                        style: AppTheme.getHeadingStyle(context).copyWith(
                          color: Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.getSmallSpacing(context)),
                  Text(
                    schoolInfo.vision,
                    style: AppTheme.getBodyTextStyle(context).copyWith(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppTheme.getMediumSpacing(context)),

            // Mission Section
            Container(
              padding: AppTheme.getCardPadding(context),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flag,
                        color: Colors.orange.shade700,
                        size: AppTheme.getIconSize(context) * 0.8,
                      ),
                      SizedBox(width: AppTheme.getSmallSpacing(context)),
                      Text(
                        'Our Mission',
                        style: AppTheme.getHeadingStyle(context).copyWith(
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.getSmallSpacing(context)),
                  Text(
                    schoolInfo.mission,
                    style: AppTheme.getBodyTextStyle(context).copyWith(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrincipalMessageCard(BuildContext context) {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, Icons.person, 'Principal\'s Message'),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: AppTheme.isMobile(context) ? 25 : (AppTheme.isTablet(context) ? 30 : 35),
                  backgroundColor: AppTheme.blue100,
                  child: Icon(
                    Icons.person,
                    size: AppTheme.getHeaderIconSize(context),
                    color: AppTheme.blue800,
                  ),
                ),
                SizedBox(width: AppTheme.getDefaultSpacing(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schoolInfo.principalName,
                        style: AppTheme.getHeadingStyle(context),
                      ),
                      Text(
                        'Principal',
                        style: AppTheme.getSubHeadingStyle(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            Container(
              padding: AppTheme.getCardPadding(context),
              decoration: BoxDecoration(
                color: AppTheme.greylight,
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                border: Border.all(color: AppTheme.greydark),
              ),
              child: Text(
                '"${schoolInfo.principalMessage}"',
                style: AppTheme.getBodyTextStyle(context).copyWith(
                  color: Colors.grey.shade700,
                  height: 1.4,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final stats = [
      StatItem(icon: Icons.groups, label: 'Students', value: schoolInfo.totalStudents),
      StatItem(icon: Icons.person_outline, label: 'Teachers', value: schoolInfo.totalTeachers),
      StatItem(icon: Icons.landscape, label: 'Campus', value: schoolInfo.campusSize),
      StatItem(icon: Icons.calendar_today, label: 'Since', value: schoolInfo.establishmentYear),
    ];

    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, Icons.bar_chart, 'School Statistics'),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppTheme.getGridCrossAxisCount(context),
                childAspectRatio: AppTheme.isMobile(context) ? 1.0 : (AppTheme.isTablet(context) ? 1.1 : 1.2),
                crossAxisSpacing: AppTheme.getMediumSpacing(context),
                mainAxisSpacing: AppTheme.getMediumSpacing(context),
              ),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];
                return Container(
                  padding: AppTheme.getCardPadding(context),
                  decoration: BoxDecoration(
                    color: AppTheme.blue50,
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    border: Border.all(color: AppTheme.blue100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        stat.icon,
                        color: AppTheme.blue800,
                        size: AppTheme.getStatIconSize(context),
                      ),
                      SizedBox(height: AppTheme.getSmallSpacing(context)),
                      Text(
                        stat.value,
                        style: AppTheme.getStatValueStyle(context),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        stat.label,
                        style: AppTheme.getCaptionTextStyle(context),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilitiesCard(BuildContext context) {
    final facilities = [
      'Modern Classrooms with Smart Boards',
      'Science & Computer Laboratories',
      'Library with 10,000+ Books',
      'Sports Complex & Playground',
      'Auditorium & Music Room',
      'Cafeteria & Medical Room',
    ];

    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, Icons.domain, 'School Facilities'),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            ...facilities.map((facility) => Padding(
              padding: EdgeInsets.only(bottom: AppTheme.getMediumSpacing(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                    size: AppTheme.getIconSize(context) * 0.8,
                  ),
                  SizedBox(width: AppTheme.getMediumSpacing(context)),
                  Expanded(
                    child: Text(
                      facility,
                      style: AppTheme.getBodyTextStyle(context).copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsCard(BuildContext context) {
    final achievements = [
      'CBSE Board Excellence Award 2023',
      'State Level Science Fair Winner',
      'Best School Infrastructure Award',
      'Environmental Sustainability Certificate',
    ];

    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, Icons.emoji_events, 'Recent Achievements'),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            ...achievements.map((achievement) => Padding(
              padding: EdgeInsets.only(bottom: AppTheme.getMediumSpacing(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade600,
                    size: AppTheme.getIconSize(context) * 0.8,
                  ),
                  SizedBox(width: AppTheme.getMediumSpacing(context)),
                  Expanded(
                    child: Text(
                      achievement,
                      style: AppTheme.getBodyTextStyle(context).copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, Icons.contact_mail, 'Contact Information'),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),

            _buildContactItem(context, Icons.location_on, 'Address', '123 Education Street, Knowledge City, State 12345'),
            _buildContactItem(context, Icons.phone, 'Phone', '+1 (555) 123-4567'),
            _buildContactItem(context, Icons.email, 'Email', 'info@sunriseacademy.edu'),
            _buildContactItem(context, Icons.web, 'Website', 'www.sunriseacademy.edu'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.blue800,
          size: AppTheme.getIconSize(context),
        ),
        SizedBox(width: AppTheme.getMediumSpacing(context)),
        Expanded(
          child: Text(
            title,
            style: AppTheme.getHeadingStyle(context),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.getMediumSpacing(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppTheme.blue600,
            size: AppTheme.getIconSize(context) * 0.8,
          ),
          SizedBox(width: AppTheme.getMediumSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.getCaptionTextStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppTheme.getSmallSpacing(context) / 2),
                Text(
                  value,
                  style: AppTheme.getBodyTextStyle(context).copyWith(
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
