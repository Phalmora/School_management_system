import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionBasicInfoScreen extends StatefulWidget {
  @override
  _AdmissionBasicInfoScreenState createState() => _AdmissionBasicInfoScreenState();
}

class _AdmissionBasicInfoScreenState extends State<AdmissionBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedClass = 'Nursery';
  String _selectedAcademicYear = '2025-2026';
  String _selectedStudentType = 'New';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.defaultSpacing),
              child: Column(
                children: [
                  _buildProgressIndicator(1, 4),
                  SizedBox(height: AppTheme.defaultSpacing),
                  Text(
                    'Basic Information',
                    style: AppTheme.FontStyle,
                  ),
                  SizedBox(height: AppTheme.extraLargeSpacing),
                  Card(
                    elevation: AppTheme.cardElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.defaultSpacing),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildAcademicYearDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildClassDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildDatePicker(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildStudentTypeDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _nameController,
                              label: 'Full Name *',
                              icon: Icons.person,
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter student name' : null,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email *',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) return 'Please enter email';
                                if (!value.contains('@')) return 'Please enter valid email';
                                return null;
                              },
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _phoneController,
                              label: 'Phone Number *',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) return 'Please enter phone number';
                                if (value.length < 10) return 'Please enter valid phone number';
                                return null;
                              },
                            ),
                            SizedBox(height: AppTheme.extraLargeSpacing),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAnimatedButton(
                                    text: 'Back',
                                    onPressed: () => Navigator.pop(context),
                                    isSecondary: true,
                                  ),
                                ),
                                SizedBox(width: AppTheme.mediumSpacing),
                                Expanded(
                                  child: _buildAnimatedButton(
                                    text: 'Next',
                                    onPressed: _nextPage,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 4,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppTheme.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
      ),
    );
  }

  Widget _buildAcademicYearDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedAcademicYear,
      decoration: InputDecoration(
        labelText: 'Academic Year *',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
      ),
      items: [
        '2024-2025',
        '2025-2026',
        '2026-2027',
        '2027-2028',
        '2028-2029'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedAcademicYear = newValue!;
        });
      },
      validator: (value) => value == null ? 'Please select an academic year' : null,
    );
  }

  Widget _buildClassDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedClass,
      decoration: InputDecoration(
        labelText: 'Class to be Admitted In *',
        prefixIcon: Icon(Icons.class_),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
      ),
      items: [
        'Nursery', 'LKG', 'UKG',
        '1st Grade', '2nd Grade', '3rd Grade', '4th Grade',
        '5th Grade', '6th Grade', '7th Grade', '8th Grade',
        '9th Grade', '10th Grade', '11th Grade', '12th Grade'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedClass = newValue!;
        });
      },
      validator: (value) => value == null ? 'Please select a class' : null,
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        child: Row(
          children: [
            Icon(Icons.date_range, color: Colors.grey[600]),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Admission Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedStudentType,
      decoration: InputDecoration(
        labelText: 'Student Type *',
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
      ),
      items: [
        'New',
        'Transfer'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedStudentType = newValue!;
        });
      },
      validator: (value) => value == null ? 'Please select student type' : null,
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return Container(
      height: AppTheme.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.grey[300] : AppTheme.blue600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSecondary ? Colors.grey[700] : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      // Save data and navigate to next page
      Navigator.pushNamed(context, '/admission-parent');
    }
  }
}