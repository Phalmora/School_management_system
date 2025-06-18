import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class adminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Enhanced Header with Stack for Edit Profile option
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppTheme.blue600,
                ),
                child: Stack(
                  children: [
                    // Main profile content
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.admin_panel_settings,
                                size: 40,
                                color: Colors.blue,
                              ),
                            ),
                            // Edit profile badge
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.blue600,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: AppTheme.blue600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
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
                          ),
                        ),
                      ],
                    ),
                    // Edit Profile Button (positioned at top-right)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, '/admin-edit-profile');
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Alternative: Profile tap gesture for entire header
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Show profile options bottom sheet
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 4,
                                        margin: EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.person,
                                          color: AppTheme.blue600,
                                        ),
                                        title: Text('View Profile'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/admin-profile');
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.edit,
                                          color: AppTheme.blue600,
                                        ),
                                        title: Text('Edit Profile'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/admin-edit-profile');
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.camera_alt,
                                          color: AppTheme.blue600,
                                        ),
                                        title: Text('Change Photo'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          // Handle photo change
                                        },
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              // Menu Items
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
                route: '/admin-student-management',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.work,
                title: 'Employee Management',
                route: '/admin-employee-management',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.class_,
                title: 'Class Management',
                route: '/admin-class-section-management',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.payment,
                title: 'Fee Management',
                route: '/admin-fee-management',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.grade,
                title: 'Academic Results',
                route: '/admin-academic-result-screen',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.analytics,
                title: 'Reports & Analytics',
                route: '/admin-report-analytics',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.person_add_alt,
                title: 'Add Applicant',
                route: '/admin-add-student-applicant',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.settings,
                title: 'System Controls',
                route: '/admin-system-control',
              ),
          
              Divider(),
          
              // Profile Management Section
              _buildDrawerItem(
                context,
                icon: Icons.person,
                title: 'My Profile',
                route: '/admin-profile',
              ),
              _buildDrawerItem(
                context,
                icon: Icons.edit,
                title: 'Edit Profile',
                route: '/admin-edit-profile',
              ),
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
                    context,
                    '/login',
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SingleChildScrollView(
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

              // Main Dashboard Grid - Now scrollable
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  _buildDashboardCard(
                    'Student Management',
                    Icons.people,
                    Colors.blue,
                        () => Navigator.pushNamed(context, '/admin-student-management'),
                  ),
                  _buildDashboardCard(
                    'Employee Management',
                    Icons.work,
                    Colors.green,
                        () => Navigator.pushNamed(context, '/admin-employee-management'),
                  ),
                  _buildDashboardCard(
                    'Class & Section Management',
                    Icons.class_,
                    Colors.orange,
                        () => Navigator.pushNamed(context, '/admin-class-section-management'),
                  ),
                  _buildDashboardCard(
                    'Fee Management',
                    Icons.payment,
                    Colors.purple,
                        () => Navigator.pushNamed(context, '/admin-fee-management'),
                  ),
                  _buildDashboardCard(
                    'Academic Results',
                    Icons.grade,
                    Colors.indigo,
                        () => Navigator.pushNamed(context, '/admin-academic-result-screen'),
                  ),
                  _buildDashboardCard(
                    'Reports & Analytics',
                    Icons.analytics,
                    Colors.teal,
                        () => Navigator.pushNamed(context, '/admin-report-analytics'),
                  ),
                  _buildDashboardCard(
                    'Add New Applicant',
                    Icons.person_add_alt_1_sharp,
                    Colors.brown,
                        () => Navigator.pushNamed(context, '/admin-add-student-applicant'),
                  ),
                  _buildDashboardCard(
                    'Add Teacher',
                    Icons.add_outlined,
                    Colors.green,
                        () => Navigator.pushNamed(context, '/admin-add-teacher'),
                  ),
                  _buildDashboardCard(
                    'Add Designation',
                    Icons.add_outlined,
                    Colors.deepPurple,
                        () => Navigator.pushNamed(context, '/admin-add-designation'),
                  ),
                  _buildDashboardCard(
                    'Academic options',
                    Icons.sports_sharp,
                    Colors.black45,
                        () => Navigator.pushNamed(context, '/academic-options'),
                  ),
                  _buildDashboardCard(
                    'User Request',
                    Icons.notification_add_sharp,
                    Colors.teal,
                        () => Navigator.pushNamed(context, '/admin-user-request'),
                  ),
                  _buildDashboardCard(
                    'System Controls',
                    Icons.settings,
                    Colors.red.shade700,
                        () => Navigator.pushNamed(context, '/admin-system-control'),
                  ),
                  _buildDashboardCard(
                    'Quick Actions',
                    Icons.flash_on,
                    Colors.amber.shade700,
                        () => _showQuickActionsDialog(context),
                  ),
                ],
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
                leading: Icon(Icons.pending_actions, color: Colors.red),
                title: Text('View Reports'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/view-report');
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