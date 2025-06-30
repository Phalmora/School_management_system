import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

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
      duration: AppThemeColor.slideAnimationDuration,
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
          gradient: AppThemeColor.primaryGradient,
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
                      padding: AppThemeResponsiveness.getScreenPadding(context),
                      child: Column(
                        children: [
                          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                          _buildHeader(context),
                          SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                          _buildMainCard(context),
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_reset,
            size: AppThemeResponsiveness.getHeaderIconSize(context) * 1.5,
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
        Text(
          'Forgot Password?',
          style: AppThemeResponsiveness.getFontStyle(context),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Text(
          'Don\'t worry! We\'ll help you reset it',
          style: AppThemeResponsiveness.getSplashSubtitleStyle(context),
        ),
      ],
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Container(
      width: AppThemeResponsiveness.getMaxWidth(context),
      child: Card(
        elevation: AppThemeResponsiveness.getCardElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        child: Padding(
          padding: AppThemeResponsiveness.getCardPadding(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_isOtpSent) ...[
                  _buildMethodSelector(context),
                  SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                  _buildInputForm(context),
                  SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                  _buildSendButton(context),
                ] else ...[
                  _buildOtpVerificationSection(context),
                ],
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                _buildHelpSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Recovery Method',
          style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
            color: AppThemeColor.blue600,
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        Row(
          children: [
            Expanded(
              child: _buildMethodCard(
                context,
                title: 'Email',
                subtitle: 'Send reset link via email',
                icon: Icons.email,
                isSelected: _isEmailMethod,
                onTap: () => setState(() => _isEmailMethod = true),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
            Expanded(
              child: _buildMethodCard(
                context,
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

  Widget _buildMethodCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppThemeColor.buttonAnimationDuration,
        padding: AppThemeResponsiveness.getCardPadding(context) * 0.8,
        decoration: BoxDecoration(
          color: isSelected ? AppThemeColor.blue600.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          border: Border.all(
            color: isSelected ? AppThemeColor.blue600 : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: AppThemeResponsiveness.getIconSize(context),
              color: isSelected ? AppThemeColor.blue600 : Colors.grey[600],
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              title,
              style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppThemeColor.blue600 : Colors.grey[700],
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: AppThemeResponsiveness.getCaptionTextStyle(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isEmailMethod ? 'Email Address' : 'Phone Number',
          style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppThemeColor.blue600,
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        TextFormField(
          controller: _isEmailMethod ? _emailController : _phoneController,
          keyboardType: _isEmailMethod ? TextInputType.emailAddress : TextInputType.phone,
          style: AppThemeResponsiveness.getBodyTextStyle(context),
          decoration: InputDecoration(
            hintText: _isEmailMethod
                ? 'Enter your registered email'
                : 'Enter your registered phone number',
            hintStyle: AppThemeResponsiveness.getCaptionTextStyle(context),
            prefixIcon: Icon(
              _isEmailMethod ? Icons.email_outlined : Icons.phone_outlined,
              color: AppThemeColor.blue600,
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: AppThemeColor.blue600,
                width: AppThemeResponsiveness.getFocusedBorderWidth(context),
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
              vertical: AppThemeResponsiveness.getMediumSpacing(context),
            ),
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
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.blue[600],
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Expanded(
                child: Text(
                  _isEmailMethod
                      ? 'We\'ll send a password reset link to your email'
                      : 'We\'ll send a 6-digit OTP to your phone',
                  style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
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

  Widget _buildSendButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppThemeResponsiveness.getButtonHeight(context),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _sendResetRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppThemeColor.blue600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
          elevation: AppThemeResponsiveness.getButtonElevation(context),
        ),
        child: _isLoading
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: AppThemeResponsiveness.getIconSize(context) * 0.8,
              height: AppThemeResponsiveness.getIconSize(context) * 0.8,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Sending...',
              style: AppThemeResponsiveness.getButtonTextStyle(context),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isEmailMethod ? Icons.send : Icons.sms,
              color: Colors.white,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              _isEmailMethod ? 'Send Reset Link' : 'Send OTP',
              style: AppThemeResponsiveness.getButtonTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpVerificationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green[600],
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              _isEmailMethod ? 'Email Sent!' : 'OTP Sent!',
              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                color: Colors.green[600],
              ),
            ),
          ],
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Container(
          padding: AppThemeResponsiveness.getCardPadding(context),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEmailMethod ? 'Check Your Email' : 'Enter the OTP',
                style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                _isEmailMethod
                    ? 'We\'ve sent a password reset link to ${_emailController.text}. Click the link in the email to reset your password.'
                    : 'We\'ve sent a 6-digit OTP to ${_phoneController.text}. Enter the OTP below to proceed.',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  color: Colors.green[700],
                  height: 1.4,
                ),
              ),
              if (!_isEmailMethod) ...[
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                    fontSize: AppThemeResponsiveness.isMobile(context) ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                  decoration: InputDecoration(
                    hintText: '000000',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                      borderSide: BorderSide(color: Colors.green[600]!, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                Container(
                  width: double.infinity,
                  height: AppThemeResponsiveness.getButtonHeight(context),
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                      ),
                      elevation: AppThemeResponsiveness.getButtonElevation(context),
                    ),
                    child: Text(
                      'Verify OTP',
                      style: AppThemeResponsiveness.getButtonTextStyle(context),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
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
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  color: AppThemeColor.blue600,
                ),
              ),
            ),
            TextButton(
              onPressed: _resendCode,
              child: Text(
                'Resend Code',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  color: AppThemeColor.blue600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHelpSection(BuildContext context) {
    return Container(
      padding: AppThemeResponsiveness.getCardPadding(context),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.grey[600],
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Need Help?',
                style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Text(
            'If you\'re having trouble resetting your password, please contact our support team.',
            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
              color: Colors.grey[600],
              height: 1.3,
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          AppThemeResponsiveness.isSmallPhone(context)
              ? Column(
            children: [
              _buildSupportButton(
                context,
                icon: Icons.phone,
                label: 'Call Support',
                onPressed: _contactSupport,
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              _buildSupportButton(
                context,
                icon: Icons.email,
                label: 'Email Us',
                onPressed: _emailSupport,
              ),
            ],
          )
              : Row(
            children: [
              Expanded(
                child: _buildSupportButton(
                  context,
                  icon: Icons.phone,
                  label: 'Call Support',
                  onPressed: _contactSupport,
                ),
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Expanded(
                child: _buildSupportButton(
                  context,
                  icon: Icons.email,
                  label: 'Email Us',
                  onPressed: _emailSupport,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSupportButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onPressed,
      }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: AppThemeResponsiveness.getIconSize(context) * 0.7),
      label: Text(
        label,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppThemeColor.blue600,
        side: BorderSide(color: AppThemeColor.blue600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: AppThemeResponsiveness.getSmallSpacing(context),
          horizontal: AppThemeResponsiveness.getMediumSpacing(context),
        ),
      ),
    );
  }

  void _sendResetRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

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
            Text(_isEmailMethod ? 'Reset link sent again!' : 'OTP sent again!'),
          ],
        ),
        backgroundColor: AppThemeColor.blue600,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _contactSupport() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+1-800-SCHOOL');
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open phone dialer'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _emailSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@school.edu',
      queryParameters: {
        'subject': 'Password Reset Support Request',
        'body': 'Hello Support Team,\n\nI need help with resetting my password. Please assist me.\n\nThank you,',
      },
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open email app'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}