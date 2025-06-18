import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/SignUp/academicOfficerSignUp.dart';
import 'package:school/SignUp/adminSignUp.dart';
import 'package:school/SignUp/parentSignUp.dart';
import 'package:school/SignUp/studentSignUp.dart';
import 'package:school/SignUp/teacherSignUp.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class MainSignUpPage extends StatefulWidget {
  @override
  _MainSignUpPageState createState() => _MainSignUpPageState();
}

class _MainSignUpPageState extends State<MainSignUpPage> with TickerProviderStateMixin {
  String? selectedRole;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _userTypes = [
    {
      'value': 'Student',
      'icon': Icons.school_rounded,
      'color': AppTheme.blue400,
      'description': 'Access courses, assignments, and grades'
    },
    {
      'value': 'Teacher',
      'icon': Icons.person_rounded,
      'color': AppTheme.blue400,
      'description': 'Manage classes, students, and curriculum'
    },
    {
      'value': 'Parent',
      'icon': Icons.family_restroom_rounded,
      'color': AppTheme.blue400,
      'description': 'Monitor your child\'s academic progress'
    },
    {
      'value': 'Admin',
      'icon': Icons.admin_panel_settings_rounded,
      'color': AppTheme.blue400,
      'description': 'System administration and management'
    },
    {
      'value': 'Academic Officer',
      'icon': Icons.business_center_rounded,
      'color': AppTheme.blue400,
      'description': 'Academic operations and oversight'
    },
  ];

  // Responsive breakpoints
  bool get isSmallScreen => MediaQuery.of(context).size.width < 600;
  bool get isMediumScreen => MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1024;
  bool get isLargeScreen => MediaQuery.of(context).size.width >= 1024;

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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (isLargeScreen) {
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
            padding: EdgeInsets.all(48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(isDesktop: true),
              ],
            ),
          ),
        ),
        // Right side - SignUp form
        Expanded(
          flex: 1,
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(32),
            child: Center(
              child: _buildSignUpCard(),
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
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight,
        ),
        child: Column(
          children: [
            _buildWelcomeSection(isDesktop: false),
            _buildSignUpCard(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection({required bool isDesktop}) {
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
              tag: 'signup_logo',
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
                  Icons.person_add_rounded,
                  size: logoSize * 0.5,
                  color: AppTheme.blue600,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Join Us Today!',
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
              'Create your account and start your educational journey',
              style: TextStyle(
                fontSize: subtitleSize,
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
              textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
            ),
            if (isLargeScreen) ...[
              SizedBox(height: 24),
              Text(
                'Join our comprehensive school management system and streamline your educational experience.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpCard() {
    final formPadding = isSmallScreen ? 20.0 : isLargeScreen ? 40.0 : 32.0;
    final formMargin = isSmallScreen ? 16.0 : 20.0;

    return SlideTransition(
      position: _slideAnimation,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Role',
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : isLargeScreen ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please select your role to continue with registration',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32),
              _buildUserTypeSelection(),
              SizedBox(height: 32),
              _buildContinueButton(),
              SizedBox(height: 24),
              _buildDivider(),
              SizedBox(height: 16),
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Role',
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 16),
        if (isSmallScreen)
          _buildMobileUserTypeGrid()
        else
          _buildDesktopUserTypeGrid(),
        if (selectedRole == null)
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'Please select a user type to continue',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMobileUserTypeGrid() {
    return Column(
      children: [
        // First row with 2 items
        Row(
          children: [
            Expanded(child: _buildUserTypeCard(0)),
            SizedBox(width: 12),
            Expanded(child: _buildUserTypeCard(1)),
          ],
        ),
        SizedBox(height: 12),
        // Second row with 2 items
        Row(
          children: [
            Expanded(child: _buildUserTypeCard(2)),
            SizedBox(width: 12),
            Expanded(child: _buildUserTypeCard(3)),
          ],
        ),
        SizedBox(height: 12),
        // Third row with 1 centered item
        Row(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(flex: 2, child: _buildUserTypeCard(4)),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopUserTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 3 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isLargeScreen ? 1.2 : 1.1,
      ),
      itemCount: _userTypes.length,
      itemBuilder: (context, index) => _buildUserTypeCard(index),
    );
  }

  Widget _buildUserTypeCard(int index) {
    final userType = _userTypes[index];
    final isSelected = selectedRole == userType['value'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = userType['value'];
        });
        HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? userType['color'].withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? userType['color'] : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: userType['color'].withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                decoration: BoxDecoration(
                  color: isSelected ? userType['color'] : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  userType['icon'],
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  size: isSmallScreen ? 20 : 24,
                ),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              Text(
                userType['value'],
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? userType['color'] : Color(0xFF374151),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (!isSmallScreen) ...[
                SizedBox(height: 4),
                Text(
                  userType['description'],
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: isSmallScreen ? 48 : 56,
      decoration: BoxDecoration(
        gradient: selectedRole != null
            ? LinearGradient(
          colors: [AppTheme.blue400, AppTheme.blue600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: selectedRole == null ? Colors.grey.shade300 : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: selectedRole != null ? [
          BoxShadow(
            color: AppTheme.blue400.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ] : null,
      ),
      child: ElevatedButton(
        onPressed: selectedRole != null ? _navigateToSelectedRole : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Continue to Sign Up',
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: selectedRole != null ? Colors.white : Colors.grey.shade600,
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

  Widget _buildLoginLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: isSmallScreen ? 14 : 16,
            ),
            children: [
              TextSpan(
                text: 'Login here',
                style: TextStyle(
                  color: AppTheme.blue600,
                  fontWeight: FontWeight.w600,
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

  void _navigateToSelectedRole() {
    if (selectedRole == null) return;

    Widget destinationPage;

    switch (selectedRole) {
      case 'Student':
        destinationPage = StudentSignupPage();
        break;
      case 'Teacher':
        destinationPage = TeacherSignupPage();
        break;
      case 'Academic Officer':
        destinationPage = AcademicOfficerSignupPage();
        break;
      case 'Admin':
        destinationPage = AdminSignupPage();
        break;
      case 'Parent':
        destinationPage = ParentSignUpPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationPage),
    );
  }
}