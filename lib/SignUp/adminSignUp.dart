import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class AdminSignupPage extends StatefulWidget {
  @override
  _AdminSignupPageState createState() => _AdminSignupPageState();
}

class _AdminSignupPageState extends State<AdminSignupPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _animationController;
  late AnimationController _headerAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _headerFadeAnimation;

  // Common Fields Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Specific Fields Controllers
  final _dateOfJoiningController = TextEditingController();

  // Dropdown Values
  String? _selectedRole = 'Admin';
  String? _selectedGender;

  // Password Visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Dropdown Options
  final List<String> _roles = ['Admin', 'Academic Officer'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // Header animation controller
    _headerAnimationController = AnimationController(
      duration: Duration(milliseconds: 600),
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

    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _headerAnimationController.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Animated Header
              FadeTransition(
                opacity: _headerFadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, -1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _headerAnimationController,
                    curve: Curves.easeOutBack,
                  )),
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.defaultSpacing),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back, color: AppTheme.white),
                        ),
                        Expanded(
                          child: Text(
                            'Admin Registration',
                            style: AppTheme.FontStyle.copyWith(fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 48), // Balance the back button
                      ],
                    ),
                  ),
                ),
              ),

              // Animated Form Card
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      margin: EdgeInsets.all(AppTheme.defaultSpacing),
                      child: Card(
                        elevation: AppTheme.cardElevation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppTheme.extraLargeSpacing),
                          child: Form(
                            key: _formKey,
                            child: Scrollbar(
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Animated Title
                                    TweenAnimationBuilder<double>(
                                      duration: Duration(milliseconds: 800),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(30 * (1 - value), 0),
                                          child: Opacity(
                                            opacity: value,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Create Admin Account',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppTheme.blue800,
                                                  ),
                                                ),
                                                SizedBox(height: AppTheme.smallSpacing),
                                                Text(
                                                  'Please fill in all the required information',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: AppTheme.extraLargeSpacing),

                                    // Animated Form Fields
                                    _buildAnimatedTextFormField(
                                      controller: _fullNameController,
                                      label: 'Full Name',
                                      icon: Icons.person,
                                      validator: _validateName,
                                      delay: 100,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    _buildAnimatedTextFormField(
                                      controller: _emailController,
                                      label: 'Email Address',
                                      icon: Icons.email,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _validateEmail,
                                      delay: 200,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    _buildAnimatedTextFormField(
                                      controller: _phoneController,
                                      label: 'Phone Number',
                                      icon: Icons.phone,
                                      keyboardType: TextInputType.phone,
                                      validator: _validatePhone,
                                      delay: 300,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Animated Role Dropdown
                                    _buildAnimatedDropdownField(
                                      value: _selectedRole,
                                      label: 'Role in School',
                                      icon: Icons.admin_panel_settings,
                                      items: _roles,
                                      onChanged: (value) => setState(() => _selectedRole = value),
                                      delay: 400,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Animated Date Field
                                    _buildAnimatedDateField(
                                      controller: _dateOfJoiningController,
                                      label: 'Date of Joining',
                                      icon: Icons.calendar_today,
                                      delay: 500,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Animated Gender Dropdown
                                    _buildAnimatedDropdownField(
                                      value: _selectedGender,
                                      label: 'Gender',
                                      icon: Icons.person_outline,
                                      items: _genders,
                                      onChanged: (value) => setState(() => _selectedGender = value),
                                      isRequired: true,
                                      delay: 600,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Animated Password Fields
                                    _buildAnimatedPasswordField(
                                      controller: _passwordController,
                                      label: 'Password',
                                      obscureText: _obscurePassword,
                                      onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                                      validator: _validatePassword,
                                      delay: 700,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    _buildAnimatedPasswordField(
                                      controller: _confirmPasswordController,
                                      label: 'Confirm Password',
                                      obscureText: _obscureConfirmPassword,
                                      onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                                      validator: _validateConfirmPassword,
                                      delay: 800,
                                    ),
                                    SizedBox(height: AppTheme.extraLargeSpacing),

                                    // Animated Register Button
                                    TweenAnimationBuilder<double>(
                                      duration: Duration(milliseconds: 1000),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: 0.8 + (0.2 * value),
                                          child: Opacity(
                                            opacity: value,
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: AppTheme.buttonHeight,
                                              child: ElevatedButton(
                                                onPressed: _handleRegistration,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppTheme.primaryBlue,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                                  ),
                                                  elevation: AppTheme.buttonElevation,
                                                ),
                                                child: Text(
                                                  'Create Admin Account',
                                                  style: AppTheme.buttonTextStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: AppTheme.mediumSpacing),

                                    // Animated Login Link
                                    TweenAnimationBuilder<double>(
                                      duration: Duration(milliseconds: 1200),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.translate(
                                          offset: Offset(0, 20 * (1 - value)),
                                          child: Opacity(
                                            opacity: value,
                                            child: Center(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context, '/login');
                                                },
                                                child: Text(
                                                  'Already have an account? Login here',
                                                  style: TextStyle(
                                                    color: AppTheme.primaryBlue,
                                                    fontSize: 16,
                                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppTheme.blue600),
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.focusedBorderWidth,
                  ),
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
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - animValue), 0),
          child: Opacity(
            opacity: animValue,
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppTheme.blue600),
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.focusedBorderWidth,
                  ),
                ),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
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
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppTheme.blue600),
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.focusedBorderWidth,
                  ),
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
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: AppTheme.blue600),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.blue600,
                  ),
                  onPressed: onToggleVisibility,
                ),
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide(
                    color: AppTheme.primaryBlue,
                    width: AppTheme.focusedBorderWidth,
                  ),
                ),
              ),
              validator: validator,
            ),
          ),
        );
      },
    );
  }

  // Validation Methods (unchanged)
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
      // Show animated loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppTheme.primaryBlue),
                  SizedBox(height: 16),
                  Text('Creating admin account...'),
                ],
              ),
            ),
          ),
        ),
      );

      // Simulate API call with animation
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Admin account created successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to admin dashboard
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/admin-dashboard',
              (route) => false,
        );
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _headerAnimationController.dispose();
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