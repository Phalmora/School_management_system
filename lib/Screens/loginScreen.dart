import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _userType;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _shakeAnimation;

  final List<Map<String, dynamic>> _userTypes = [
    {
      'value': 'Student',
      'icon': Icons.school_rounded,
      'color': AppTheme.blue400
    },
    {
      'value': 'Teacher',
      'icon': Icons.person_rounded,
      'color': AppTheme.blue400
    },
    {
      'value': 'Parent',
      'icon': Icons.family_restroom_rounded,
      'color': AppTheme.blue400
    },
    {
      'value': 'Admin',
      'icon': Icons.admin_panel_settings_rounded,
      'color': AppTheme.blue400
    },
    {
      'value': 'Academic Officer',
      'icon': Icons.business_center_rounded,
      'color': AppTheme.blue400
    },
  ];

  // Responsive breakpoints
  bool get isSmallScreen =>
      MediaQuery
          .of(context)
          .size
          .width < 600;

  bool get isMediumScreen =>
      MediaQuery
          .of(context)
          .size
          .width >= 600 && MediaQuery
          .of(context)
          .size
          .width < 1024;

  bool get isLargeScreen =>
      MediaQuery
          .of(context)
          .size
          .width >= 1024;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _shakeAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _shakeController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBarCustom(),
      backgroundColor: Color(0xFFF8FAFC),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (isLargeScreen) {
                // Desktop layout - side by side
                return _buildDesktopLayout();
              } else {
                // Mobile/Tablet layout - stacked
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
            padding: EdgeInsets.all(48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 32),
                Text(
                  'Streamline your educational experience with our comprehensive school management system.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
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
            constraints: BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(32),
            child: Center(
              child: _buildLoginForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery
              .of(context)
              .size
              .height -
              MediaQuery
                  .of(context)
                  .padding
                  .top -
              kToolbarHeight,
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildLoginForm(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final logoSize = isSmallScreen ? 80.0 : isLargeScreen ? 120.0 : 100.0;
    final titleSize = isSmallScreen ? 28.0 : isLargeScreen ? 40.0 : 32.0;
    final subtitleSize = isSmallScreen ? 14.0 : isLargeScreen ? 18.0 : 16.0;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 20 : 40,
          horizontal: isSmallScreen ? 16 : 20,
        ),
        child: Column(
          crossAxisAlignment: isLargeScreen
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'login_logo',
              child: Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.school_rounded,
                  size: logoSize * 0.5,
                  color: AppTheme.blue600,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
              textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Sign in to continue your learning journey',
              style: TextStyle(
                fontSize: subtitleSize,
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
              textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    final formPadding = isSmallScreen ? 20.0 : isLargeScreen ? 40.0 : 32.0;
    final formMargin = isSmallScreen ? 16.0 : 20.0;

    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: formMargin),
              constraints: BoxConstraints(
                maxWidth: isLargeScreen ? 500 : double.infinity,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(formPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserTypeSelection(),
                      SizedBox(height: 24),
                      _buildInputField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline_rounded,
                        validator: (value) =>
                        value?.isEmpty ?? true
                            ? 'Please enter your full name'
                            : null,
                      ),
                      SizedBox(height: 20),
                      _buildPasswordField(),
                      SizedBox(height: 16),
                      _buildRememberMeRow(),
                      SizedBox(height: 32),
                      _buildLoginButton(),
                      SizedBox(height: 24),
                      _buildDivider(),
                      SizedBox(height: 24),
                      _buildQuickActions(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login As',
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: isSmallScreen ? 70 : 80,
          child: isSmallScreen
              ? _buildCompactUserTypeGrid()
              : _buildUserTypeList(),
        ),
        if (_userType == null)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Please select a user type',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserTypeList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _userTypes.length,
      itemBuilder: (context, index) {
        return _buildUserTypeItem(index);
      },
    );
  }

  Widget _buildCompactUserTypeGrid() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _userTypes
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key;
          return Padding(
            padding: EdgeInsets.only(
                right: index < _userTypes.length - 1 ? 8 : 0),
            child: _buildUserTypeItem(index, isCompact: true),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserTypeItem(int index, {bool isCompact = false}) {
    final userType = _userTypes[index];
    final isSelected = _userType == userType['value'];
    final itemWidth = isCompact ? 70.0 : (isSmallScreen ? 80.0 : 90.0);
    final iconSize = isCompact ? 16.0 : (isSmallScreen ? 20.0 : 24.0);
    final fontSize = isCompact ? 9.0 : (isSmallScreen ? 10.0 : 11.0);

    return GestureDetector(
      onTap: () {
        setState(() {
          _userType = userType['value'];
        });
        HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: isCompact ? 0 : 12),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        width: itemWidth,
        decoration: BoxDecoration(
          color: isSelected ? userType['color'] : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? userType['color'] : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: userType['color'].withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              userType['icon'],
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: iconSize,
            ),
            SizedBox(height: 4),
            Flexible(
              child: Text(
                _getShortUserType(userType['value']),
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortUserType(String userType) {
    switch (userType) {
      case 'Academic Officer':
        return isSmallScreen ? 'Academic\nOfficer' : 'Academic\nOfficer';
      case 'Student':
        return 'Student';
      case 'Teacher':
        return 'Teacher';
      case 'Parent':
        return 'Parent';
      case 'Admin':
        return 'Admin';
      default:
        return userType.split(' ')[0];
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: isSmallScreen ? 14 : 16,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF667eea).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF667eea), size: 20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFF667eea), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          filled: true,
          fillColor: Color(0xFFF9FAFB),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isSmallScreen ? 12 : 16,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: isSmallScreen ? 14 : 16,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF667eea).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
                Icons.lock_outline_rounded, color: Color(0xFF667eea), size: 20),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off_rounded : Icons
                  .visibility_rounded,
              color: Color(0xFF6B7280),
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFF667eea), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          filled: true,
          fillColor: Color(0xFFF9FAFB),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isSmallScreen ? 12 : 16,
          ),
        ),
        validator: (value) =>
        value?.isEmpty ?? true
            ? 'Please enter your password'
            : null,
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
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _rememberMe ? Color(0xFF667eea) : Colors.transparent,
                  border: Border.all(
                    color: _rememberMe ? Color(0xFF667eea) : Color(0xFFD1D5DB),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _rememberMe
                    ? Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
              SizedBox(width: 8),
              Text(
                'Remember me',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forget-password');
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Color(0xFF667eea),
              fontSize: isSmallScreen ? 12 : 14,
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
      height: isSmallScreen ? 48 : 56,
      decoration: BoxDecoration(
        color: Colors.blue.shade500,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
            ? SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        )
            : Text(
          'Sign In',
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFE5E7EB))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE5E7EB))),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      children: [
        isSmallScreen
            ? Column(
          children: [
            _buildQuickActionButton(
              'Change Password',
              Icons.lock_reset_rounded,
                  () => Navigator.pushNamed(context, '/change-password'),
            ),
            SizedBox(height: 12),
            _buildQuickActionButton(
              'New Admission',
              Icons.person_add_rounded,
                  () => Navigator.pushNamed(context, '/admission-main'),
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
            SizedBox(width: 12),
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

  Widget _buildQuickActionButton(String title, IconData icon,
      VoidCallback onTap) {
    return Container(
      height: isSmallScreen ? 44 : 48,
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: isSmallScreen ? 14 : 16,
                  color: Color(0xFF6B7280)),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 11 : 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '© 2024 School Management System',
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: isSmallScreen ? 10 : 12,
        ),
      ),
    );
  }

  void _login() async {
    if (!_formKey.currentState!.validate() || _userType == null) {
      if (_userType == null) {
        _showError('Please select a user type');
      }
      _shakeController.forward().then((_) => _shakeController.reverse());
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Navigation based on user type
    final routes = {
      'Admin': '/admin-dashboard',
      'Teacher': '/teacher-dashboard',
      'Student': '/student-dashboard',
      'Academic Officer': '/academic-officer-dashboard',
      'Parent': '/parent-dashboard',
    };

    final route = routes[_userType];
    if (route != null) {
      Navigator.pushReplacementNamed(context, route);
    } else {
      _showError('Unknown user type!');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 3),
      ),
    );
  }
}