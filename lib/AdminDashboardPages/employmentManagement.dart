import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:school/model/employeeModel.dart';

// Main Employee Management Page
class EmployeeManagementPage extends StatefulWidget {
  @override
  _EmployeeManagementPageState createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  List<Employee> employees = [
    Employee(
      id: 'EMP001',
      name: 'John Doe',
      role: 'Software Developer',
      department: 'IT',
      phone: '+91 9876543210',
      email: 'john.doe@company.com',
    ),
    Employee(
      id: 'EMP002',
      name: 'Jane Smith',
      role: 'Project Manager',
      department: 'IT',
      phone: '+91 9876543211',
      email: 'jane.smith@company.com',
    ),
  ];

  String _generateEmployeeId() {
    int nextId = employees.length + 1;
    return 'EMP${nextId.toString().padLeft(3, '0')}';
  }

  void _addEmployee(Employee employee) {
    setState(() {
      employees.add(employee);
    });
  }

  void _updateEmployee(int index, Employee employee) {
    setState(() {
      employees[index] = employee;
    });
  }

  void _deleteEmployee(int index) {
    setState(() {
      employees.removeAt(index);
    });
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
              SizedBox(height: 50,),
              // Employee List
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: Column(
                    children: [
                      // List Header with Add Button
                      Container(
                        padding: EdgeInsets.all(AppTheme.defaultSpacing),
                        decoration: BoxDecoration(
                          color: AppTheme.blue50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppTheme.cardBorderRadius),
                            topRight: Radius.circular(AppTheme.cardBorderRadius),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Employees (${employees.length})',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.blue800,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditEmployeePage(
                                      employeeId: _generateEmployeeId(),
                                      onSave: _addEmployee,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                foregroundColor: AppTheme.white,
                                elevation: AppTheme.buttonElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add, size: 18),
                                  SizedBox(width: 5),
                                  Text('Add Employee'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Employee List
                      Expanded(
                        child: employees.isEmpty
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: AppTheme.mediumSpacing),
                              Text(
                                'No employees found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                            : ListView.builder(
                          padding: EdgeInsets.all(AppTheme.mediumSpacing),
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            final employee = employees[index];
                            return Card(
                              elevation: AppTheme.cardElevation,
                              margin: EdgeInsets.only(bottom: AppTheme.mediumSpacing),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppTheme.blue50,
                                      AppTheme.white,
                                    ],
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(AppTheme.mediumSpacing),
                                  leading: CircleAvatar(
                                    backgroundColor: AppTheme.primaryBlue,
                                    child: Text(
                                      employee.name.substring(0, 1).toUpperCase(),
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    employee.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Text('ID: ${employee.id}'),
                                      Text('${employee.role} • ${employee.department}'),
                                      Text('📞 ${employee.phone}'),
                                      Text('📧 ${employee.email}'),
                                    ],
                                  ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) => [
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
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddEditEmployeePage(
                                              employee: employee,
                                              employeeIndex: index,
                                              onSave: (updatedEmployee) => _updateEmployee(index, updatedEmployee),
                                            ),
                                          ),
                                        );
                                      } else if (value == 'delete') {
                                        _showDeleteDialog(index);
                                      }
                                    },
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
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Employee'),
          content: Text('Are you sure you want to delete ${employees[index].name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteEmployee(index);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: AppTheme.white,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// Add/Edit Employee Page
class AddEditEmployeePage extends StatefulWidget {
  final Employee? employee;
  final int? employeeIndex;
  final String? employeeId;
  final Function(Employee) onSave;

  AddEditEmployeePage({
    this.employee,
    this.employeeIndex,
    this.employeeId,
    required this.onSave,
  });

  @override
  _AddEditEmployeePageState createState() => _AddEditEmployeePageState();
}

class _AddEditEmployeePageState extends State<AddEditEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _departmentController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late String _employeeId;

  @override
  void initState() {
    super.initState();
    _employeeId = widget.employee?.id ?? widget.employeeId ?? '';
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _roleController = TextEditingController(text: widget.employee?.role ?? '');
    _departmentController = TextEditingController(text: widget.employee?.department ?? '');
    _phoneController = TextEditingController(text: widget.employee?.phone ?? '');
    _emailController = TextEditingController(text: widget.employee?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.employee != null;

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
              Padding(
                padding: EdgeInsets.all(AppTheme.defaultSpacing),
                child: Row(
                  children: [
                    SizedBox(width: 75),
                    Icon(
                      isEditing ? Icons.edit : Icons.person_add,
                      color: AppTheme.white,
                      size: 30,
                    ),
                    SizedBox(width: AppTheme.mediumSpacing),
                    Text(
                      isEditing ? 'Edit Employee' : 'Add Employee',
                      style: AppTheme.FontStyle,
                    ),
                  ],
                ),
              ),

              // Form
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(AppTheme.defaultSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Employee ID Display
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(AppTheme.mediumSpacing),
                            decoration: BoxDecoration(
                              color: AppTheme.blue50,
                              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                              border: Border.all(color: AppTheme.blue200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Employee ID',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.blue600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _employeeId,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.blue800,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Name Field
                          _buildTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter employee name';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Role Field
                          _buildTextField(
                            controller: _roleController,
                            label: 'Role/Position',
                            icon: Icons.work,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter employee role';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Department Field
                          _buildTextField(
                            controller: _departmentController,
                            label: 'Department',
                            icon: Icons.business,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter department';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Phone Field
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Email Field
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email address';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.extraLargeSpacing),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            height: AppTheme.buttonHeight,
                            child: ElevatedButton(
                              onPressed: _saveEmployee,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                foregroundColor: AppTheme.white,
                                elevation: AppTheme.buttonElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                ),
                              ),
                              child: Text(
                                isEditing ? 'Update Employee' : 'Save Employee',
                                style: AppTheme.buttonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(color: AppTheme.blue200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.primaryBlue,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(color: AppTheme.blue200),
        ),
        filled: true,
        fillColor: AppTheme.white,
        labelStyle: TextStyle(color: AppTheme.blue600),
      ),
    );
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: _employeeId,
        name: _nameController.text.trim(),
        role: _roleController.text.trim(),
        department: _departmentController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
      );

      widget.onSave(employee);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.employee != null
                ? 'Employee updated successfully!'
                : 'Employee added successfully!',
          ),
          backgroundColor: AppTheme.primaryBlue,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}