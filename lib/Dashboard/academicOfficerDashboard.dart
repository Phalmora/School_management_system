import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class academicOfficerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.school, size: 40, color: Colors.teal),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Academic Officer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Monitoring & Oversight',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            _buildDrawerItem(
              context,
              icon: Icons.dashboard,
              title: 'Dashboard',
              route: '/academic-officer-dashboard',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person_search,
              title: 'Teacher Performance',
              route: '/academic-officer-teacher-performance',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.class_,
              title: 'Classroom Reports',
              route: '/academic-officer-classroom-report',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.quiz,
              title: 'Exam Management',
              route: '/academic-officer-exam-management-screen',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.notifications_active,
              title: 'Notifications',
              route: '/academic-officer-notification',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.inbox,
              title: 'Inbox / Chat',
              route: '/inbox-chat',
            ),
            Divider(),
            _buildDrawerItem(
              context,
              icon: Icons.lock_outline,
              title: 'Change Password',
              route: '/change-password',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Welcome Card
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(
                          Icons.school,
                          size: 40,
                          color: Colors.teal.shade600,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Academic Officer!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Monitoring & Oversight Control'),
                          ],
                        ),
                      ),
                      // Notification Bell
                      IconButton(
                        icon: Stack(
                          children: [
                            Icon(Icons.notifications, size: 28, color: Colors.teal),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/notifications'),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Overview Statistics
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildStatCard('Classes Supervised', '12', Icons.class_, Colors.teal),
                    _buildStatCard('Pending Mark', '8', Icons.edit_note, Colors.orange),
                    _buildStatCard('Attendance Smry', '95%', Icons.check_circle, Colors.green),
                    _buildStatCard('Active Teachers', '24', Icons.person, Colors.blue),
                    _buildStatCard('Upcoming Exams', '3', Icons.quiz, Colors.purple),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text('Quick Access', style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              // Main Dashboard Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.1,
                  children: [

                    _buildDashboardCard(
                      'Teacher Performance',
                      Icons.person_search,
                      Colors.blue,
                          () => Navigator.pushNamed(context, '/academic-officer-teacher-performance'),
                    ),
                    _buildDashboardCard(
                      'Classroom Reports',
                      Icons.assessment,
                      Colors.green,
                          () => Navigator.pushNamed(context, '/academic-officer-classroom-report'),
                    ),
                    _buildDashboardCard(
                      'Exam Management',
                      Icons.quiz,
                      Colors.orange,
                          () => Navigator.pushNamed(context, '/academic-officer-exam-management-screen'),
                    ),
                    _buildDashboardCard(
                      'Send Notifications',
                      Icons.notifications_active,
                      Colors.purple,
                          () => Navigator.pushNamed(context, '/academic-officer-notification'),
                    ),
                    _buildDashboardCard(
                      'Attendance Reports',
                      Icons.fact_check,
                      Colors.indigo,
                          () => Navigator.pushNamed(context, '/attendance-reports'),
                    ),
                    _buildDashboardCard(
                      'Result Entry Status',
                      Icons.grade,
                      Colors.teal,
                          () => Navigator.pushNamed(context, '/result-entry-status'),
                    ),
                    _buildDashboardCard(
                      'Performance Analytics',
                      Icons.analytics,
                      Colors.red.shade700,
                          () => Navigator.pushNamed(context, '/performance-analytics'),
                    ),
                    _buildDashboardCard(
                      'Quick Actions',
                      Icons.flash_on,
                      Colors.amber.shade700,
                          () => _showQuickActionsDialog(context),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: 8),
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
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        String? route,
        VoidCallback? onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal.shade700),
      title: Text(title),
      onTap: onTap ??
              () {
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
    );
  }

  void _showQuickActionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.flash_on, color: Colors.amber),
              SizedBox(width: 8),
              Text('Quick Actions'),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.assignment_late, color: Colors.orange),
                  title: Text('Check Pending Entries'),
                  subtitle: Text('Review mark & attendance entries'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/pending-entries');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.lock_clock, color: Colors.red),
                  title: Text('Lock/Unlock Results'),
                  subtitle: Text('Manage result submission deadlines'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/lock-unlock-results');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.announcement, color: Colors.blue),
                  title: Text('Send Announcement'),
                  subtitle: Text('Notify teachers about deadlines'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/send-announcement');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.event, color: Colors.green),
                  title: Text('Schedule Exam'),
                  subtitle: Text('Set test dates and notify'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/schedule-exam');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.insights, color: Colors.purple),
                  title: Text('Generate Report'),
                  subtitle: Text('Class performance summary'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/generate-report');
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}