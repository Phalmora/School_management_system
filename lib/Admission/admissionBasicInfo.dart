import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionBasicInfoScreen extends StatefulWidget {
  @override
  _AdmissionBasicInfoScreenState createState() => _AdmissionBasicInfoScreenState();
}

class _AdmissionBasicInfoScreenState extends State<AdmissionBasicInfoScreen> {

  //Static Data
  static const List<String> _genderOptions = ['Male', 'Female', 'Other'];
  static const List<String> _categoryOptions = ['General', 'SC', 'ST', 'OBC', 'EWS'];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _aadharController = TextEditingController();
  final _previousSchoolController = TextEditingController();
  bool _showOtpButton = false;
  bool _showOtpField = false;
  bool _otpSent = false;
  final TextEditingController _otpController = TextEditingController();

  String _selectedClass = 'Nursery';
  String _selectedAcademicYear = '2025-2026';
  String _selectedStudentType = 'New';
  String? _selectedGender;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateOfBirth = DateTime.now().subtract(Duration(days: 365 * 5)); // Default to 5 years ago

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
                    'Student Information',
                    style: AppTheme.FontStyle,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please fill in all the required information',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
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
                            _buildTextField(
                              controller: _nameController,
                              label: 'Full Name *',
                              icon: Icons.person,
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter student name' : null,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildDateOfBirthPicker(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildGenderDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _nationalityController,
                              label: 'Nationality *',
                              icon: Icons.flag,
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter nationality' : null,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _aadharController,
                              label: 'Aadhar Number / National ID *',
                              icon: Icons.credit_card,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) return 'Please enter Aadhar/National ID';
                                if (value.length < 10) return 'Please enter valid ID number';
                                return null;
                              },
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildCategoryDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildAcademicYearDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildClassDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildDatePicker(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildStudentTypeDropdown(),
                            SizedBox(height: AppTheme.mediumSpacing),
                            // Show Previous School field only when Transfer is selected
                            if (_selectedStudentType == 'Transfer') ...[
                              _buildTextField(
                                controller: _previousSchoolController,
                                label: 'Previous School *',
                                icon: Icons.school,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter previous school name' : null,
                              ),
                              SizedBox(height: AppTheme.mediumSpacing),
                            ],
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
                            _buildSubmitButton(),
                            SizedBox(height: AppTheme.mediumSpacing),
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
    bool isPhoneField = controller == _phoneController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          onChanged: isPhoneField ? _onPhoneNumberChanged : null,
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
        ),

        // Show OTP button for phone field
        if (isPhoneField && _showOtpButton && !_otpSent) ...[
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _sendOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.blue600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
              ),
            ),
            child: const Text('Send OTP'),
          ),
        ],

        // Show OTP input field
        if (isPhoneField && _showOtpField) ...[
          const SizedBox(height: 16),
          TextFormField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              labelText: 'Enter Verification Code',
              prefixIcon: const Icon(Icons.security),
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
              counterText: '', // Hide character counter
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter verification code';
              }
              if (value.length != 6) {
                return 'Verification code must be 6 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _verifyOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.blue600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
              ),
            ),
            child: const Text('Verify OTP'),
          ),
        ],
      ],
    );
  }

// Add these methods to your StatefulWidget class
  void _onPhoneNumberChanged(String value) {
    setState(() {
      // Show OTP button when phone number has valid length (adjust as needed)
      _showOtpButton = value.length >= 10; // Adjust length as per your requirement

      // Reset OTP states if phone number changes
      if (_otpSent) {
        _showOtpField = false;
        _otpSent = false;
        _otpController.clear();
      }
    });
  }

  void _sendOtp() {
    // Add your OTP sending logic here
    // For example: call your API to send OTP

    setState(() {
      _showOtpField = true;
      _otpSent = true;
      _showOtpButton = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP sent successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyOtp() {
    if (_otpController.text.length == 6) {
      // Add your OTP verification logic here
      // For example: call your API to verify OTP

      // For demo purposes, let's assume verification is successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number verified successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // You can hide the OTP field after successful verification if needed
      // setState(() {
      //   _showOtpField = false;
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildDateOfBirthPicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDateOfBirth,
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != _selectedDateOfBirth) {
          setState(() {
            _selectedDateOfBirth = picked;
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
            Icon(Icons.cake, color: Colors.grey[600]),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Date of Birth: ${_selectedDateOfBirth.day}/${_selectedDateOfBirth.month}/${_selectedDateOfBirth.year}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender *',
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
      items: _genderOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
      validator: (value) => value == null ? 'Please select gender' : null,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category *',
        prefixIcon: Icon(Icons.category),
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
      items: _categoryOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      validator: (value) => value == null ? 'Please select category' : null,
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

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: AppTheme.buttonHeight,
      child: ElevatedButton(
        onPressed: _submitDetails,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.blue600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
        child: Text(
          'Submit Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      // Handle submit details logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Details submitted successfully!')),
      );
    }
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      // Clear previous school field if student type is New
      if (_selectedStudentType == 'New') {
        _previousSchoolController.clear();
      }
      // Save data and navigate to next page
      Navigator.pushNamed(context, '/admission-parent');
    }
  }
}