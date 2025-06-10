import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class ParentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      drawer: _buildModernDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(),
                SizedBox(height: 24),
                _buildChildrenOverview(),
                SizedBox(height: 24),
                _buildQuickStatsSection(),
                SizedBox(height: 32),
                _buildSectionTitle('Quick Access'),
                SizedBox(height: 16),
                _buildDashboardGrid(context),
                SizedBox(height: 24),
                _buildRecentUpdatesSection(),
                SizedBox(height: 24),
                _buildUpcomingEventsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Column(
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  children: [
                    _buildDrawerSection('Main', [
                      _buildDrawerItem(context, Icons.dashboard_rounded, 'Dashboard', '/parent-dashboard'),
                      _buildDrawerItem(context, Icons.person_rounded, 'My Profile', '/parent-profile'),
                      _buildDrawerItem(context, Icons.child_care_rounded, 'My Children', '/children-overview'),
                    ]),
                    _buildDrawerSection('Academic Monitoring', [
                      _buildDrawerItem(context, Icons.grade_rounded, 'Academic Performance', '/academic-performance'),
                      _buildDrawerItem(context, Icons.schedule_rounded, 'Time Tables', '/children-timetables'),
                      _buildDrawerItem(context, Icons.assignment_rounded, 'Homework & Assignments', '/homework-tracking'),
                      _buildDrawerItem(context, Icons.calendar_today_rounded, 'Attendance Tracking', '/attendance-overview'),
                    ]),
                    _buildDrawerSection('Communication', [
                      _buildDrawerItem(context, Icons.notifications_active_rounded, 'School Notices', '/school-notices', badge: '5'),
                      _buildDrawerItem(context, Icons.message_rounded, 'Teacher Messages', '/teacher-messages', badge: '2'),
                      _buildDrawerItem(context, Icons.announcement_rounded, 'Announcements', '/parent-announcements'),
                    ]),
                    _buildDrawerSection('Financial', [
                      _buildDrawerItem(context, Icons.payment_rounded, 'Fee Management', '/parent-fee-management'),
                      _buildDrawerItem(context, Icons.receipt_long_rounded, 'Payment History', '/payment-history'),
                      _buildDrawerItem(context, Icons.account_balance_wallet_rounded, 'Pending Dues', '/pending-dues'),
                    ]),
                    _buildDrawerSection('School Life', [
                      _buildDrawerItem(context, Icons.event_rounded, 'School Events', '/school-events'),
                      _buildDrawerItem(context, Icons.groups_rounded, 'Parent Community', '/parent-community'),
                      _buildDrawerItem(context, Icons.school_rounded, 'School Information', '/school-info'),
                    ]),
                    _buildDrawerSection('Support', [
                      _buildDrawerItem(context, Icons.support_agent_rounded, 'Help & Support', '/parent-support'),
                      _buildDrawerItem(context, Icons.feedback_rounded, 'Feedback', '/parent-feedback'),
                    ]),
                    Divider(height: 32, thickness: 1),
                    _buildDrawerItem(context, Icons.settings_rounded, 'Settings', '/parent-settings'),
                    _buildDrawerItem(context, Icons.lock_rounded, 'Change Password', '/change-password'),
                    _buildDrawerItem(
                      context,
                      Icons.logout_rounded,
                      'Logout',
                      null,
                      onTap: () => _showLogoutDialog(context),
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'parent_avatar',
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.family_restroom_rounded, size: 45, color: Colors.indigo.shade600),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Parent Portal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Sarah Johnson • 2 Children',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items,
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDrawerItem(
      BuildContext context,
      IconData icon,
      String title,
      String? route, {
        VoidCallback? onTap,
        String? badge,
        bool isDestructive = false,
      }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.shade50
                : Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDestructive
                ? Colors.red.shade600
                : Colors.indigo.shade600,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red.shade700 : Colors.grey.shade800,
          ),
        ),
        trailing: badge != null
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red.shade500,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badge,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap ?? () {
          if (route != null) {
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Hero(
            tag: 'parent_avatar',
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.purple.shade400],
                ),
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.family_restroom_rounded,
                  size: 40,
                  color: Colors.indigo.shade600,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Sarah Johnson',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.child_care, size: 14, color: Colors.indigo.shade700),
                          SizedBox(width: 4),
                          Text(
                            '2 Children',
                            style: TextStyle(
                              color: Colors.indigo.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_user, size: 14, color: Colors.green.shade700),
                          SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildrenOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('My Children'),
        SizedBox(height: 16),
        Container(
          height: 151,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildChildCard('Emma Johnson', 'Class 10-A', 'Roll: 15', Icons.girl, Colors.pink, 94.5, 'A+'),
              _buildChildCard('Jake Johnson', 'Class 7-B', 'Roll: 23', Icons.boy, Colors.blue, 91.2, 'A'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChildCard(String name, String className, String rollNo, IconData icon, Color color, double attendance, String grade) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  grade,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            className,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            rollNo,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: Colors.blue.shade600),
              SizedBox(width: 4),
              Text(
                '${attendance.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Overview'),
        SizedBox(height: 16),
        Row(
          children: [
            _buildQuickStat('Messages', '7', Icons.message_rounded,
                Colors.orange, Colors.orange.shade50),
            SizedBox(width: 12),
            _buildQuickStat('Pending Fees', '₹5,500', Icons.payment_rounded,
                Colors.red, Colors.red.shade50),
            SizedBox(width: 12),
            _buildQuickStat('Events', '3', Icons.event_rounded,
                Colors.purple, Colors.purple.shade50),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStat(String title, String value, IconData icon, Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    final items = [
      _DashboardItem('Academic Performance', Icons.grade_rounded, Colors.purple,
              () => Navigator.pushNamed(context, '/academic-performance'), 'View grades & progress', badge: null),
      _DashboardItem('Fee Management', Icons.payment_rounded, Colors.green,
              () => Navigator.pushNamed(context, '/parent-fee-management'), 'Payments & dues'),
      _DashboardItem('Attendance', Icons.calendar_today_rounded, Colors.blue,
              () => Navigator.pushNamed(context, '/attendance-overview'), 'Track daily attendance'),
      _DashboardItem('Messages', Icons.message_rounded, Colors.orange,
              () => Navigator.pushNamed(context, '/teacher-messages'), 'Teacher communications', badge: '2'),
      _DashboardItem('School Events', Icons.event_rounded, Colors.indigo,
              () => Navigator.pushNamed(context, '/school-events'), 'Upcoming activities'),
      _DashboardItem('Homework', Icons.assignment_rounded, Colors.teal,
              () => Navigator.pushNamed(context, '/homework-tracking'), 'Track assignments'),
      _DashboardItem('Time Tables', Icons.schedule_rounded, Colors.cyan,
              () => Navigator.pushNamed(context, '/children-timetables'), 'Class schedules'),
      _DashboardItem('Parent Community', Icons.groups_rounded, Colors.pink,
              () => Navigator.pushNamed(context, '/parent-community'), 'Connect with parents'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _buildDashboardCard(items[index]),
    );
  }

  Widget _buildDashboardCard(_DashboardItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(item.icon, size: 32, color: item.color),
                    ),
                    SizedBox(height: 16),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
                if (item.badge != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade500,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.badge!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildRecentUpdatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recent Updates'),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildUpdateItem(
                Icons.grade_rounded,
                'Emma scored 95% in Math Test',
                '2 hours ago',
                Colors.green,
                'Academic',
              ),
              Divider(height: 24),
              _buildUpdateItem(
                Icons.message_rounded,
                'New message from Jake\'s Class Teacher',
                '4 hours ago',
                Colors.orange,
                'Communication',
              ),
              Divider(height: 24),
              _buildUpdateItem(
                Icons.event_rounded,
                'Parent-Teacher Meeting scheduled',
                '1 day ago',
                Colors.purple,
                'Event',
              ),
              Divider(height: 24),
              _buildUpdateItem(
                Icons.warning_rounded,
                'Emma absent today - Health Issue',
                '2 days ago',
                Colors.red,
                'Attendance',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateItem(IconData icon, String title, String time, Color color, String category) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 10,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Upcoming Events'),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildEventItem(
                'Parent-Teacher Meeting',
                'June 15, 2025',
                '10:00 AM - 2:00 PM',
                Colors.blue,
                Icons.people_rounded,
              ),
              Divider(height: 24),
              _buildEventItem(
                'Annual Sports Day',
                'June 20, 2025',
                '9:00 AM - 4:00 PM',
                Colors.orange,
                Icons.sports_rounded,
              ),
              Divider(height: 24),
              _buildEventItem(
                'Science Exhibition',
                'June 25, 2025',
                '11:00 AM - 3:00 PM',
                Colors.purple,
                Icons.science_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventItem(String title, String date, String time, Color color, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                  SizedBox(width: 4),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                  SizedBox(width: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Logout'),
          content: Text('Are you sure you want to logout from Parent Portal?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String subtitle;
  final String? badge;

  _DashboardItem(this.title, this.icon, this.color, this.onTap, this.subtitle, {this.badge});
}