import 'package:flutter/material.dart';
import 'package:school/customWidgets/button.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/inputField.dart';

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

  // Consistent field dimensions
  static const double FIELD_HEIGHT = 56.0;
  static const double VERTICAL_PADDING = 16.0;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneNumberChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalityController.dispose();
    _aadharController.dispose();
    _previousSchoolController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged() {
    setState(() {
      _showOtpButton = _phoneController.text.length >= 10;
      if (_otpSent) {
        _showOtpField = false;
        _otpSent = false;
        _otpController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppThemeResponsiveness.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                padding: AppThemeResponsiveness.getScreenPadding(context),
                child: Column(
                  children: [
                    _buildProgressIndicator(1, 4),
                    SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                    Text(
                      'Student Information',
                      style: AppThemeResponsiveness.getFontStyle(context),
                    ),
                    SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                    Text(
                      'Please fill in all the required information',
                      style: AppThemeResponsiveness.getSplashSubtitleStyle(context),
                    ),
                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                    Card(
                      elevation: AppThemeResponsiveness.getCardElevation(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      ),
                      child: Padding(
                        padding: AppThemeResponsiveness.getCardPadding(context),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AppTextFieldBuilder.build(
                                context: context,
                                controller: _nameController,
                                label: 'Full Name *',
                                icon: Icons.person,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter student name' : null,
                              ),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildDateOfBirthPicker(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildGenderDropdown(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
                                controller: _nationalityController,
                                label: 'Nationality *',
                                icon: Icons.flag,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter nationality' : null,
                              ),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
                                controller: _aadharController,
                                label: 'Aadhaar Number / National ID *',
                                icon: Icons.credit_card,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Please enter Aadhar/National ID';
                                  if (value.length < 10) return 'Please enter valid ID number';
                                  return null;
                                },
                              ),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildCategoryDropdown(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildAcademicYearDropdown(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildClassDropdown(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildDatePicker(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildStudentTypeDropdown(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              // Show Previous School field only when Transfer is selected
                              if (_selectedStudentType == 'Transfer') ...[
                                AppTextFieldBuilder.build(
                                  context: context,
                                  controller: _previousSchoolController,
                                  label: 'Previous School *',
                                  icon: Icons.school,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please enter previous school name' : null,
                                ),
                                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              ],
                              AppTextFieldBuilder.build(
                                context: context,
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
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildPhoneFieldWithOTP(),
                              SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                              buildActionButtons(),
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
      ),
    );
  }

  Widget _buildPhoneFieldWithOTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Phone number field with onChanged callback
        AppTextFieldBuilder.build(
          context: context,
          controller: _phoneController,
          label: 'Phone Number *',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            setState(() {
              _showOtpButton = value.length >= 10;
              if (_otpSent) {
                _showOtpField = false;
                _otpSent = false;
                _otpController.clear();
              }
            });
          },
          validator: (value) {
            if (value!.isEmpty) return 'Please enter phone number';
            if (value.length < 10) return 'Please enter valid phone number';
            return null;
          },
        ),

        // Show OTP button when phone number is valid
        if (_showOtpButton && !_otpSent) ...[
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          _buildOtpButton('Send OTP', _sendOtp),
        ],

        // Show OTP input field after OTP is sent
        if (_showOtpField) ...[
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          AppTextFieldBuilder.build(
            context: context,
            controller: _otpController,
            label: 'Enter Verification Code',
            icon: Icons.security,
            keyboardType: TextInputType.number,
            maxLength: 6,
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
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          _buildOtpButton('Verify OTP', _verifyOtp),
        ],
      ],
    );
  }
  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: AppThemeResponsiveness.getVerticalPadding(context),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getSmallSpacing(context) / 4,
              ),
              height: AppThemeResponsiveness.isMobile(context) ? 4 : 6,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppThemeColor.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.isMobile(context) ? 2 : 3),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Common input decoration for consistency
  InputDecoration _getInputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppThemeResponsiveness.getSubHeadingStyle(context),
      prefixIcon: Icon(
        icon,
        size: AppThemeResponsiveness.getIconSize(context),
        color: Colors.grey[600],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(
          color: AppThemeColor.blue600,
          width: AppThemeResponsiveness.getFocusedBorderWidth(context),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
        vertical: VERTICAL_PADDING,
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildOtpButton(String text, VoidCallback onPressed) {
    return SizedBox(
      height: AppThemeResponsiveness.getButtonHeight(context),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppThemeColor.blue600,
          foregroundColor: Colors.white,
          elevation: AppThemeResponsiveness.getButtonElevation(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
        ),
        child: Text(
          text,
          style: AppThemeResponsiveness.getButtonTextStyle(context),
        ),
      ),
    );
  }
  
  void _sendOtp() {
    setState(() {
      _showOtpField = true;
      _otpSent = true;
      _showOtpButton = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'OTP sent successfully!',
          style: AppThemeResponsiveness.getBodyTextStyle(context),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyOtp() {
    if (_otpController.text.length == 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Phone number verified successfully!',
            style: AppThemeResponsiveness.getBodyTextStyle(context),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 6-digit OTP',
            style: AppThemeResponsiveness.getBodyTextStyle(context),
          ),
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
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppThemeColor.blue600,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != _selectedDateOfBirth) {
          setState(() {
            _selectedDateOfBirth = picked;
          });
        }
      },
      child: Container(
        height: FIELD_HEIGHT,
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
          vertical: VERTICAL_PADDING,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              Icons.cake,
              color: Colors.grey[600],
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
            Expanded(
              child: Text(
                "Date of Birth: ${_selectedDateOfBirth.day}/${_selectedDateOfBirth.month}/${_selectedDateOfBirth.year}",
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return SizedBox(
      height: FIELD_HEIGHT,
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
        dropdownColor: Colors.white,
        decoration: _getInputDecoration(
          label: 'Gender *',
          icon: Icons.person_outline,
        ),
        items: _genderOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
        validator: (value) => value == null ? 'Please select gender' : null,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return SizedBox(
      height: FIELD_HEIGHT,
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
        dropdownColor: Colors.white,
        decoration: _getInputDecoration(
          label: 'Category *',
          icon: Icons.category,
        ),
        items: _categoryOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedCategory = newValue;
          });
        },
        validator: (value) => value == null ? 'Please select category' : null,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildAcademicYearDropdown() {
    return SizedBox(
      height: FIELD_HEIGHT,
      child: DropdownButtonFormField<String>(
        value: _selectedAcademicYear,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
        dropdownColor: Colors.white,
        decoration: _getInputDecoration(
          label: 'Academic Year *',
          icon: Icons.calendar_today,
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
            child: Text(
              value,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedAcademicYear = newValue!;
          });
        },
        validator: (value) => value == null ? 'Please select an academic year' : null,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildClassDropdown() {
    return SizedBox(
      height: FIELD_HEIGHT,
      child: DropdownButtonFormField<String>(
        value: _selectedClass,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
        dropdownColor: Colors.white,
        decoration: _getInputDecoration(
          label: 'Class to be Admitted In *',
          icon: Icons.class_,
        ),
        items: [
          'Nursery', 'LKG', 'UKG',
          '1st Grade', '2nd Grade', '3rd Grade', '4th Grade',
          '5th Grade', '6th Grade', '7th Grade', '8th Grade',
          '9th Grade', '10th Grade', '11th Grade', '12th Grade'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedClass = newValue!;
          });
        },
        validator: (value) => value == null ? 'Please select a class' : null,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        ),
      ),
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
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppThemeColor.blue600,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        height: FIELD_HEIGHT,
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
          vertical: VERTICAL_PADDING,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              Icons.date_range,
              color: Colors.grey[600],
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
            Expanded(
              child: Text(
                "Admission Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentTypeDropdown() {
    return SizedBox(
      height: FIELD_HEIGHT,
      child: DropdownButtonFormField<String>(
        value: _selectedStudentType,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
        dropdownColor: Colors.white,
        decoration: _getInputDecoration(
          label: 'Student Type *',
          icon: Icons.person_outline,
        ),
        items: [
          'New',
          'Transfer'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedStudentType = newValue!;
          });
        },
        validator: (value) => value == null ? 'Please select student type' : null,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Column(
      children: [
        PrimaryButton(
          title: 'Next',
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: _nextPage,
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        SecondaryButton(
          title: 'Back',
          icon: Icon(Icons.arrow_back_rounded, color: AppThemeColor.blue600),
          color: AppThemeColor.blue600,
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      // Check if phone number is verified (OTP validation)
      if (_phoneController.text.isNotEmpty && !_otpSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please verify your phone number first',
              style: AppThemeResponsiveness.getBodyTextStyle(context),
            ),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (_otpSent && _otpController.text.length != 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please enter and verify the 6-digit OTP',
              style: AppThemeResponsiveness.getBodyTextStyle(context),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // All validations passed, proceed to next screen
      // You can pass the form data to the next screen here
      Map<String, dynamic> formData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'nationality': _nationalityController.text,
        'aadhar': _aadharController.text,
        'previousSchool': _previousSchoolController.text,
        'selectedClass': _selectedClass,
        'selectedAcademicYear': _selectedAcademicYear,
        'selectedStudentType': _selectedStudentType,
        'selectedGender': _selectedGender,
        'selectedCategory': _selectedCategory,
        'dateOfBirth': _selectedDateOfBirth,
        'admissionDate': _selectedDate,
      };

      // Navigate to next screen (replace with your actual next screen)
      Navigator.pushNamed(
        context,
        '/admission-parent-info', // Replace with your route name
        arguments: formData,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all required fields',
            style: AppThemeResponsiveness.getBodyTextStyle(context),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}