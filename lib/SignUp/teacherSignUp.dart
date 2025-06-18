import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class TeacherSignupPage extends StatefulWidget {
  @override
  _TeacherSignupPageState createState() => _TeacherSignupPageState();
}

class _TeacherSignupPageState extends State<TeacherSignupPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Form Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _subjectController = TextEditingController();

  // Password Visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Dropdown values
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;
  DateTime? _selectedJoiningDate;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _subjects = [
    'Mathematics', 'Science', 'English', 'Hindi', 'Social Studies',
    'Physics', 'Chemistry', 'Biology', 'Computer Science', 'Physical Education'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.slideAnimationDuration,
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
                              'Teacher Registration',
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
                                            'Create Teacher Account',
                                            style: AppTheme.getHeadingStyle(context).copyWith(
                                              fontSize: AppTheme.isMobile(context) ? 24 : (AppTheme.isTablet(context) ? 28 : 32),
                                              color: AppTheme.blue800,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: AppTheme.getSmallSpacing(context)),
                                          Text(
                                            'Please fill in your details to register',
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

                                          _buildAnimatedDropdown(
                                            icon: Icons.school,
                                            label: 'Subject/Department',
                                            value: _subjectController.text.isEmpty ? null : _subjectController.text,
                                            items: _subjects,
                                            onChanged: (value) {
                                              setState(() {
                                                _subjectController.text = value ?? '';
                                              });
                                            },
                                            validator: _validateSubject,
                                            delay: 400,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedDateField(
                                            icon: Icons.cake,
                                            label: 'Date of Birth',
                                            selectedDate: _selectedDateOfBirth,
                                            onTap: _selectDateOfBirth,
                                            delay: 500,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedDropdown(
                                            icon: Icons.person_outline,
                                            label: 'Gender',
                                            value: _selectedGender,
                                            items: _genders,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedGender = value;
                                              });
                                            },
                                            validator: _validateGender,
                                            delay: 600,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedDateField(
                                            icon: Icons.work,
                                            label: 'Joining Date',
                                            selectedDate: _selectedJoiningDate,
                                            onTap: _selectJoiningDate,
                                            delay: 700,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedPasswordField(
                                            controller: _passwordController,
                                            label: 'Password',
                                            obscureText: _obscurePassword,
                                            onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                                            validator: _validatePassword,
                                            delay: 800,
                                          ),
                                          SizedBox(height: AppTheme.getMediumSpacing(context)),

                                          _buildAnimatedPasswordField(
                                            controller: _confirmPasswordController,
                                            label: 'Confirm Password',
                                            obscureText: _obscureConfirmPassword,
                                            onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                                            validator: _validateConfirmPassword,
                                            delay: 900,
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
                                                    onPressed: _isLoading ? null : _handleTeacherSignup,
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppTheme.primaryBlue,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                                                      ),
                                                      elevation: AppTheme.getButtonElevation(context),
                                                    ),
                                                    child: _isLoading
                                                        ? SizedBox(
                                                      height: AppTheme.isMobile(context) ? 20 : 24,
                                                      width: AppTheme.isMobile(context) ? 20 : 24,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: AppTheme.isMobile(context) ? 2 : 3,
                                                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
                                                      ),
                                                    )
                                                        : Text(
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
                                                        fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 15 : 16),
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

  Widget _buildAnimatedDropdown({
    required IconData icon,
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
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
              validator: validator,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDateField({
    required IconData icon,
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
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
              readOnly: true,
              onTap: onTap,
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                labelText: label,
                labelStyle: AppTheme.getSubHeadingStyle(context),
                hintText: selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'Select $label',
                hintStyle: AppTheme.getBodyTextStyle(context),
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
              validator: (value) {
                if (selectedDate == null) {
                  return 'Please select $label';
                }
                return null;
              },
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

  String? _validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your subject';
    }
    return null;
  }

  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
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

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 25)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppTheme.primaryBlue),
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
  }

  Future<void> _selectJoiningDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppTheme.primaryBlue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedJoiningDate) {
      setState(() {
        _selectedJoiningDate = picked;
      });
    }
  }

  Future<void> _handleTeacherSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Collect all form data
        final teacherData = {
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'subject': _subjectController.text,
          'dateOfBirth': _selectedDateOfBirth?.toIso8601String(),
          'gender': _selectedGender,
          'joiningDate': _selectedJoiningDate?.toIso8601String(),
          'password': _passwordController.text,
        };

        // Simulate API call
        await Future.delayed(Duration(seconds: 2));

        // Show success message
        _showSuccessDialog();

      } catch (error) {
        // Show error message
        _showErrorDialog(error.toString());
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: AppTheme.getIconSize(context),
              ),
              SizedBox(width: AppTheme.getSmallSpacing(context)),
              Text(
                'Success!',
                style: AppTheme.getHeadingStyle(context),
              ),
            ],
          ),
          content: Text(
            'Teacher account created successfully!',
            style: AppTheme.getBodyTextStyle(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/teacher-dashboard',
                      (route) => false,
                );
              },
              child: Text(
                'OK',
                style: AppTheme.getBodyTextStyle(context).copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
                size: AppTheme.getIconSize(context),
              ),
              SizedBox(width: AppTheme.getSmallSpacing(context)),
              Text(
                'Error',
                style: AppTheme.getHeadingStyle(context),
              ),
            ],
          ),
          content: Text(
            message,
            style: AppTheme.getBodyTextStyle(context),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: AppTheme.getBodyTextStyle(context).copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _subjectController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}