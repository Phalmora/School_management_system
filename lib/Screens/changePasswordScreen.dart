import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _shakeController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _shakeAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Shake animation for validation errors
    _shakeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // Fade animation for form appearance
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Scale animation for button press
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Slide animation for card entrance
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();
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
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              child: Column(
                children: [
                  // Header Section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: AppTheme.getScreenPadding(context),
                      child: Text(
                        'Change Password',
                        style: AppTheme.getFontStyle(context).copyWith(
                          fontSize: AppTheme.isMobile(context) ? 24 : (AppTheme.isTablet(context) ? 28 : 32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // Form Content
                  Expanded(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: AppTheme.getScreenPadding(context),
                            child: AnimatedBuilder(
                              animation: _shakeAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(_shakeAnimation.value, 0),
                                  child: _buildFormCard(),
                                );
                              },
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

  Widget _buildFormCard() {
    return Card(
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
                children: [
                  // Security Icon with responsive sizing
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 600),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: EdgeInsets.all(AppTheme.getDefaultSpacing(context)),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                                blurRadius: AppTheme.isMobile(context) ? 15 : 20,
                                spreadRadius: AppTheme.isMobile(context) ? 3 : 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.security_rounded,
                            size: AppTheme.getIconSize(context) * 1.5,
                            color: AppTheme.white,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppTheme.getMediumSpacing(context)),

                  // Title Section
                  Text(
                    'Secure Your Account',
                    style: AppTheme.getHeadingStyle(context).copyWith(
                      fontSize: AppTheme.isMobile(context) ? 24 : (AppTheme.isTablet(context) ? 28 : 32),
                      color: AppTheme.blue800,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: AppTheme.getSmallSpacing(context)),

                  Text(
                    'Update your password to keep your account safe',
                    style: AppTheme.getSubHeadingStyle(context).copyWith(
                      fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 16 : 18),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                  // Password Fields with staggered animations
                  _buildAnimatedPasswordField(
                    controller: _currentPasswordController,
                    label: 'Current Password',
                    icon: Icons.lock_outline_rounded,
                    isVisible: _isCurrentPasswordVisible,
                    onToggleVisibility: () => setState(() => _isCurrentPasswordVisible = !_isCurrentPasswordVisible),
                    validator: (value) => value!.isEmpty ? 'Please enter current password' : null,
                    delay: 200,
                  ),

                  SizedBox(height: AppTheme.getMediumSpacing(context)),

                  _buildAnimatedPasswordField(
                    controller: _newPasswordController,
                    label: 'New Password',
                    icon: Icons.lock_rounded,
                    isVisible: _isNewPasswordVisible,
                    onToggleVisibility: () => setState(() => _isNewPasswordVisible = !_isNewPasswordVisible),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter new password';
                      if (value.length < 8) return 'Password must be at least 8 characters';
                      if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                        return 'Password must contain uppercase, lowercase, and number';
                      }
                      return null;
                    },
                    delay: 400,
                  ),

                  SizedBox(height: AppTheme.getMediumSpacing(context)),

                  _buildAnimatedPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm New Password',
                    icon: Icons.lock_clock_rounded,
                    isVisible: _isConfirmPasswordVisible,
                    onToggleVisibility: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please confirm new password';
                      if (value != _newPasswordController.text) return 'Passwords do not match';
                      return null;
                    },
                    delay: 600,
                  ),

                  SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                  // Change Password Button with responsive design
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: double.infinity,
                            height: AppTheme.getButtonHeight(context),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryBlue.withOpacity(0.3),
                                  blurRadius: AppTheme.isMobile(context) ? 10 : 15,
                                  spreadRadius: AppTheme.isMobile(context) ? 1 : 2,
                                  offset: Offset(0, AppTheme.isMobile(context) ? 4 : 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _changePassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                                ),
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                height: AppTheme.getIconSize(context),
                                width: AppTheme.getIconSize(context),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
                                  strokeWidth: AppTheme.isMobile(context) ? 2.0 : 3.0,
                                ),
                              )
                                  : Text(
                                'Change Password',
                                style: AppTheme.getButtonTextStyle(context),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppTheme.getMediumSpacing(context)),

                  // Security Tips with responsive design
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: _buildSecurityTips(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedPasswordField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: AppTheme.isMobile(context) ? 8 : 10,
                    spreadRadius: 1,
                    offset: Offset(0, AppTheme.isMobile(context) ? 2 : 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                obscureText: !isVisible,
                style: AppTheme.getBodyTextStyle(context),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: AppTheme.getSubHeadingStyle(context),
                  prefixIcon: Container(
                    margin: EdgeInsets.all(AppTheme.getSmallSpacing(context)),
                    padding: EdgeInsets.all(AppTheme.getSmallSpacing(context) * 0.7),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryBlue.withOpacity(0.1),
                          AppTheme.primaryPurple.withOpacity(0.1)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.getSmallSpacing(context) * 0.8),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.primaryBlue,
                      size: AppTheme.getIconSize(context) * 0.8,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: AppTheme.blue600,
                      size: AppTheme.getIconSize(context),
                    ),
                    onPressed: onToggleVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    borderSide: BorderSide(color: AppTheme.greylight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    borderSide: BorderSide(color: AppTheme.greylight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    borderSide: BorderSide(
                      color: AppTheme.primaryBlue,
                      width: AppTheme.getFocusedBorderWidth(context),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    borderSide: BorderSide(color: Colors.red.shade400),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTheme.getDefaultSpacing(context),
                    vertical: AppTheme.getMediumSpacing(context),
                  ),
                ),
                validator: validator,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecurityTips() {
    return Container(
      padding: AppTheme.getCardPadding(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryBlue.withOpacity(0.05),
            AppTheme.primaryPurple.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tips_and_updates_rounded,
                color: AppTheme.primaryBlue,
                size: AppTheme.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppTheme.getSmallSpacing(context)),
              Text(
                'Security Tips',
                style: AppTheme.getSubHeadingStyle(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.blue800,
                  fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 16 : 18),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.getSmallSpacing(context)),
          _buildTipItem('Use at least 8 characters'),
          _buildTipItem('Include uppercase and lowercase letters'),
          _buildTipItem('Add numbers and special characters'),
          _buildTipItem('Avoid common words or personal info'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.getSmallSpacing(context) * 0.5),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppTheme.primaryBlue,
            size: AppTheme.getIconSize(context) * 0.6,
          ),
          SizedBox(width: AppTheme.getSmallSpacing(context)),
          Expanded(
            child: Text(
              text,
              style: AppTheme.getBodyTextStyle(context).copyWith(
                color: AppTheme.blue600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      // Scale animation for button press
      _scaleController.forward().then((_) {
        _scaleController.reverse();
      });

      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Show success dialog with responsive design
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getDialogWidth(context),
              ),
              padding: AppTheme.getCardPadding(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.green.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppTheme.getDefaultSpacing(context)),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: AppTheme.isMobile(context) ? 15 : 20,
                          spreadRadius: AppTheme.isMobile(context) ? 3 : 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: AppTheme.getIconSize(context) * 1.2,
                    ),
                  ),
                  SizedBox(height: AppTheme.getMediumSpacing(context)),
                  Text(
                    'Password Changed!',
                    style: AppTheme.getHeadingStyle(context).copyWith(
                      fontSize: AppTheme.isMobile(context) ? 20 : (AppTheme.isTablet(context) ? 24 : 28),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blue800,
                    ),
                  ),
                  SizedBox(height: AppTheme.getSmallSpacing(context)),
                  Text(
                    'Your password has been successfully updated. Your account is now more secure.',
                    textAlign: TextAlign.center,
                    style: AppTheme.getSubHeadingStyle(context).copyWith(
                      fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 16 : 18),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: AppTheme.getMediumSpacing(context)),
                  Container(
                    width: double.infinity,
                    height: AppTheme.getButtonHeight(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green.shade600],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: AppTheme.getButtonTextStyle(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // Trigger shake animation for validation errors
      _shakeController.forward().then((_) {
        _shakeController.reverse();
      });
    }
  }
}