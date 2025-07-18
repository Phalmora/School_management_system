import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/dropDownCommon.dart';
import 'package:school/customWidgets/inputField.dart';
import 'package:school/customWidgets/button.dart';
import 'package:school/customWidgets/loginCustomWidgets/loginSPanText.dart';
import 'package:school/customWidgets/loginCustomWidgets/signUpTitle.dart';
import 'package:school/customWidgets/snackBar.dart';
import 'package:school/customWidgets/validation.dart';

class ParentSignUpPage extends StatefulWidget {
  @override
  _ParentSignUpPageState createState() => _ParentSignUpPageState();
}

class _ParentSignUpPageState extends State<ParentSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _childAdmissionNoController = TextEditingController();

  // Dropdown Values
  String? _selectedRelationship;

  // Password Visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

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
                    // Responsive Title Section using reusable widget
                    TitleSection(accountType: 'Parent'),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Responsive Form Fields Layout
                    _buildFormLayout(context),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Responsive Register Button using reusable CustomButton
                    PrimaryButton(
                      title: 'Create Account',
                      onPressed: _isLoading ? null : _handleParentSignup,
                      isLoading: _isLoading,
                      icon: _isLoading ? null : Icon(Icons.person_add, color: Colors.white),
                    ),

                    SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

                    // Responsive Login Link using reusable widget
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
      columns = 3; // For desktop, we want 3 columns for the first row
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: largeSpacing, // Horizontal spacing between items
          runSpacing: spacing, // Vertical spacing between lines of items
          alignment: WrapAlignment.center, // Center items when they wrap
          children: [
            // Row 1: Full Name, Email, Phone (3 columns on desktop, 2 on tablet, 1 on mobile)
            SizedBox(
              width: _getFieldWidth(constraints, columns, largeSpacing),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _fullNameController,
                label: 'Full Name',
                icon: Icons.person,
                validator: ValidationUtils.validateFullName,
              ),
            ),
            SizedBox(
              width: _getFieldWidth(constraints, columns, largeSpacing),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
            ),
            if (AppThemeResponsiveness.isDesktop(context))
              SizedBox(
                width: _getFieldWidth(constraints, columns, largeSpacing),
                child: AppTextFieldBuilder.build(
                  context: context,
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: ValidationUtils.validatePhone,
                ),
              ),

            // Row 2: Phone (for tablet/mobile), Relationship to Child
            if (!AppThemeResponsiveness.isDesktop(context))
              SizedBox(
                width: _getFieldWidth(constraints, columns, largeSpacing),
                child: AppTextFieldBuilder.build(
                  context: context,
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: ValidationUtils.validatePhone,
                ),
              ),
            SizedBox(
              width: _getFieldWidth(constraints, columns, largeSpacing),
              child: AppDropdown.relationship(
                value: _selectedRelationship,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRelationship = newValue;
                  });
                },
                // Optional: Provide custom relationships if needed
                customRelationships: const ['Father', 'Mother', 'Guardian'], // You can remove this line to use default comprehensive list
              ),
            ),

            // Row 3: Child's Admission Number (Special handling for desktop to center it)
            if (AppThemeResponsiveness.isDesktop(context))
              SizedBox(
                width: constraints.maxWidth * 0.5, // Take up 50% of the available width to center
                child: AppTextFieldBuilder.build(
                  context: context,
                  controller: _childAdmissionNoController,
                  label: 'Child\'s Admission Number',
                  icon: Icons.confirmation_number,
                  keyboardType: TextInputType.text,
                  validator: _validateChildAdmissionNo,
                ),
              )
            else
              SizedBox(
                width: _getFieldWidth(constraints, columns, largeSpacing),
                child: AppTextFieldBuilder.build(
                  context: context,
                  controller: _childAdmissionNoController,
                  label: 'Child\'s Admission Number',
                  icon: Icons.confirmation_number,
                  keyboardType: TextInputType.text,
                  validator: _validateChildAdmissionNo,
                ),
              ),

            // Row 4: Password, Confirm Password
            SizedBox(
              width: _getFieldWidth(constraints, columns, largeSpacing),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: const Color(0xFF6B7280),
                    size: AppThemeResponsiveness.getIconSize(context) * 0.9,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: ValidationUtils.validatePassword,
              ),
            ),
            SizedBox(
              width: _getFieldWidth(constraints, columns, largeSpacing),
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: const Color(0xFF6B7280),
                    size: AppThemeResponsiveness.getIconSize(context) * 0.9,
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

  // Helper method to calculate field width based on columns and spacing
  double _getFieldWidth(BoxConstraints constraints, int columns, double spacing) {
    if (columns == 1) {
      return double.infinity;
    }
    return (constraints.maxWidth - (spacing * (columns - 1))) / columns;
  }

  // Validation Methods specific to Parent signup
  String? _validateChildAdmissionNo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter child\'s admission number';
    }
    if (value.trim().length < 3) {
      return 'Admission number must be at least 3 characters';
    }
    return null;
  }

  void _handleParentSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));

        // Show success message
        if (mounted) {
          AppSnackBar.show(
            context,
            message: 'Parent account created successfully!',
            backgroundColor: Colors.green,
            icon: Icons.check_circle_outline,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
                (route) => false,
          );
        }
      } catch (error) {
        // Handle error
        if (mounted) {
          AppSnackBar.show(
            context,
            message: 'Failed to create account. Please try again.',
            backgroundColor: Colors.red,
            icon: Icons.error,
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
    _childAdmissionNoController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}