import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:school/model/employeeModel.dart';

// Add/Edit Teacher Page
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

  // Predefined subjects for school teachers
  final List<String> _subjects = [
    'Mathematics',
    'English',
    'Science',
    'Social Studies',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'Physical Education',
    'Arts',
    'Music',
    'Hindi',
    'Geography',
    'History',
    'Economics',
    'Commerce',
    'Literature',
    'Environmental Science',
    'Psychology',
    'Philosophy',
    'Other'
  ];

  // Teacher roles/positions
  final List<String> _teacherRoles = [
    'Mathematics Teacher',
    'English Teacher',
    'Science Teacher',
    'Social Studies Teacher',
    'Physics Teacher',
    'Chemistry Teacher',
    'Biology Teacher',
    'Computer Science Teacher',
    'Physical Education Teacher',
    'Art Teacher',
    'Music Teacher',
    'Hindi Teacher',
    'Geography Teacher',
    'History Teacher',
    'Economics Teacher',
    'Commerce Teacher',
    'Literature Teacher',
    'Environmental Science Teacher',
    'Psychology Teacher',
    'Philosophy Teacher',
    'Head Teacher',
    'Vice Principal',
    'Department Head',
    'Special Education Teacher',
    'Librarian',
    'Counselor',
    'Other'
  ];

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
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: AppTheme.white),
                    ),
                    Icon(
                      isEditing ? Icons.edit : Icons.person_add,
                      color: AppTheme.white,
                      size: 30,
                    ),
                    SizedBox(width: AppTheme.mediumSpacing),
                    Text(
                      isEditing ? 'Edit Teacher' : 'Add Teacher',
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
                          // Teacher ID Display
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
                                  'Teacher ID',
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
                                return 'Please enter teacher name';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Role/Position Dropdown
                          _buildDropdownField(
                            controller: _roleController,
                            label: 'Role/Position',
                            icon: Icons.work,
                            items: _teacherRoles,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select teacher role';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppTheme.defaultSpacing),

                          // Subject/Department Dropdown
                          _buildDropdownField(
                            controller: _departmentController,
                            label: 'Subject/Department',
                            icon: Icons.school,
                            items: _subjects,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select subject/department';
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
                                isEditing ? 'Update Teacher' : 'Save Teacher',
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

  Widget _buildDropdownField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required List<String> items,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty && items.contains(controller.text) ? controller.text : null,
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
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          controller.text = newValue;
        }
      },
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
                ? 'Teacher updated successfully!'
                : 'Teacher added successfully!',
          ),
          backgroundColor: Colors.green,
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