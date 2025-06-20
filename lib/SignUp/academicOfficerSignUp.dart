import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class AcademicOfficerSignupPage extends StatefulWidget {
  @override
  _AcademicOfficerSignupPageState createState() => _AcademicOfficerSignupPageState();
}

class _AcademicOfficerSignupPageState extends State<AcademicOfficerSignupPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Common Fields Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Specific Fields Controllers
  final _dateOfJoiningController = TextEditingController();

  // Dropdown Values
  String? _selectedRole = 'Academic Officer';
  String? _selectedGender;

  // Password Visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Dropdown Options
  final List<String> _roles = ['Academic Officer', 'Admin'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              child: Column(
                children: [
                  // Header
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: AppTheme.getScreenPadding(context),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppTheme.white,
                              size: AppTheme.getHeaderIconSize(context),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Academic Officer Registration',
                              style: AppTheme.getFontStyle(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: AppTheme.getHeaderIconSize(context) + 16), // Balance the back button
                        ],
                      ),
                    ),
                  ),

                  // Form Card
                  Expanded(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: AppTheme.getScreenPadding(context),
                            child: Card(
                              elevation: AppTheme.getCardElevation(context),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: AppTheme.getCardPadding(context),
                                child: Form(
                                  key: _formKey,
                                  child: Scrollbar(
                                    controller: _scrollController,
                                    child: SingleChildScrollView(
                                      controller: _scrollController,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Title Section
                                          Text(
                                            'Create Account',
                                            style: AppTheme.getHeadingStyle(context).copyWith(
                                              fontSize: AppTheme.isMobile(context) ? 24 : (AppTheme.isTablet(context) ? 28 : 32),
                                              color: AppTheme.blue800,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: AppTheme.getSmallSpacing(context)),
                                          Text(
                                            'Please fill in all the required information',
                                            style: AppTheme.getSubHeadingStyle(context),
                                          ),
                                          SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                                          // Form Fields
                                          _buildAnimatedTextField(
                                            controller: _fullNameController,
                                            label: 'Full Name',
                                            icon: Icons.person,
                                            validator: _validateName,
                                            delay: 100,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedTextField(
                                            controller: _emailController,
                                            label: 'Email Address',
                                            icon: Icons.email,
                                            keyboardType: TextInputType.emailAddress,
                                            validator: _validateEmail,
                                            delay: 200,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedTextField(
                                            controller: _phoneController,
                                            label: 'Phone Number',
                                            icon: Icons.phone,
                                            keyboardType: TextInputType.phone,
                                            validator: _validatePhone,
                                            delay: 300,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedDropdownField(
                                            value: _selectedRole,
                                            label: 'Role in School',
                                            icon: Icons.work,
                                            items: _roles,
                                            onChanged: (value) => setState(() => _selectedRole = value),
                                            delay: 400,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedDateField(
                                            controller: _dateOfJoiningController,
                                            label: 'Date of Joining',
                                            icon: Icons.calendar_today,
                                            delay: 500,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedDropdownField(
                                            value: _selectedGender,
                                            label: 'Gender',
                                            icon: Icons.person_outline,
                                            items: _genders,
                                            onChanged: (value) => setState(() => _selectedGender = value),
                                            isRequired: true,
                                            delay: 600,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedPasswordField(
                                            controller: _passwordController,
                                            label: 'Password',
                                            obscureText: _obscurePassword,
                                            onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                                            validator: _validatePassword,
                                            delay: 700,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedPasswordField(
                                            controller: _confirmPasswordController,
                                            label: 'Confirm Password',
                                            obscureText: _obscureConfirmPassword,
                                            onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                                            validator: _validateConfirmPassword,
                                            delay: 800,
                                          ),
                                          SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                                          // Register Button
                                          TweenAnimationBuilder<double>(
                                            duration: Duration(milliseconds: 1000),
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            builder: (context, value, child) {
                                              return Transform.scale(
                                                scale: value,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: AppTheme.getButtonHeight(context),
                                                  child: ElevatedButton(
                                                    onPressed: _handleRegistration,
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppTheme.primaryBlue,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                                                      ),
                                                      elevation: AppTheme.getButtonElevation(context),
                                                    ),
                                                    child: Text(
                                                      'Create Account',
                                                      style: AppTheme.getButtonTextStyle(context),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          // Login Link
                                          TweenAnimationBuilder<double>(
                                            duration: Duration(milliseconds: 1200),
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            builder: (context, value, child) {
                                              return Opacity(
                                                opacity: value,
                                                child: Center(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(context, '/login');
                                                    },
                                                    child: Text(
                                                      'Already have an account? Login here',
                                                      style: AppTheme.getSubHeadingStyle(context).copyWith(
                                                        color: AppTheme.primaryBlue,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: AppTheme.getTextFieldMaxLines(context),
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                labelText: label,
                labelStyle: AppTheme.getSubHeadingStyle(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.getFocusedBorderWidth(context),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppTheme.getDefaultSpacing(context),
                  vertical: AppTheme.getMediumSpacing(context),
                ),
              ),
              validator: validator,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDropdownField({
    required String? value,
    required String label,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
    bool isRequired = false,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - animValue), 0),
          child: Opacity(
            opacity: animValue,
            child: DropdownButtonFormField<String>(
              value: value,
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                labelText: label,
                labelStyle: AppTheme.getSubHeadingStyle(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.getFocusedBorderWidth(context),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppTheme.getDefaultSpacing(context),
                  vertical: AppTheme.getMediumSpacing(context),
                ),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTheme.getBodyTextStyle(context),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              validator: isRequired ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select $label';
                }
                return null;
              } : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDateField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              readOnly: true,
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                labelText: label,
                labelStyle: AppTheme.getSubHeadingStyle(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.getFocusedBorderWidth(context),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppTheme.getDefaultSpacing(context),
                  vertical: AppTheme.getMediumSpacing(context),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select date of joining';
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.blue600,
                    size: AppTheme.getIconSize(context),
                  ),
                  onPressed: onToggleVisibility,
                ),
                labelText: label,
                labelStyle: AppTheme.getSubHeadingStyle(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.getFocusedBorderWidth(context),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppTheme.getDefaultSpacing(context),
                  vertical: AppTheme.getMediumSpacing(context),
                ),
              ),
              validator: validator,
            ),
          ),
        );
      },
    );
  }

  // Validation Methods
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.trim().length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: AppTheme.primaryBlue,
            strokeWidth: AppTheme.isMobile(context) ? 3.0 : 4.0,
          ),
        ),
      );

      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account created successfully!',
              style: AppTheme.getBodyTextStyle(context).copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(AppTheme.getDefaultSpacing(context)),
          ),
        );

        // Navigate to dashboard
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
              (route) => false,
        );
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
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