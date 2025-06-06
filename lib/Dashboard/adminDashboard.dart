import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class adminDashboard extends StatelessWidget {
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
                    child: Icon(Icons.admin_panel_settings, size: 40, color: Colors.blue),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Admin Panel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Full Control',
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
              route: '/admin-dashboard',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.people,
              title: 'Student Management',
              route: '/student-management',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.work,
              title: 'Employee Management',
              route: '/employee-management',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.class_,
              title: 'Class Management',
              route: '/class-management',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.payment,
              title: 'Fee Management',
              route: '/fee-management',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.grade,
              title: 'Academic Results',
              route: '/academic-results',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.analytics,
              title: 'Reports & Analytics',
              route: '/reports-analytics',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              title: 'System Controls',
              route: '/system-controls',
            ),
            Divider(),
            _buildDrawerItem(
              context,
              icon: Icons.lock,
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
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.admin_panel_settings,
                          size: 40,
                          color: Colors.blue.shade600,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Administrator!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Full System Control & Management'),
                          ],
                        ),
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
                    _buildStatCard('Total Students', '1,245', Icons.people, Colors.blue),
                    _buildStatCard('Total Teachers', '67', Icons.school, Colors.green),
                    _buildStatCard('Pending Admissions', '23', Icons.pending, Colors.orange),
                    _buildStatCard('Fee Collection', '₹2.3L', Icons.money, Colors.purple),
                    _buildStatCard('Active Notices', '5', Icons.notifications, Colors.red),
                  ],
                ),
              ),

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
                      'Student Management',
                      Icons.people,
                      Colors.blue,
                          () => Navigator.pushNamed(context, '/student-management'),
                    ),
                    _buildDashboardCard(
                      'Employee Management',
                      Icons.work,
                      Colors.green,
                          () => Navigator.pushNamed(context, '/employee-management'),
                    ),
                    _buildDashboardCard(
                      'Class & Section Management',
                      Icons.class_,
                      Colors.orange,
                          () => Navigator.pushNamed(context, '/class-management'),
                    ),
                    _buildDashboardCard(
                      'Fee Management',
                      Icons.payment,
                      Colors.purple,
                          () => Navigator.pushNamed(context, '/fee-management'),
                    ),
                    _buildDashboardCard(
                      'Academic Results',
                      Icons.grade,
                      Colors.indigo,
                          () => Navigator.pushNamed(context, '/academic-results'),
                    ),
                    _buildDashboardCard(
                      'Reports & Analytics',
                      Icons.analytics,
                      Colors.teal,
                          () => Navigator.pushNamed(context, '/reports-analytics'),
                    ),
                    _buildDashboardCard(
                      'System Controls',
                      Icons.settings,
                      Colors.red.shade700,
                          () => Navigator.pushNamed(context, '/system-controls'),
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
      leading: Icon(icon, color: Colors.blue.shade700),
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
          title: Text('Quick Actions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person_add, color: Colors.blue),
                title: Text('Add New Student'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/add-student');
                },
              ),
              ListTile(
                leading: Icon(Icons.work_outline, color: Colors.green),
                title: Text('Add New Employee'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/add-employee');
                },
              ),
              ListTile(
                leading: Icon(Icons.announcement, color: Colors.orange),
                title: Text('Post Announcement'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/post-announcement');
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt, color: Colors.purple),
                title: Text('Generate Fee Slip'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/generate-fee-slip');
                },
              ),
            ],
          ),

        );
      },
    );
  }
}