import 'package:flutter/material.dart';
import 'package:school/AdminStudentManagement/studentListTile.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';


class ClassInfo {
  final String id;
  final String name;
  final String teacher;
  final int totalStudents;
  final String description;

  ClassInfo({
    required this.id,
    required this.name,
    required this.teacher,
    required this.totalStudents,
    required this.description,
  });
}

class ClassManagementPage extends StatefulWidget {
  @override
  _ClassManagementPageState createState() => _ClassManagementPageState();
}

class _ClassManagementPageState extends State<ClassManagementPage> {
  List<ClassInfo> classes = [
    ClassInfo(
      id: 'CLS001',
      name: 'Class 1',
      teacher: 'Mrs. Anderson',
      totalStudents: 25,
      description: 'Primary level - Foundation learning',
    ),
    ClassInfo(
      id: 'CLS002',
      name: 'Class 2',
      teacher: 'Mr. Johnson',
      totalStudents: 28,
      description: 'Primary level - Basic concepts',
    ),
    ClassInfo(
      id: 'CLS003',
      name: 'Class 3',
      teacher: 'Ms. Williams',
      totalStudents: 30,
      description: 'Primary level - Core subjects',
    ),
    ClassInfo(
      id: 'CLS004',
      name: 'Class 4',
      teacher: 'Mrs. Brown',
      totalStudents: 27,
      description: 'Primary level - Advanced basics',
    ),
    ClassInfo(
      id: 'CLS005',
      name: 'Class 5',
      teacher: 'Mr. Davis',
      totalStudents: 32,
      description: 'Primary level - Intermediate',
    ),
    ClassInfo(
      id: 'CLS006',
      name: 'Class 6',
      teacher: 'Ms. Miller',
      totalStudents: 29,
      description: 'Middle school - Foundation',
    ),
    ClassInfo(
      id: 'CLS007',
      name: 'Class 7',
      teacher: 'Mr. Wilson',
      totalStudents: 31,
      description: 'Middle school - Core subjects',
    ),
    ClassInfo(
      id: 'CLS008',
      name: 'Class 8',
      teacher: 'Mrs. Moore',
      totalStudents: 26,
      description: 'Middle school - Advanced',
    ),
    ClassInfo(
      id: 'CLS009',
      name: 'Class 9',
      teacher: 'Mr. Taylor',
      totalStudents: 24,
      description: 'High school - Secondary',
    ),
    ClassInfo(
      id: 'CLS010',
      name: 'Class 10',
      teacher: 'Ms. Thomas',
      totalStudents: 22,
      description: 'High school - Board preparation',
    ),
    ClassInfo(
      id: 'CLS011',
      name: 'Class 11',
      teacher: 'Mr. Jackson',
      totalStudents: 20,
      description: 'Higher secondary - Stream selection',
    ),
    ClassInfo(
      id: 'CLS012',
      name: 'Class 12',
      teacher: 'Mrs. White',
      totalStudents: 18,
      description: 'Higher secondary - Final year',
    ),
  ];

  List<ClassInfo> filteredClasses = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredClasses = classes;
    searchController.addListener(_filterClasses);
  }

  void _filterClasses() {
    setState(() {
      filteredClasses = classes.where((classInfo) {
        return classInfo.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            classInfo.teacher.toLowerCase().contains(searchController.text.toLowerCase()) ||
            classInfo.id.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  void _navigateToStudentList(ClassInfo classInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentListPage(selectedClass: classInfo.name),
      ),
    );
  }

  void _addNewClass() {
    _showClassDialog();
  }

  void _editClass(ClassInfo classInfo) {
    _showClassDialog(classInfo: classInfo);
  }

  void _removeClass(String classId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to remove this class? This will also remove all students in this class.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  classes.removeWhere((c) => c.id == classId);
                  _filterClasses();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Class removed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showClassDialog({ClassInfo? classInfo}) {
    final isEditing = classInfo != null;
    final nameController = TextEditingController(text: classInfo?.name ?? '');
    final teacherController = TextEditingController(text: classInfo?.teacher ?? '');
    final descriptionController = TextEditingController(text: classInfo?.description ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Class' : 'Add New Class'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Class Name',
                    prefixIcon: Icon(Icons.class_),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.smallSpacing),
                TextField(
                  controller: teacherController,
                  decoration: InputDecoration(
                    labelText: 'Class Teacher',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.smallSpacing),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                    ),
                  ),
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
                if (nameController.text.isNotEmpty && teacherController.text.isNotEmpty) {
                  final newClass = ClassInfo(
                    id: isEditing ? classInfo!.id : 'CLS${(classes.length + 1).toString().padLeft(3, '0')}',
                    name: nameController.text,
                    teacher: teacherController.text,
                    totalStudents: isEditing ? classInfo!.totalStudents : 0,
                    description: descriptionController.text,
                  );

                  setState(() {
                    if (isEditing) {
                      int index = classes.indexWhere((c) => c.id == classInfo!.id);
                      classes[index] = newClass;
                    } else {
                      classes.add(newClass);
                    }
                    _filterClasses();
                  });
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEditing ? 'Class updated successfully!' : 'Class added successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Search Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
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
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search classes by class no., student, or ID',
                        hintStyle: TextStyle(
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(Icons.search, color: AppTheme.primaryBlue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppTheme.blue50,
                      ),
                    ),
                  ),

                  SizedBox(height: AppTheme.defaultSpacing),

                  // Classes List
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppTheme.cardBorderRadius),
                          topRight: Radius.circular(AppTheme.cardBorderRadius),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppTheme.mediumSpacing),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Classes (${filteredClasses.length})',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                Icon(Icons.school, color: AppTheme.primaryBlue),
                              ],
                            ),
                          ),

                          Expanded(
                            child: filteredClasses.isEmpty
                                ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: AppTheme.smallSpacing),
                                  Text(
                                    'No classes found',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : GridView.builder(
                              padding: EdgeInsets.all(AppTheme.mediumSpacing),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: AppTheme.smallSpacing,
                                mainAxisSpacing: AppTheme.smallSpacing,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: filteredClasses.length,
                              itemBuilder: (context, index) {
                                final classInfo = filteredClasses[index];
                                return GestureDetector(
                                  onTap: () => _navigateToStudentList(classInfo),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(AppTheme.mediumSpacing),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.primaryBlue.withOpacity(0.8),
                                            AppTheme.primaryBlue.withOpacity(0.6),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  classInfo.name,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuButton<String>(
                                                icon: Icon(Icons.more_vert, color: Colors.white),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    _editClass(classInfo);
                                                  } else if (value == 'delete') {
                                                    _removeClass(classInfo.id);
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
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Teacher: ${classInfo.teacher}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Students: ${classInfo.totalStudents}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Expanded(
                                            child: Text(
                                              classInfo.description,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white.withOpacity(0.8),
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Center(
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Action Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: _addNewClass,
              backgroundColor: AppTheme.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: Icon(Icons.add),
              label: Text(
                'Add Class',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}