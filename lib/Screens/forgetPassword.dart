import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;
  bool _isEmailMethod = true;
  bool _isOtpSent = false;
  bool _isEmailVerified = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.defaultSpacing),
                      child: Column(
                        children: [
                          SizedBox(height: AppTheme.defaultSpacing),
                          _buildHeader(),
                          SizedBox(height: AppTheme.extraLargeSpacing),
                          _buildMainCard(),
                          SizedBox(height: AppTheme.defaultSpacing),
                          _buildBackToLoginButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_reset,
            size: 48,
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppTheme.defaultSpacing),
        Text(
          'Forgot Password?',
          style: AppTheme.FontStyle.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Don\'t worry! We\'ll help you reset it',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildMainCard() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultSpacing),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isOtpSent) ...[
                _buildMethodSelector(),
                SizedBox(height: AppTheme.extraLargeSpacing),
                _buildInputForm(),
                SizedBox(height: AppTheme.extraLargeSpacing),
                _buildSendButton(),
              ] else ...[
                _buildOtpVerificationSection(),
              ],
              SizedBox(height: AppTheme.defaultSpacing),
              _buildHelpSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Recovery Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.blue600,
          ),
        ),
        SizedBox(height: AppTheme.mediumSpacing),
        Row(
          children: [
            Expanded(
              child: _buildMethodCard(
                title: 'Email',
                subtitle: 'Send reset link via email',
                icon: Icons.email,
                isSelected: _isEmailMethod,
                onTap: () => setState(() => _isEmailMethod = true),
              ),
            ),
            SizedBox(width: AppTheme.mediumSpacing),
            Expanded(
              child: _buildMethodCard(
                title: 'SMS',
                subtitle: 'Send OTP via SMS',
                icon: Icons.sms,
                isSelected: !_isEmailMethod,
                onTap: () => setState(() => _isEmailMethod = false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMethodCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.blue600.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.blue600 : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? AppTheme.blue600 : Colors.grey[600],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppTheme.blue600 : Colors.grey[700],
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isEmailMethod ? 'Email Address' : 'Phone Number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.blue600,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          controller: _isEmailMethod ? _emailController : _phoneController,
          keyboardType: _isEmailMethod ? TextInputType.emailAddress : TextInputType.phone,
          decoration: InputDecoration(
            hintText: _isEmailMethod
                ? 'Enter your registered email'
                : 'Enter your registered phone number',
            prefixIcon: Icon(
              _isEmailMethod ? Icons.email_outlined : Icons.phone_outlined,
              color: AppTheme.blue600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppTheme.blue600, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return _isEmailMethod
                  ? 'Please enter your email address'
                  : 'Please enter your phone number';
            }
            if (_isEmailMethod && !value.contains('@')) {
              return 'Please enter a valid email address';
            }
            if (!_isEmailMethod && value.length < 10) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue[600], size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isEmailMethod
                      ? 'We\'ll send a password reset link to your email'
                      : 'We\'ll send a 6-digit OTP to your phone',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return Container(
      width: double.infinity,
      height: AppTheme.buttonHeight,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _sendResetRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.blue600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
        child: _isLoading
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Sending...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isEmailMethod ? Icons.send : Icons.sms,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              _isEmailMethod ? 'Send Reset Link' : 'Send OTP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpVerificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green[600],
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              _isEmailMethod ? 'Email Sent!' : 'OTP Sent!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEmailMethod
                    ? 'Check Your Email'
                    : 'Enter the OTP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                _isEmailMethod
                    ? 'We\'ve sent a password reset link to ${_emailController.text}. Click the link in the email to reset your password.'
                    : 'We\'ve sent a 6-digit OTP to ${_phoneController.text}. Enter the OTP below to proceed.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[700],
                  height: 1.4,
                ),
              ),
              if (!_isEmailMethod) ...[
                SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                  decoration: InputDecoration(
                    hintText: '000000',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[600]!, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: AppTheme.defaultSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => setState(() {
                _isOtpSent = false;
                _emailController.clear();
                _phoneController.clear();
              }),
              child: Text(
                'Try Different Method',
                style: TextStyle(color: AppTheme.blue600),
              ),
            ),
            TextButton(
              onPressed: _resendCode,
              child: Text(
                'Resend Code',
                style: TextStyle(color: AppTheme.blue600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: Colors.grey[600], size: 20),
              SizedBox(width: 8),
              Text(
                'Need Help?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'If you\'re having trouble resetting your password, please contact our support team.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.3,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _contactSupport,
                  icon: Icon(Icons.phone, size: 16),
                  label: Text('Call Support'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.blue600,
                    side: BorderSide(color: AppTheme.blue600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _emailSupport,
                  icon: Icon(Icons.email, size: 16),
                  label: Text('Email Us'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.blue600,
                    side: BorderSide(color: AppTheme.blue600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackToLoginButton() {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back, color: Colors.white),
      label: Text(
        'Back to Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  void _sendResetRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _isOtpSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(_isEmailMethod
                  ? 'Reset link sent to your email!'
                  : 'OTP sent to your phone!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _verifyOtp() {
    // Simulate OTP verification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('OTP verified successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    // Navigate to reset password screen
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/reset-password');
    });
  }

  void _resendCode() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.refresh, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(_isEmailMethod
                ? 'Reset link sent again!'
                : 'OTP sent again!'),
          ],
        ),
        backgroundColor: AppTheme.blue600,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _contactSupport() {
    // Implement phone call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling support: +1-800-SCHOOL'),
        backgroundColor: AppTheme.blue600,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _emailSupport() {
    // Implement email functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening email: support@school.edu'),
        backgroundColor: AppTheme.blue600,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}