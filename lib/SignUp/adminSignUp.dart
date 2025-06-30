import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/datePicker.dart';
import 'package:school/customWidgets/inputField.dart';
import 'package:school/customWidgets/button.dart';
import 'package:school/customWidgets/loginCustomWidgets/loginSPanText.dart';
import 'package:school/customWidgets/loginCustomWidgets/signUpTitle.dart';
import 'package:school/customWidgets/validation.dart';

class AdminSignupPage extends StatefulWidget {
  @override
  _AdminSignupPageState createState() => _AdminSignupPageState();
}

class _AdminSignupPageState extends State<AdminSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Date Controllers - Using TextEditingController for AppDatePicker
  final _dateOfJoiningController = TextEditingController();

  // Password Visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Dropdown Values
  String? _selectedRole = 'Admin';
  String? _selectedGender;

  // Dropdown Options
  final List<String> _roles = ['Admin', 'Academic Officer'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

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
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppThemeResponsiveness.getMaxWidth(context),
              ),
              child: _buildResponsiveFormCard(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveFormCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
      ),
      child: Card(
        elevation: AppThemeResponsiveness.getCardElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Container(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: !AppThemeResponsiveness.isMobile(context),
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Responsive Title Section using reusable component
                    TitleSection(accountType: 'Admin'),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Responsive Form Fields Layout
                    _buildFormLayout(context),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Responsive Register Button using reusable CustomButton
                    PrimaryButton(
                      title: 'Create Account',
                      onPressed: _isLoading ? null : _handleAdminSignup,
                      isLoading: _isLoading,
                      icon: _isLoading ? null : Icon(Icons.admin_panel_settings, color: Colors.white),
                    ),

                    SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                    LoginRedirectText(context: context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormLayout(BuildContext context) {
    final double spacing = AppThemeResponsiveness.getMediumSpacing(context);
    final double largeSpacing = AppThemeResponsiveness.getLargeSpacing(context);

    // Determine the number of columns based on screen size
    int columns;
    if (AppThemeResponsiveness.isMobile(context)) {
      columns = 1;
    } else if (AppThemeResponsiveness.isTablet(context)) {
      columns = 2;
    } else { // Desktop
      columns = 3; // For desktop, we can have 3 columns for admin form
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: largeSpacing, // Horizontal spacing between items
          runSpacing: spacing, // Vertical spacing between lines of items
          alignment: WrapAlignment.center, // Center items when they wrap
          children: [
            // Full Name
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _fullNameController,
                label: 'Full Name',
                icon: Icons.person,
                validator: ValidationUtils.validateFullName,
              ),
            ),
            // Email Address
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
            ),
            // Phone Number
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: ValidationUtils.validatePhone,
              ),
            ),
            // Role Dropdown
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: _buildStyledDropdownField(
                value: _selectedRole,
                items: _roles,
                label: 'Role',
                icon: Icons.assignment_ind,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                validator: ValidationUtils.validateRole,
              ),
            ),
            // Gender Dropdown
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: _buildStyledDropdownField(
                value: _selectedGender,
                items: _genders,
                label: 'Gender',
                icon: Icons.people,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                validator: ValidationUtils.validateGender,
              ),
            ),
            // Date of Joining - Using AppDatePicker
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: AppDatePicker.genericDate(
                controller: _dateOfJoiningController,
                label: 'Date of Joining',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select date of joining';
                  }
                  return ValidationUtils.validateJoiningDate(_parseDateFromString(value));
                },
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 365 * 10)), // 10 years ago
                lastDate: DateTime.now(),
                dateFormat: 'dd/MM/yyyy',
              ),
            ),
            // Password
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: Colors.grey[600],
                    size: AppThemeResponsiveness.getIconSize(context),
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: ValidationUtils.validatePassword,
              ),
            ),
            // Confirm Password
            SizedBox(
              width: _getFieldWidth(context, constraints, columns),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: Colors.grey[600],
                    size: AppThemeResponsiveness.getIconSize(context),
                  ),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                validator: (value) => ValidationUtils.validateConfirmPassword(value, _passwordController.text),
              ),
            ),
          ],
        );
      },
    );
  }

  double _getFieldWidth(BuildContext context, BoxConstraints constraints, int columns) {
    if (columns == 1) {
      return double.infinity;
    } else {
      final double largeSpacing = AppThemeResponsiveness.getLargeSpacing(context);
      return (constraints.maxWidth / columns) - (largeSpacing * (columns - 1) / columns);
    }
  }

  // Reusable styled dropdown field to match AppTextFieldBuilder styling
  Widget _buildStyledDropdownField({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: AppThemeResponsiveness.getBodyTextStyle(context),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      style: AppThemeResponsiveness.getBodyTextStyle(context),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppThemeResponsiveness.getSubHeadingStyle(context),
        prefixIcon: Icon(
          icon,
          size: AppThemeResponsiveness.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppThemeResponsiveness.getInputBorderRadius(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppThemeResponsiveness.getInputBorderRadius(context),
          ),
          borderSide: BorderSide(
            color: AppThemeColor.blue600,
            width: AppThemeResponsiveness.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppThemeResponsiveness.getInputBorderRadius(context),
          ),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppThemeResponsiveness.getInputBorderRadius(context),
          ),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDefaultSpacing(context) * 1.5,
          vertical: AppThemeResponsiveness.getSmallSpacing(context) * 2.5,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      dropdownColor: Colors.white,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey[600],
        size: AppThemeResponsiveness.getIconSize(context),
      ),
    );
  }

  // Helper method to parse date from string for validation
  DateTime? _parseDateFromString(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
      }
    } catch (e) {
      debugPrint('Error parsing date: $e');
    }
    return null;
  }

  void _handleAdminSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Admin account created successfully!',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
            ),
          );

          // Navigate to login page
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
                (route) => false,
          );
        }
      } catch (error) {
        // Handle error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to create admin account. Please try again.',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateOfJoiningController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}