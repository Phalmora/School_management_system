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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                padding: AppTheme.getScreenPadding(context),
                child: Column(
                  children: [
                    _buildProgressIndicator(1, 4),
                    SizedBox(height: AppTheme.getDefaultSpacing(context)),
                    Text(
                      'Student Information',
                      style: AppTheme.getFontStyle(context),
                    ),
                    SizedBox(height: AppTheme.getSmallSpacing(context)),
                    Text(
                      'Please fill in all the required information',
                      style: AppTheme.getSplashSubtitleStyle(context),
                    ),
                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                    Card(
                      elevation: AppTheme.getCardElevation(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
                      ),
                      child: Padding(
                        padding: AppTheme.getCardPadding(context),
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
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildDateOfBirthPicker(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildGenderDropdown(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _nationalityController,
                                label: 'Nationality *',
                                icon: Icons.flag,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter nationality' : null,
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
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
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildCategoryDropdown(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildAcademicYearDropdown(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildClassDropdown(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildDatePicker(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildStudentTypeDropdown(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              // Show Previous School field only when Transfer is selected
                              if (_selectedStudentType == 'Transfer') ...[
                                _buildTextField(
                                  controller: _previousSchoolController,
                                  label: 'Previous School *',
                                  icon: Icons.school,
                                  validator: (value) =>
                                  value!.isEmpty ? 'Please enter previous school name' : null,
                                ),
                                SizedBox(height: AppTheme.getMediumSpacing(context)),
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
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
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
                              SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
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

  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: AppTheme.getVerticalPadding(context),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppTheme.getSmallSpacing(context) / 4,
              ),
              height: AppTheme.isMobile(context) ? 4 : 6,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppTheme.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(AppTheme.isMobile(context) ? 2 : 3),
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
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    bool isPhoneField = controller == _phoneController;
    int effectiveMaxLines = maxLines ?? AppTheme.getTextFieldMaxLines(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: effectiveMaxLines,
          validator: validator,
          onChanged: isPhoneField ? _onPhoneNumberChanged : null,
          style: AppTheme.getBodyTextStyle(context),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTheme.getSubHeadingStyle(context),
            prefixIcon: Icon(
              icon,
              size: AppTheme.getIconSize(context),
              color: Colors.grey[600],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: AppTheme.blue600,
                width: AppTheme.getFocusedBorderWidth(context),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppTheme.getDefaultSpacing(context),
              vertical: AppTheme.getMediumSpacing(context),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),

        // Show OTP button for phone field
        if (isPhoneField && _showOtpButton && !_otpSent) ...[
          SizedBox(height: AppTheme.getMediumSpacing(context)),
          _buildOtpButton('Send OTP', _sendOtp),
        ],

        // Show OTP input field
        if (isPhoneField && _showOtpField) ...[
          SizedBox(height: AppTheme.getMediumSpacing(context)),
          TextFormField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            style: AppTheme.getBodyTextStyle(context),
            decoration: InputDecoration(
              labelText: 'Enter Verification Code',
              labelStyle: AppTheme.getSubHeadingStyle(context),
              prefixIcon: Icon(
                Icons.security,
                size: AppTheme.getIconSize(context),
                color: Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                borderSide: BorderSide(
                  color: AppTheme.blue600,
                  width: AppTheme.getFocusedBorderWidth(context),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.getDefaultSpacing(context),
                vertical: AppTheme.getMediumSpacing(context),
              ),
              filled: true,
              fillColor: Colors.white,
              counterText: '',
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
          SizedBox(height: AppTheme.getMediumSpacing(context)),
          _buildOtpButton('Verify OTP', _verifyOtp),
        ],
      ],
    );
  }

  Widget _buildOtpButton(String text, VoidCallback onPressed) {
    return Container(
      height: AppTheme.getButtonHeight(context),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.blue600,
          foregroundColor: Colors.white,
          elevation: AppTheme.getButtonElevation(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          ),
        ),
        child: Text(
          text,
          style: AppTheme.getButtonTextStyle(context),
        ),
      ),
    );
  }

  void _onPhoneNumberChanged(String value) {
    setState(() {
      _showOtpButton = value.length >= 10;
      if (_otpSent) {
        _showOtpField = false;
        _otpSent = false;
        _otpController.clear();
      }
    });
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
          style: AppTheme.getBodyTextStyle(context),
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
            style: AppTheme.getBodyTextStyle(context),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 6-digit OTP',
            style: AppTheme.getBodyTextStyle(context),
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
                  primary: AppTheme.blue600,
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
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              Icons.cake,
              color: Colors.grey[600],
              size: AppTheme.getIconSize(context),
            ),
            SizedBox(width: AppTheme.getMediumSpacing(context)),
            Expanded(
              child: Text(
                "Date of Birth: ${_selectedDateOfBirth.day}/${_selectedDateOfBirth.month}/${_selectedDateOfBirth.year}",
                style: AppTheme.getBodyTextStyle(context),
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
      style: AppTheme.getBodyTextStyle(context),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Gender *',
        labelStyle: AppTheme.getSubHeadingStyle(context),
        prefixIcon: Icon(
          Icons.person_outline,
          size: AppTheme.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: _genderOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppTheme.getBodyTextStyle(context).copyWith(
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
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      style: AppTheme.getBodyTextStyle(context),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Category *',
        labelStyle: AppTheme.getSubHeadingStyle(context),
        prefixIcon: Icon(
          Icons.category,
          size: AppTheme.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: _categoryOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppTheme.getBodyTextStyle(context).copyWith(
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
    );
  }

  Widget _buildAcademicYearDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedAcademicYear,
      style: AppTheme.getBodyTextStyle(context),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Academic Year *',
        labelStyle: AppTheme.getSubHeadingStyle(context),
        prefixIcon: Icon(
          Icons.calendar_today,
          size: AppTheme.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        filled: true,
        fillColor: Colors.white,
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
            style: AppTheme.getBodyTextStyle(context).copyWith(
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
    );
  }

  Widget _buildClassDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedClass,
      style: AppTheme.getBodyTextStyle(context),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Class to be Admitted In *',
        labelStyle: AppTheme.getSubHeadingStyle(context),
        prefixIcon: Icon(
          Icons.class_,
          size: AppTheme.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        filled: true,
        fillColor: Colors.white,
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
            style: AppTheme.getBodyTextStyle(context).copyWith(
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
                  primary: AppTheme.blue600,
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
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              Icons.date_range,
              color: Colors.grey[600],
              size: AppTheme.getIconSize(context),
            ),
            SizedBox(width: AppTheme.getMediumSpacing(context)),
            Expanded(
              child: Text(
                "Admission Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                style: AppTheme.getBodyTextStyle(context),
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
      style: AppTheme.getBodyTextStyle(context),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Student Type *',
        labelStyle: AppTheme.getSubHeadingStyle(context),
        prefixIcon: Icon(
          Icons.person_outline,
          size: AppTheme.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: [
        'New',
        'Transfer'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppTheme.getBodyTextStyle(context).copyWith(
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
    );
  }

  Widget buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Back',
              onPressed: () => Navigator.pop(context),
              isSecondary: true,
            ),
          ),
        ),
        SizedBox(width: AppTheme.getMediumSpacing(context)),
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Next',
              onPressed: _nextPage,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? Colors.grey[300] : AppTheme.blue600,
        foregroundColor: isSecondary ? Colors.black87 : Colors.white,
        elevation: AppTheme.getButtonElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
      ),
      child: Text(
        text,
        style: AppTheme.getButtonTextStyle(context).copyWith(
          color: isSecondary ? Colors.black87 : Colors.white,
        ),
      ),
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
              style: AppTheme.getBodyTextStyle(context),
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
              style: AppTheme.getBodyTextStyle(context),
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
            style: AppTheme.getBodyTextStyle(context),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}