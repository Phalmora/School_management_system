import 'package:flutter/material.dart';
import 'package:school/AdminStudentManagement/studentDetailsPage.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class StudentListPage extends StatefulWidget {
  final String selectedClass;

  const StudentListPage({Key? key, required this.selectedClass}) : super(key: key);

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Student> allStudents = [
    Student(
      id: 'STU001',
      name: 'Alice Johnson',
      email: 'alice.johnson@email.com',
      phone: '+1234567890',
      className: 'Class 1',
      admissionStatus: 'Active',
      dateOfBirth: DateTime(2017, 5, 15),
      address: '123 Maple Street, City',
    ),
    Student(
      id: 'STU002',
      name: 'Bob Smith',
      email: 'bob.smith@email.com',
      phone: '+1234567891',
      className: 'Class 1',
      admissionStatus: 'Active',
      dateOfBirth: DateTime(2017, 8, 22),
      address: '456 Oak Avenue, City',
    ),
    Student(
      id: 'STU003',
      name: 'Charlie Brown',
      email: 'charlie.brown@email.com',
      phone: '+1234567892',
      className: 'Class 2',
      admissionStatus: 'Active',
      dateOfBirth: DateTime(2016, 12, 10),
      address: '789 Pine Road, City',
    ),
    Student(
      id: 'STU004',
      name: 'Diana Prince',
      email: 'diana.prince@email.com',
      phone: '+1234567893',
      className: 'Class 2',
      admissionStatus: 'Pending',
      dateOfBirth: DateTime(2016, 3, 25),
      address: '321 Elm Street, City',
    ),
    Student(
      id: 'STU005',
      name: 'Edward Norton',
      email: 'edward.norton@email.com',
      phone: '+1234567894',
      className: 'Class 3',
      admissionStatus: 'Active',
      dateOfBirth: DateTime(2015, 7, 18),
      address: '654 Cedar Lane, City',
    ),
    // Add more students as needed...
  ];

  List<Student> students = [];
  List<Student> filteredStudents = [];
  TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    students = allStudents.where((student) => student.className == widget.selectedClass).toList();
    filteredStudents = students;
    searchController.addListener(_filterStudents);
  }

  void _filterStudents() {
    setState(() {
      filteredStudents = students.where((student) {
        bool matchesSearch = student.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            student.id.toLowerCase().contains(searchController.text.toLowerCase()) ||
            student.email.toLowerCase().contains(searchController.text.toLowerCase());

        bool matchesFilter = selectedFilter == 'All' ||
            (selectedFilter == 'Active' && student.admissionStatus == 'Active') ||
            (selectedFilter == 'Pending' && student.admissionStatus == 'Pending') ||
            (selectedFilter == 'Inactive' && student.admissionStatus == 'Inactive');

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _navigateToStudentDetails(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsPage(student: student),
      ),
    );
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
                  allStudents.removeWhere((s) => s.id == studentId);
                  _filterStudents();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Student removed successfully!'),
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

  void _showStudentDialog({Student? student}) {
    final isEditing = student != null;
    final nameController = TextEditingController(text: student?.name ?? '');
    final emailController = TextEditingController(text: student?.email ?? '');
    final phoneController = TextEditingController(text: student?.phone ?? '');
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
                    _buildTextField('Address', addressController, Icons.location_on),
                    SizedBox(height: AppTheme.smallSpacing),
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
                        phoneController.text.isNotEmpty) {
                      final newStudent = Student(
                        id: isEditing ? student!.id : 'STU${(allStudents.length + 1).toString().padLeft(3, '0')}',
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        className: widget.selectedClass,
                        admissionStatus: selectedStatus,
                        dateOfBirth: selectedDate,
                        address: addressController.text,
                      );

                      setState(() {
                        if (isEditing) {
                          int index = students.indexWhere((s) => s.id == student!.id);
                          int allIndex = allStudents.indexWhere((s) => s.id == student!.id);
                          students[index] = newStudent;
                          allStudents[allIndex] = newStudent;
                        } else {
                          students.add(newStudent);
                          allStudents.add(newStudent);
                        }
                        _filterStudents();
                      });
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isEditing ? 'Student updated successfully!' : 'Student added successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
                  child: Text(isEditing ? 'Update' : 'Add', style: AppTheme.buttonTextStyle.copyWith(fontSize: 16)),
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
          borderSide: BorderSide(color: AppTheme.primaryBlue, width: AppTheme.focusedBorderWidth),
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
            decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                    padding: EdgeInsets.all(AppTheme.mediumSpacing),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5))],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search by name, ID, or email',
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
                                Text('${widget.selectedClass} Students List',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                                Icon(Icons.group, color: AppTheme.primaryBlue),
                              ],
                            ),
                          ),
                          Expanded(
                            child: filteredStudents.isEmpty
                                ? Center(child: Text('No students found', style: TextStyle(fontSize: 18, color: Colors.grey.shade600)))
                                : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                              itemCount: filteredStudents.length,
                              itemBuilder: (context, index) {
                                final student = filteredStudents[index];
                                return GestureDetector(
                                  onTap: () => _navigateToStudentDetails(student),
                                  child: Card(
                                    margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(AppTheme.mediumSpacing),
                                      leading: CircleAvatar(
                                        backgroundColor: AppTheme.primaryBlue,
                                        child: Text(student.name.substring(0, 1).toUpperCase(),
                                            style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold)),
                                      ),
                                      title: Text(student.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4),
                                          Text('ID: ${student.id}'),
                                          Text('Email: ${student.email}'),
                                          Row(
                                            children: [
                                              Text('Status: '),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: student.admissionStatus == 'Active' ? Colors.green.shade100 : Colors.orange.shade100,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(student.admissionStatus,
                                                    style: TextStyle(
                                                        color: student.admissionStatus == 'Active' ? Colors.green.shade800 : Colors.orange.shade800,
                                                        fontSize: 12, fontWeight: FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'update') {
                                            _editStudent(student);
                                          } else if (value == 'delete') {
                                            _removeStudent(student.id);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(value: 'update', child: Row(children: [Icon(Icons.edit, color: AppTheme.primaryBlue), SizedBox(width: 8), Text('Update')])),
                                          PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red), SizedBox(width: 8), Text('Delete')])),
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
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: _addStudent,
              backgroundColor: AppTheme.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: Icon(Icons.person_add),
              label: Text('Add Student', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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