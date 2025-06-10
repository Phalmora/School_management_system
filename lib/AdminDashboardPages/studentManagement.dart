import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class Student {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String className;
  final String admissionStatus;
  final DateTime dateOfBirth;
  final String address;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
    required this.admissionStatus,
    required this.dateOfBirth,
    required this.address,
  });
}

class StudentManagementPage extends StatefulWidget {
  @override
  _StudentManagementPageState createState() => _StudentManagementPageState();
}

class _StudentManagementPageState extends State<StudentManagementPage> {
  List<Student> students = [
    Student(
      id: 'STU001',
      name: 'John Doe',
      email: 'john.doe@email.com',
      phone: '+1234567890',
      className: 'Class 10-A',
      admissionStatus: 'Active',
      dateOfBirth: DateTime(2008, 5, 15),
      address: '123 Main Street, City',
    ),
    Student(
      id: 'STU002',
      name: 'Jane Smith',
      email: 'jane.smith@email.com',
      phone: '+1234567891',
      className: 'Class 9-B',
      admissionStatus: 'Active',
      dateOfBirth: DateTime(2009, 8, 22),
      address: '456 Oak Avenue, City',
    ),
    Student(
      id: 'STU003',
      name: 'Mike Johnson',
      email: 'mike.johnson@email.com',
      phone: '+1234567892',
      className: 'Class 11-A',
      admissionStatus: 'Pending',
      dateOfBirth: DateTime(2007, 12, 10),
      address: '789 Pine Road, City',
    ),
  ];

  List<Student> filteredStudents = [];
  TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
    searchController.addListener(_filterStudents);
  }

  void _filterStudents() {
    setState(() {
      filteredStudents = students.where((student) {
        bool matchesSearch = student.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            student.id.toLowerCase().contains(searchController.text.toLowerCase()) ||
            student.className.toLowerCase().contains(searchController.text.toLowerCase());

        bool matchesFilter = selectedFilter == 'All' ||
            (selectedFilter == 'Active' && student.admissionStatus == 'Active') ||
            (selectedFilter == 'Pending' && student.admissionStatus == 'Pending') ||
            (selectedFilter == 'Inactive' && student.admissionStatus == 'Inactive');

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _addStudent() {
    _showStudentDialog();
  }

  void _editStudent(Student student) {
    _showStudentDialog(student: student);
  }

  void _removeStudent(String studentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to remove this student?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  students.removeWhere((s) => s.id == studentId);
                  _filterStudents();
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

  void _showStudentDialog({Student? student}) {
    final isEditing = student != null;
    final nameController = TextEditingController(text: student?.name ?? '');
    final emailController = TextEditingController(text: student?.email ?? '');
    final phoneController = TextEditingController(text: student?.phone ?? '');
    final classController = TextEditingController(text: student?.className ?? '');
    final addressController = TextEditingController(text: student?.address ?? '');
    String selectedStatus = student?.admissionStatus ?? 'Active';
    DateTime selectedDate = student?.dateOfBirth ?? DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Student' : 'Add New Student'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField('Name', nameController, Icons.person),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Email', emailController, Icons.email),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Phone', phoneController, Icons.phone),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Class', classController, Icons.class_),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Address', addressController, Icons.location_on),
                    SizedBox(height: AppTheme.smallSpacing),

                    // Date of Birth Field
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.grey.shade600),
                            SizedBox(width: 12),
                            Text(
                              'Date of Birth: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.smallSpacing),

                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: InputDecoration(
                        labelText: 'Admission Status',
                        prefixIcon: Icon(Icons.verified_user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                      ),
                      items: ['Active', 'Pending', 'Inactive'].map((status) {
                        return DropdownMenuItem(value: status, child: Text(status));
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedStatus = value!;
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
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        classController.text.isNotEmpty) {

                      final newStudent = Student(
                        id: isEditing ? student!.id : 'STU${(students.length + 1).toString().padLeft(3, '0')}',
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        className: classController.text,
                        admissionStatus: selectedStatus,
                        dateOfBirth: selectedDate,
                        address: addressController.text,
                      );

                      setState(() {
                        if (isEditing) {
                          int index = students.indexWhere((s) => s.id == student!.id);
                          students[index] = newStudent;
                        } else {
                          students.add(newStudent);
                        }
                        _filterStudents();
                      });
                      Navigator.pop(context);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isEditing ? 'Student updated successfully!' : 'Student added successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all required fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                  ),
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
                  // Search and Filter Section
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
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search by name, ID, or class...',
                            prefixIcon: Icon(Icons.search, color: AppTheme.primaryBlue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppTheme.blue50,
                          ),
                        ),
                        SizedBox(height: AppTheme.smallSpacing),
                        Row(
                          children: [
                            Text('Filter by status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedFilter,
                                isExpanded: true,
                                underline: Container(),
                                items: ['All', 'Active', 'Pending', 'Inactive'].map((filter) {
                                  return DropdownMenuItem(value: filter, child: Text(filter));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedFilter = value!;
                                    _filterStudents();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppTheme.defaultSpacing),
                  // Students List
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
                                  'Students (${filteredStudents.length})',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                Icon(Icons.group, color: AppTheme.primaryBlue),
                              ],
                            ),
                          ),

                          Expanded(
                            child: filteredStudents.isEmpty
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
                                    'No students found',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                              itemCount: filteredStudents.length,
                              itemBuilder: (context, index) {
                                final student = filteredStudents[index];
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
                                      child: Text(
                                        student.name.substring(0, 1).toUpperCase(),
                                        style: TextStyle(
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      student.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('ID: ${student.id}'),
                                        Text('Class: ${student.className}'),
                                        Text('Email: ${student.email}'),
                                        Text('DOB: ${student.dateOfBirth.day}/${student.dateOfBirth.month}/${student.dateOfBirth.year}'),
                                        Row(
                                          children: [
                                            Text('Status: '),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: student.admissionStatus == 'Active'
                                                    ? Colors.green.shade100
                                                    : student.admissionStatus == 'Pending'
                                                    ? Colors.orange.shade100
                                                    : Colors.red.shade100,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                student.admissionStatus,
                                                style: TextStyle(
                                                  color: student.admissionStatus == 'Active'
                                                      ? Colors.green.shade800
                                                      : student.admissionStatus == 'Pending'
                                                      ? Colors.orange.shade800
                                                      : Colors.red.shade800,
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
                                          _editStudent(student);
                                        } else if (value == 'delete') {
                                          _removeStudent(student.id);
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Action Button using Stack
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: _addStudent,
              backgroundColor: AppTheme.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: Icon(Icons.person_add),
              label: Text(
                'Add Student',
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
}