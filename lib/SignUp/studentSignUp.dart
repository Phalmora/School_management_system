import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/inputField.dart';
import 'package:school/customWidgets/button.dart';
import 'package:school/customWidgets/loginCustomWidgets/loginSPanText.dart';
import 'package:school/customWidgets/loginCustomWidgets/signUpTitle.dart';
import 'package:school/customWidgets/snackBar.dart';
import 'package:school/customWidgets/validation.dart';

class StudentSignupPage extends StatefulWidget {
  @override
  _StudentSignupPageState createState() => _StudentSignupPageState();
}

class _StudentSignupPageState extends State<StudentSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                    // Responsive Title Section
                    TitleSection(accountType: 'Student'),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Responsive Form Fields Layout
                    _buildFormLayout(context),

                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                    // Responsive Register Button using CustomButton
                    PrimaryButton(
                      title: 'Create Account',
                      onPressed: _isLoading ? null : _handleStudentSignup,
                      isLoading: _isLoading,
                      icon: _isLoading ? null : Icon(Icons.person_add, color: Colors.white),
                    ),

                    SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                    LoginRedirectText(context: context)
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
      columns = 2; // For desktop, we want 2 columns for most fields, and a centered phone field
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
              width: columns == 1 ? double.infinity : constraints.maxWidth / columns - largeSpacing / 2,
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
              width: columns == 1 ? double.infinity : constraints.maxWidth / columns - largeSpacing / 2,
              child: AppTextFieldBuilder.build(
                context: context,
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
            ),
            // Phone Number (Special handling for desktop to center it)
            if (AppThemeResponsiveness.isDesktop(context))
              SizedBox(
                width: constraints.maxWidth * 0.5, // Take up 50% of the available width to center
                child: AppTextFieldBuilder.build(
                  context: context,
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: ValidationUtils.validatePhone,
                ),
              )
            else
              SizedBox(
                width: columns == 1 ? double.infinity : constraints.maxWidth / columns - largeSpacing / 2,
                child: AppTextFieldBuilder.build(
                  context: context,
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: ValidationUtils.validatePhone,
                ),
              ),
            // Password
            SizedBox(
              width: columns == 1 ? double.infinity : constraints.maxWidth / columns - largeSpacing / 2,
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
            // Confirm Password
            SizedBox(
              width: columns == 1 ? double.infinity : constraints.maxWidth / columns - largeSpacing / 2,
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

  void _handleStudentSignup() async {
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
            message: 'Student account created successfully!',
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
    _scrollController.dispose();
    super.dispose();
  }
}