import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/dashboard/employeeModel.dart';

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
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Responsive Header
                    SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
              Padding(
                padding: AppThemeResponsiveness.getScreenPadding(context),
                child: Expanded(
                  child: Text(
                    isEditing ? 'Edit Teacher' : 'Add Teacher',
                    style: AppThemeResponsiveness.getFontStyle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // Responsive Form Container
              Expanded(
                child: Container(
                  width: AppThemeResponsiveness.getMaxWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getMediumSpacing(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppThemeColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      topRight: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: AppThemeResponsiveness.getResponsivePadding(
                        context,
                        AppThemeResponsiveness.getDefaultSpacing(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Responsive Teacher ID Display
                          Container(
                            width: double.infinity,
                            padding: AppThemeResponsiveness.getResponsivePadding(
                              context,
                              AppThemeResponsiveness.getMediumSpacing(context),
                            ),
                            decoration: BoxDecoration(
                              color: AppThemeColor.blue50,
                              borderRadius: BorderRadius.circular(
                                AppThemeResponsiveness.getInputBorderRadius(context),
                              ),
                              border: Border.all(color: AppThemeColor.blue200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Teacher ID',
                                  style: TextStyle(
                                    fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12.0),
                                    color: AppThemeColor.blue600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                                Text(
                                  _employeeId.isEmpty ? 'Auto-generated' : _employeeId,
                                  style: TextStyle(
                                    fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 18.0),
                                    fontWeight: FontWeight.bold,
                                    color: AppThemeColor.blue800,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          // Responsive Form Fields
                          _buildResponsiveTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter teacher name';
                              }
                              if (value.length < 2) {
                                return 'Name must be at least 2 characters';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          // Responsive Role/Position Dropdown
                          _buildResponsiveDropdownField(
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

                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          // Responsive Subject/Department Dropdown
                          _buildResponsiveDropdownField(
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

                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          // Responsive Phone Field
                          _buildResponsiveTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              if (value.length < 10) {
                                return 'Phone number must be at least 10 digits';
                              }
                              if (!RegExp(r'^[0-9+\-\s()]+$').hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

                          // Responsive Email Field
                          _buildResponsiveTextField(
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

                          SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                          // Responsive Save Button
                          SizedBox(
                            width: double.infinity,
                            height: AppThemeResponsiveness.getButtonHeight(context),
                            child: ElevatedButton(
                              onPressed: _saveEmployee,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppThemeColor.primaryBlue,
                                foregroundColor: AppThemeColor.white,
                                elevation: AppThemeResponsiveness.getButtonElevation(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppThemeResponsiveness.getButtonBorderRadius(context),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isEditing ? Icons.update : Icons.save,
                                    size: AppThemeResponsiveness.getIconSize(context),
                                  ),
                                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
                                  Text(
                                    isEditing ? 'Update Teacher' : 'Save Teacher',
                                    style: AppThemeResponsiveness.getButtonTextStyle(context),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Add extra spacing for better scroll experience
                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
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

  Widget _buildResponsiveTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      style: AppThemeResponsiveness.getBodyTextStyle(context),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppThemeResponsiveness.getInputLabelStyle(context),
        hintStyle: AppThemeResponsiveness.getInputHintStyle(context),
        prefixIcon: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
          child: Icon(
            icon,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getIconSize(context),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: AppThemeColor.blue200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppThemeColor.primaryBlue,
            width: AppThemeResponsiveness.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: AppThemeColor.blue200),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: Colors.red.shade600, width: 2.0),
        ),
        filled: true,
        fillColor: AppThemeColor.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getMediumSpacing(context),
          vertical: AppThemeResponsiveness.getMediumSpacing(context),
        ),
      ),
    );
  }

  Widget _buildResponsiveDropdownField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required List<String> items,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty && items.contains(controller.text)
          ? controller.text
          : null,
      validator: validator,
      style: AppThemeResponsiveness.getBodyTextStyle(context),
      dropdownColor: AppThemeColor.white,
      icon: Icon(
        Icons.arrow_drop_down,
        color: AppThemeColor.primaryBlue,
        size: AppThemeResponsiveness.getIconSize(context),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppThemeResponsiveness.getInputLabelStyle(context),
        hintStyle: AppThemeResponsiveness.getInputHintStyle(context),
        prefixIcon: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
          child: Icon(
            icon,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getIconSize(context),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: AppThemeColor.blue200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppThemeColor.primaryBlue,
            width: AppThemeResponsiveness.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: AppThemeColor.blue200),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(color: Colors.red.shade600, width: 2.0),
        ),
        filled: true,
        fillColor: AppThemeColor.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getMediumSpacing(context),
          vertical: AppThemeResponsiveness.getMediumSpacing(context),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: AppThemeResponsiveness.getBodyTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            controller.text = newValue;
          });
        }
      },
      isExpanded: true,
      menuMaxHeight: AppThemeResponsiveness.isMobile(context) ? 200 : 300,
    );
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: _employeeId.isEmpty ? _generateEmployeeId() : _employeeId,
        name: _nameController.text.trim(),
        role: _roleController.text.trim(),
        department: _departmentController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim().toLowerCase(),
      );

      widget.onSave(employee);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                widget.employee != null ? Icons.check_circle : Icons.add_circle,
                color: AppThemeColor.white,
                size: AppThemeResponsiveness.getIconSize(context),
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Expanded(
                child: Text(
                  widget.employee != null
                      ? 'Teacher updated successfully!'
                      : 'Teacher added successfully!',
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                    color: AppThemeColor.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
          margin: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: AppThemeColor.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  String _generateEmployeeId() {
    // Generate a simple employee ID based on timestamp and random characters
    final now = DateTime.now();
    final timeStamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final random = (1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000).round();
    return 'EMP$timeStamp$random';
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