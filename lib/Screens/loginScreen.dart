import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/inputField.dart';
import 'package:school/customWidgets/loginCustomWidgets/userTypeSelection.dart'; // Import the new widget

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _userType;
  bool _showUserTypeError = false;

  @override
  void initState() {
    super.initState();
    // Set user as guest when login screen loads
    UserService.instance.setGuestUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      backgroundColor: AppThemeColor.blue50,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (AppThemeResponsiveness.isDesktop(context)) {
                return _buildDesktopLayout();
              } else {
                return _buildMobileLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left side - Welcome section
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getLargeSpacing(context)),
            constraints: BoxConstraints(
              maxWidth: AppThemeResponsiveness.getMaxWidth(context) * 0.5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                Text(
                  'Streamline your educational experience with our comprehensive school management system.',
                  style: AppThemeResponsiveness.getSplashSubtitleStyle(context).copyWith(
                    fontSize: AppThemeResponsiveness.isDesktop(context) ? 18 : 16,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right side - Login form
        Expanded(
          flex: 1,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 500,
              maxHeight: AppThemeResponsiveness.getScreenHeight(context) * 0.9,
            ),
            padding: AppThemeResponsiveness.getScreenPadding(context),
            child: Center(
              child: SingleChildScrollView(
                child: _buildLoginForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Header section with reduced height
        Container(
          height: AppThemeResponsiveness.getScreenHeight(context) * 0.25,
          child: _buildHeader(),
        ),
        // Login form section - takes remaining space
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  AppThemeResponsiveness.getSmallSpacing(context),
            ),
            child: _buildLoginForm(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppThemeResponsiveness.isDesktop(context)
            ? AppThemeResponsiveness.getDashboardCardPadding(context)
            : AppThemeResponsiveness.getSmallSpacing(context),
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: AppThemeResponsiveness.isDesktop(context)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'login_logo',
            child: Container(
              width: AppThemeResponsiveness.isDesktop(context)
                  ? AppThemeResponsiveness.getLogoSize(context) * 1.5
                  : AppThemeResponsiveness.getLogoSize(context) * 1.2,
              height: AppThemeResponsiveness.isDesktop(context)
                  ? AppThemeResponsiveness.getLogoSize(context) * 1.5
                  : AppThemeResponsiveness.getLogoSize(context) * 1.2,
              decoration: BoxDecoration(
                color: AppThemeColor.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.school_rounded,
                size: AppThemeResponsiveness.isDesktop(context)
                    ? AppThemeResponsiveness.getLogoSize(context) * 0.75
                    : AppThemeResponsiveness.getLogoSize(context) * 0.6,
                color: AppThemeColor.primaryBlue600,
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Text(
            'Welcome Back!',
            style: AppThemeResponsiveness.getFontStyle(context).copyWith(
              fontSize: AppThemeResponsiveness.isSmallPhone(context)
                  ? 22
                  : AppThemeResponsiveness.isMobile(context)
                  ? 26
                  : 32,
              letterSpacing: -0.5,
            ),
            textAlign: AppThemeResponsiveness.isDesktop(context)
                ? TextAlign.left
                : TextAlign.center,
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
          Text(
            'Sign in to continue your learning journey',
            style: AppThemeResponsiveness.getSplashSubtitleStyle(context).copyWith(
              height: 1.3,
              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 13 : 14,
            ),
            textAlign: AppThemeResponsiveness.isDesktop(context)
                ? TextAlign.left
                : TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: AppThemeResponsiveness.getHorizontalPadding(context),
      constraints: BoxConstraints(
        maxWidth: AppThemeResponsiveness.isDesktop(context) ? 500 : double.infinity,
      ),
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getCardBorderRadius(context),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: AppThemeResponsiveness.getCardPadding(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login as',
                style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.getBodyTextStyle(context).fontSize! + 2,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              // User Type Selection Widget
              UserTypeSelection(
                selectedUserType: _userType,
                onUserTypeSelected: (userType) {
                  setState(() {
                    _userType = userType;
                    _showUserTypeError = false;
                  });
                },
                showError: _showUserTypeError,
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

              // Name Field
              AppTextFieldBuilder.build(
                context: context,
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
                validator: (value) =>
                value?.isEmpty ?? true
                    ? 'Please enter your full name'
                    : null,
              ),
              SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

              // Password Field
              AppTextFieldBuilder.build(
                context: context,
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: const Color(0xFF6B7280),
                    size: AppThemeResponsiveness.getIconSize(context) * 0.9,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your password' : null,
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

              // Remember Me Row
              _buildRememberMeRow(),
              SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

              // Login Button
              _buildLoginButton(),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

              // Divider
              _buildDivider(),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

              // Quick Actions
              _buildQuickActions(),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberMe = !_rememberMe;
            });
            HapticFeedback.lightImpact();
          },
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _rememberMe ? AppThemeColor.primaryBlue : Colors.transparent,
                  border: Border.all(
                    color: _rememberMe ? AppThemeColor.primaryBlue : const Color(0xFFD1D5DB),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _rememberMe
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Remember me',
                style: AppThemeResponsiveness.getCaptionTextStyle(context),
              ),
            ],
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forget-password');
          },
          child: Text(
            'Forgot Password?',
            style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
              color: AppThemeColor.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: AppThemeResponsiveness.getButtonHeight(context),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getButtonBorderRadius(context),
        ),
        boxShadow: [
          BoxShadow(
            color: AppThemeColor.primaryBlue.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppThemeResponsiveness.getButtonBorderRadius(context),
            ),
          ),
        ),
        child: _isLoading
            ? SizedBox(
          height: 24,
          width: 24,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        )
            : Text(
          'Sign In',
          style: AppThemeResponsiveness.getButtonTextStyle(context),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeResponsiveness.getMediumSpacing(context),
          ),
          child: Text(
            'or',
            style: AppThemeResponsiveness.getCaptionTextStyle(context),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      children: [
        AppThemeResponsiveness.isMobile(context)
            ? Column(
          children: [
            _buildQuickActionButton(
              'Change Password',
              Icons.lock_reset_rounded,
                  () => Navigator.pushNamed(context, '/change-password'),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            _buildQuickActionButton(
                'New Admission',
                Icons.person_add_rounded,
                    () => Navigator.pushNamedAndRemoveUntil(context,
                    '/admission-main',(route) => false)
            ),
          ],
        )
            : Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(
                'Change Password',
                Icons.lock_reset_rounded,
                    () => Navigator.pushNamed(context, '/change-password'),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Expanded(
              child: _buildQuickActionButton(
                'New Admission',
                Icons.person_add_rounded,
                    () => Navigator.pushNamed(context, '/admission-main'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
      String title, IconData icon, VoidCallback onTap) {
    return Container(
      height: AppThemeResponsiveness.getButtonHeight(context) * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getInputBorderRadius(context),
        ),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            AppThemeResponsiveness.getInputBorderRadius(context),
          ),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AppThemeResponsiveness.getIconSize(context) * 0.7,
                color: const Color(0xFF6B7280),
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                title,
                style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF374151),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    bool isFormValid = _formKey.currentState!.validate();

    if (_userType == null) {
      setState(() {
        _showUserTypeError = true;
      });
    }

    if (!isFormValid || _userType == null) {
      if (_userType == null) {
        _showError('Please select a user type');
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Determine user role from selected user type
      UserRole role = _determineUserRole(_userType!);

      // Set user in service using the LoginExample helper
      UserService.instance.setUser(
        role: role,
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}', // Generate a temporary user ID
        userDetails: {
          'name': _nameController.text,
          'userType': _userType,
          'loginTime': DateTime.now().toIso8601String(),
        },
      );

      setState(() => _isLoading = false);

      // Navigate to appropriate dashboard using the role-based navigation service
      RoleBasedNavigationService.navigateBasedOnRole(context);

    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Login failed: ${e.toString()}');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppThemeResponsiveness.getInputBorderRadius(context),
          ),
        ),
        margin: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  UserRole _determineUserRole(String userType) {
    switch (userType.toLowerCase()) {
      case 'student':
        return UserRole.student;
      case 'teacher':
        return UserRole.teacher;
      case 'admin':
        return UserRole.admin;
      case 'parent':
        return UserRole.parent;
      case 'academic officer':
        return UserRole.academicOfficer;
      default:
        return UserRole.guest;
    }
  }
}