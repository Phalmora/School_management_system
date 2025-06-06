import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class TeacherSignupPage extends StatefulWidget {
  @override
  _TeacherSignupPageState createState() => _TeacherSignupPageState();
}

class _TeacherSignupPageState extends State<TeacherSignupPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
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
  void dispose() {
    _animationController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.defaultSpacing),
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: AppTheme.white),
                      ),
                      Text(
                        'Teacher Signup',
                        style: AppTheme.FontStyle.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.defaultSpacing),

                Expanded(
                  child: Center(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Card(
                          elevation: AppTheme.cardElevation,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppTheme.extraLargeSpacing),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create Teacher Account',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.blue800,
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.smallSpacing),
                                    Text(
                                      'Please fill in your details to register',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: AppTheme.extraLargeSpacing),

                                    // Full Name Field
                                    _buildAnimatedTextField(
                                      controller: _fullNameController,
                                      icon: Icons.person,
                                      label: 'Full Name',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your full name';
                                        }
                                        return null;
                                      },
                                      delay: 100,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Email Field
                                    _buildAnimatedTextField(
                                      controller: _emailController,
                                      icon: Icons.email,
                                      label: 'Email Address',
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                      delay: 200,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Phone Number Field
                                    _buildAnimatedTextField(
                                      controller: _phoneController,
                                      icon: Icons.phone,
                                      label: 'Phone Number',
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                        if (value.length < 10) {
                                          return 'Please enter a valid phone number';
                                        }
                                        return null;
                                      },
                                      delay: 300,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Subject/Department Dropdown
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select your subject';
                                        }
                                        return null;
                                      },
                                      delay: 400,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Date of Birth Field
                                    _buildAnimatedDateField(
                                      icon: Icons.cake,
                                      label: 'Date of Birth',
                                      selectedDate: _selectedDateOfBirth,
                                      onTap: _selectDateOfBirth,
                                      delay: 500,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Gender Dropdown
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select your gender';
                                        }
                                        return null;
                                      },
                                      delay: 600,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Joining Date Field
                                    _buildAnimatedDateField(
                                      icon: Icons.work,
                                      label: 'Joining Date',
                                      selectedDate: _selectedJoiningDate,
                                      onTap: _selectJoiningDate,
                                      delay: 700,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Password Field
                                    _buildAnimatedTextField(
                                      controller: _passwordController,
                                      icon: Icons.lock,
                                      label: 'Password',
                                      obscureText: _obscurePassword,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                          color: AppTheme.blue600,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                      delay: 800,
                                    ),
                                    SizedBox(height: AppTheme.defaultSpacing),

                                    // Confirm Password Field
                                    _buildAnimatedTextField(
                                      controller: _confirmPasswordController,
                                      icon: Icons.lock_outline,
                                      label: 'Confirm Password',
                                      obscureText: _obscureConfirmPassword,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                          color: AppTheme.blue600,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword = !_obscureConfirmPassword;
                                          });
                                        },
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        }
                                        if (value != _passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      delay: 900,
                                    ),
                                    SizedBox(height: AppTheme.extraLargeSpacing),

                                    // Signup Button
                                    TweenAnimationBuilder<double>(
                                      duration: Duration(milliseconds: 1000),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: AppTheme.buttonHeight,
                                            child: ElevatedButton(
                                              onPressed: _isLoading ? null : _handleTeacherSignup,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppTheme.primaryBlue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                                ),
                                                elevation: AppTheme.buttonElevation,
                                              ),
                                              child: _isLoading
                                                  ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                ),
                                              )
                                                  : Text(
                                                'Create Account',
                                                style: AppTheme.buttonTextStyle,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    bool obscureText = false,
    Widget? suffixIcon,
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
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppTheme.blue600),
                suffixIcon: suffixIcon,
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
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppTheme.blue600),
                suffixIcon: Icon(Icons.calendar_today, color: AppTheme.blue600),
                labelText: label,
                hintText: selectedDate != null
                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                    : 'Select $label',
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

        // TODO: Implement your signup logic here
        // This could involve calling an API, Firebase Auth, etc.
        // For now, we'll simulate a network call
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
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Success!'),
            ],
          ),
          content: Text('Teacher account created successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/teacher-dashboard');
              },
              child: Text('OK', style: TextStyle(color: AppTheme.primaryBlue)),
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
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red, size: 30),
              SizedBox(width: 10),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: TextStyle(color: AppTheme.primaryBlue)),
            ),
          ],
        );
      },
    );
  }
}