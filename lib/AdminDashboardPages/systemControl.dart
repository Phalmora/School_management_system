import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:school/model/systemControlModel.dart';


class SystemControlsPage extends StatefulWidget {
  @override
  _SystemControlsPageState createState() => _SystemControlsPageState();
}

class _SystemControlsPageState extends State<SystemControlsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample Data
  List<UserRole> userRoles = [
    UserRole(
      id: 'USR001',
      name: 'Admin User',
      email: 'admin@school.com',
      role: 'Administrator',
      isActive: true,
      lastLogin: DateTime.now().subtract(Duration(hours: 2)),
    ),
    UserRole(
      id: 'USR002',
      name: 'John Teacher',
      email: 'john.teacher@school.com',
      role: 'Teacher',
      isActive: true,
      lastLogin: DateTime.now().subtract(Duration(days: 1)),
    ),
    UserRole(
      id: 'USR003',
      name: 'Jane Staff',
      email: 'jane.staff@school.com',
      role: 'Staff',
      isActive: false,
      lastLogin: DateTime.now().subtract(Duration(days: 7)),
    ),
  ];

  List<Announcement> announcements = [
    Announcement(
      id: 'ANN001',
      title: 'School Holiday Notice',
      content: 'School will be closed from December 25th to January 2nd for winter holidays.',
      priority: 'High',
      createdDate: DateTime.now().subtract(Duration(days: 2)),
      createdBy: 'Admin User',
      isActive: true,
    ),
    Announcement(
      id: 'ANN002',
      title: 'Parent-Teacher Meeting',
      content: 'Monthly parent-teacher meeting scheduled for next Friday.',
      priority: 'Medium',
      createdDate: DateTime.now().subtract(Duration(days: 5)),
      createdBy: 'Admin User',
      isActive: true,
    ),
  ];

  List<SystemSetting> systemSettings = [
    SystemSetting(
      key: 'school_name',
      title: 'School Name',
      value: 'ABC International School',
      type: 'text',
      description: 'Name of the educational institution',
    ),
    SystemSetting(
      key: 'enable_notifications',
      title: 'Enable Notifications',
      value: 'true',
      type: 'boolean',
      description: 'Allow system to send push notifications',
    ),
    SystemSetting(
      key: 'max_students_per_class',
      title: 'Max Students Per Class',
      value: '30',
      type: 'number',
      description: 'Maximum number of students allowed in a single class',
    ),
    SystemSetting(
      key: 'academic_year',
      title: 'Academic Year',
      value: '2024-2025',
      type: 'text',
      description: 'Current academic year',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // User Role Management Methods
  void _addUserRole() {
    _showUserRoleDialog();
  }

  void _editUserRole(UserRole user) {
    _showUserRoleDialog(user: user);
  }

  void _deleteUserRole(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to remove this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userRoles.removeWhere((u) => u.id == userId);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showUserRoleDialog({UserRole? user}) {
    final isEditing = user != null;
    final nameController = TextEditingController(text: user?.name ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    String selectedRole = user?.role ?? 'Teacher';
    bool isActive = user?.isActive ?? true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit User Role' : 'Add New User'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField('Name', nameController, Icons.person),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Email', emailController, Icons.email),
                    SizedBox(height: AppTheme.smallSpacing),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: InputDecoration(
                        labelText: 'Role',
                        prefixIcon: Icon(Icons.admin_panel_settings),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                      ),
                      items: ['Administrator', 'Teacher', 'Staff', 'Student'].map((role) {
                        return DropdownMenuItem(value: role, child: Text(role));
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                    SizedBox(height: AppTheme.smallSpacing),
                    SwitchListTile(
                      title: Text('Active Status'),
                      value: isActive,
                      onChanged: (value) {
                        setDialogState(() {
                          isActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                      final newUser = UserRole(
                        id: isEditing ? user.id : 'USR${(userRoles.length + 1).toString().padLeft(3, '0')}',
                        name: nameController.text,
                        email: emailController.text,
                        role: selectedRole,
                        isActive: isActive,
                        lastLogin: user?.lastLogin ?? DateTime.now(),
                      );

                      setState(() {
                        if (isEditing) {
                          int index = userRoles.indexWhere((u) => u.id == user.id);
                          userRoles[index] = newUser;
                        } else {
                          userRoles.add(newUser);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
                  child: Text(
                    isEditing ? 'Update' : 'Add',
                    style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Announcement Methods
  void _addAnnouncement() {
    _showAnnouncementDialog();
  }

  void _editAnnouncement(Announcement announcement) {
    _showAnnouncementDialog(announcement: announcement);
  }

  void _deleteAnnouncement(String announcementId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to remove this announcement?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  announcements.removeWhere((a) => a.id == announcementId);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAnnouncementDialog({Announcement? announcement}) {
    final isEditing = announcement != null;
    final titleController = TextEditingController(text: announcement?.title ?? '');
    final contentController = TextEditingController(text: announcement?.content ?? '');
    String selectedPriority = announcement?.priority ?? 'Medium';
    bool isActive = announcement?.isActive ?? true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Announcement' : 'Create New Announcement'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField('Title', titleController, Icons.title),
                    SizedBox(height: AppTheme.smallSpacing),
                    TextField(
                      controller: contentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        prefixIcon: Icon(Icons.message),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                          borderSide: BorderSide(
                            color: AppTheme.primaryBlue,
                            width: AppTheme.focusedBorderWidth,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.smallSpacing),
                    DropdownButtonFormField<String>(
                      value: selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        prefixIcon: Icon(Icons.priority_high),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                      ),
                      items: ['Low', 'Medium', 'High'].map((priority) {
                        return DropdownMenuItem(value: priority, child: Text(priority));
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedPriority = value!;
                        });
                      },
                    ),
                    SizedBox(height: AppTheme.smallSpacing),
                    SwitchListTile(
                      title: Text('Active Status'),
                      value: isActive,
                      onChanged: (value) {
                        setDialogState(() {
                          isActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                      final newAnnouncement = Announcement(
                        id: isEditing ? announcement.id : 'ANN${(announcements.length + 1).toString().padLeft(3, '0')}',
                        title: titleController.text,
                        content: contentController.text,
                        priority: selectedPriority,
                        createdDate: announcement?.createdDate ?? DateTime.now(),
                        createdBy: 'Admin User', // In real app, get from current user
                        isActive: isActive,
                      );

                      setState(() {
                        if (isEditing) {
                          int index = announcements.indexWhere((a) => a.id == announcement.id);
                          announcements[index] = newAnnouncement;
                        } else {
                          announcements.add(newAnnouncement);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
                  child: Text(
                    isEditing ? 'Update' : 'Create',
                    style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // System Settings Methods
  void _editSystemSetting(SystemSetting setting) {
    final valueController = TextEditingController(text: setting.value);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool boolValue = setting.value == 'true';

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Edit ${setting.title}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    setting.description,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  SizedBox(height: AppTheme.mediumSpacing),
                  if (setting.type == 'boolean')
                    SwitchListTile(
                      title: Text(setting.title),
                      value: boolValue,
                      onChanged: (value) {
                        setDialogState(() {
                          boolValue = value;
                        });
                      },
                    )
                  else
                    TextField(
                      controller: valueController,
                      keyboardType: setting.type == 'number' ? TextInputType.number : TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                          borderSide: BorderSide(
                            color: AppTheme.primaryBlue,
                            width: AppTheme.focusedBorderWidth,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int index = systemSettings.indexWhere((s) => s.key == setting.key);
                      systemSettings[index] = SystemSetting(
                        key: setting.key,
                        title: setting.title,
                        value: setting.type == 'boolean' ? boolValue.toString() : valueController.text,
                        type: setting.type,
                        description: setting.description,
                      );
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
                  child: Text(
                    'Update',
                    style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.primaryBlue,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
      ),
    );
  }

  // Tab Views
  Widget _buildUserRolesTab() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(AppTheme.defaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User Roles (${userRoles.length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _addUserRole,
                icon: Icon(Icons.add),
                label: Text('Add User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: userRoles.length,
            itemBuilder: (context, index) {
              final user = userRoles[index];
              return Card(
                margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(AppTheme.mediumSpacing),
                  leading: CircleAvatar(
                    backgroundColor: user.isActive ? AppTheme.primaryBlue : Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${user.email}'),
                      Text('Role: ${user.role}'),
                      Text('Last Login: ${user.lastLogin.day}/${user.lastLogin.month}/${user.lastLogin.year}'),
                      Row(
                        children: [
                          Text('Status: '),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: user.isActive ? Colors.green.shade100 : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              user.isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: user.isActive ? Colors.green.shade800 : Colors.red.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editUserRole(user);
                      } else if (value == 'delete') {
                        _deleteUserRole(user.id);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: AppTheme.primaryBlue),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementsTab() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(AppTheme.defaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Announcements (${announcements.length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _addAnnouncement,
                icon: Icon(Icons.add),
                label: Text('New Post'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return Card(
                margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: announcement.priority == 'High'
                        ? Colors.red
                        : announcement.priority == 'Medium'
                        ? Colors.orange
                        : Colors.green,
                    child: Icon(
                      Icons.announcement,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    announcement.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('By: ${announcement.createdBy}'),
                      Text('Date: ${announcement.createdDate.day}/${announcement.createdDate.month}/${announcement.createdDate.year}'),
                      Row(
                        children: [
                          Text('Priority: '),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: announcement.priority == 'High'
                                  ? Colors.red.shade100
                                  : announcement.priority == 'Medium'
                                  ? Colors.orange.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              announcement.priority,
                              style: TextStyle(
                                color: announcement.priority == 'High'
                                    ? Colors.red.shade800
                                    : announcement.priority == 'Medium'
                                    ? Colors.orange.shade800
                                    : Colors.green.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editAnnouncement(announcement);
                      } else if (value == 'delete') {
                        _deleteAnnouncement(announcement.id);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: AppTheme.primaryBlue),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppTheme.mediumSpacing),
                      child: Text(
                        announcement.content,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSystemSettingsTab() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(AppTheme.defaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'System Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              Icon(Icons.settings, color: AppTheme.primaryBlue),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: systemSettings.length,
            itemBuilder: (context, index) {
              final setting = systemSettings[index];
              return Card(
                margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(AppTheme.mediumSpacing),
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryBlue,
                    child: Icon(
                      setting.type == 'boolean'
                          ? Icons.toggle_on
                          : setting.type == 'number'
                          ? Icons.numbers
                          : Icons.text_fields,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    setting.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Value: ${setting.value}'),
                      Text(
                        setting.description,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () => _editSystemSetting(setting),
                    icon: Icon(Icons.edit, color: AppTheme.primaryBlue),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(AppTheme.defaultSpacing),
                padding: EdgeInsets.all(AppTheme.mediumSpacing),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings, size: 32, color: AppTheme.primaryBlue),
                    SizedBox(width: AppTheme.smallSpacing),
                    Text(
                      'System Controls',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.black87,
                  tabs: [
                    Tab(text: 'User Roles', icon: Icon(Icons.people)),
                    Tab(text: 'Announcements', icon: Icon(Icons.announcement)),
                    Tab(text: 'Settings', icon: Icon(Icons.settings)),
                  ],
                ),
              ),

              // Tab Bar View
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    AppTheme.defaultSpacing,
                    AppTheme.smallSpacing,
                    AppTheme.defaultSpacing,
                    AppTheme.defaultSpacing,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildUserRolesTab(),
                      _buildAnnouncementsTab(),
                      _buildSystemSettingsTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}