import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

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
    _initAnimations();
  }

  void _initAnimations() {
    _shakeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

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
        decoration: BoxDecoration(gradient: AppThemeColor.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: AppThemeResponsiveness.getMaxWidth(context)),
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildScrollableContent(),
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

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
          vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
        ),
        child: Text(
          'Change Password',
          style: AppThemeResponsiveness.getSectionTitleStyle(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
        ),
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
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: AppThemeResponsiveness.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardPadding(context)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildSecurityIcon(),
              SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context)),
              _buildTitleSection(),
              SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context) * 2),
              _buildPasswordFields(),
              SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context) * 2),
              _buildChangePasswordButton(),
              SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context)),
              _buildSecurityTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityIcon() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
            decoration: BoxDecoration(
              color: AppThemeColor.blue600,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppThemeColor.primaryBlue.withOpacity(0.3),
                  blurRadius: AppThemeResponsiveness.isSmallPhone(context) ? 15 : 20,
                  spreadRadius: AppThemeResponsiveness.isSmallPhone(context) ? 3 : 5,
                ),
              ],
            ),
            child: Icon(
              Icons.security_rounded,
              size: AppThemeResponsiveness.getDashboardCardIconSize(context),
              color: AppThemeColor.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          'Secure Your Account',
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
            fontSize: AppThemeResponsiveness.getWelcomeNameTextStyle(context).fontSize,
            color: AppThemeColor.blue800,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Text(
          'Update your password to keep your account safe',
          style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).copyWith(
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        _buildPasswordField(
          controller: _currentPasswordController,
          label: 'Current Password',
          icon: Icons.lock_outline_rounded,
          isVisible: _isCurrentPasswordVisible,
          onToggleVisibility: () => setState(() => _isCurrentPasswordVisible = !_isCurrentPasswordVisible),
          validator: (value) => value!.isEmpty ? 'Please enter current password' : null,
          delay: 200,
        ),
        SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context)),
        _buildPasswordField(
          controller: _newPasswordController,
          label: 'New Password',
          icon: Icons.lock_rounded,
          isVisible: _isNewPasswordVisible,
          onToggleVisibility: () => setState(() => _isNewPasswordVisible = !_isNewPasswordVisible),
          validator: _validateNewPassword,
          delay: 400,
        ),
        SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context)),
        _buildPasswordField(
          controller: _confirmPasswordController,
          label: 'Confirm New Password',
          icon: Icons.lock_clock_rounded,
          isVisible: _isConfirmPasswordVisible,
          onToggleVisibility: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
          validator: _validateConfirmPassword,
          delay: 600,
        ),
      ],
    );
  }

  Widget _buildPasswordField({
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
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: AppThemeResponsiveness.isSmallPhone(context) ? 8 : 10,
                    spreadRadius: 1,
                    offset: Offset(0, AppThemeResponsiveness.isSmallPhone(context) ? 2 : 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                obscureText: !isVisible,
                style: AppThemeResponsiveness.getBodyTextStyle(context),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: AppThemeResponsiveness.getSubHeadingStyle(context),
                  prefixIcon: _buildPrefixIcon(icon),
                  suffixIcon: _buildSuffixIcon(isVisible, onToggleVisibility),
                  border: _buildInputBorder(AppThemeColor.greyl),
                  enabledBorder: _buildInputBorder(AppThemeColor.greyl),
                  focusedBorder: _buildInputBorder(AppThemeColor.primaryBlue),
                  errorBorder: _buildInputBorder(Colors.red.shade400),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getQuickStatsPadding(context),
                    vertical: AppThemeResponsiveness.getQuickStatsSpacing(context),
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

  Widget _buildPrefixIcon(IconData icon) {
    return Container(
      margin: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context)),
      padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context) * 0.7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppThemeColor.primaryBlue.withOpacity(0.1),
            AppThemeColor.primaryIndigo.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getQuickStatsIconPadding(context) * 0.8),
      ),
      child: Icon(
        icon,
        color: AppThemeColor.primaryBlue,
        size: AppThemeResponsiveness.getQuickStatsIconSize(context),
      ),
    );
  }

  Widget _buildSuffixIcon(bool isVisible, VoidCallback onToggle) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        color: AppThemeColor.blue600,
        size: AppThemeResponsiveness.getQuickStatsIconSize(context),
      ),
      onPressed: onToggle,
    );
  }

  OutlineInputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
      borderSide: BorderSide(
        color: color,
        width: color == AppThemeColor.primaryBlue ? AppThemeResponsiveness.getFocusedBorderWidth(context) : 1.0,
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: double.infinity,
              height: AppThemeResponsiveness.getButtonHeight(context),
              decoration: BoxDecoration(
                color: AppThemeColor.blue600,
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                boxShadow: [
                  BoxShadow(
                    color: AppThemeColor.primaryBlue.withOpacity(0.3),
                    blurRadius: AppThemeResponsiveness.isSmallPhone(context) ? 10 : 15,
                    spreadRadius: AppThemeResponsiveness.isSmallPhone(context) ? 1 : 2,
                    offset: Offset(0, AppThemeResponsiveness.isSmallPhone(context) ? 4 : 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                  height: AppThemeResponsiveness.getQuickStatsIconSize(context),
                  width: AppThemeResponsiveness.getQuickStatsIconSize(context),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.white),
                    strokeWidth: AppThemeResponsiveness.isSmallPhone(context) ? 2.0 : 3.0,
                  ),
                )
                    : Text(
                  'Change Password',
                  style: AppThemeResponsiveness.getButtonTextStyle(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecurityTips() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsPadding(context)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppThemeColor.primaryBlue.withOpacity(0.05),
                  AppThemeColor.primaryIndigo.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              border: Border.all(color: AppThemeColor.primaryBlue.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.tips_and_updates_rounded,
                      color: AppThemeColor.primaryBlue,
                      size: AppThemeResponsiveness.getQuickStatsIconSize(context),
                    ),
                    SizedBox(width: AppThemeResponsiveness.getQuickStatsIconPadding(context)),
                    Text(
                      'Security Tips',
                      style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppThemeColor.blue800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppThemeResponsiveness.getQuickStatsIconPadding(context)),
                ...['Use at least 8 characters', 'Include uppercase and lowercase letters',
                  'Add numbers and special characters', 'Avoid common words or personal info']
                    .map((tip) => _buildTipItem(tip)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppThemeResponsiveness.getQuickStatsIconPadding(context) * 0.5),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getQuickStatsIconSize(context) * 0.7,
          ),
          SizedBox(width: AppThemeResponsiveness.getQuickStatsIconPadding(context)),
          Expanded(
            child: Text(
              text,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: AppThemeColor.blue600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateNewPassword(String? value) {
    if (value!.isEmpty) return 'Please enter new password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value!.isEmpty) return 'Please confirm new password';
    if (value != _newPasswordController.text) return 'Passwords do not match';
    return null;
  }

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      _scaleController.forward().then((_) => _scaleController.reverse());
      setState(() => _isLoading = true);
      await Future.delayed(Duration(seconds: 2));
      setState(() => _isLoading = false);
      _showSuccessDialog();
    } else {
      _shakeController.forward().then((_) => _shakeController.reverse());
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: AppThemeResponsiveness.getDialogWidth(context)),
            padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardPadding(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
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
                  padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: AppThemeResponsiveness.isSmallPhone(context) ? 15 : 20,
                        spreadRadius: AppThemeResponsiveness.isSmallPhone(context) ? 3 : 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: AppThemeResponsiveness.getDashboardCardIconSize(context),
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context)),
                Text(
                  'Password Changed!',
                  style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                    fontSize: AppThemeResponsiveness.getWelcomeBackTextStyle(context).fontSize! * 1.4,
                    fontWeight: FontWeight.bold,
                    color: AppThemeColor.blue800,
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getQuickStatsIconPadding(context)),
                Text(
                  'Your password has been successfully updated. Your account is now more secure.',
                  textAlign: TextAlign.center,
                  style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).copyWith(height: 1.5),
                ),
                SizedBox(height: AppThemeResponsiveness.getQuickStatsSpacing(context)),
                Container(
                  width: double.infinity,
                  height: AppThemeResponsiveness.getButtonHeight(context),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.green, Colors.green.shade600]),
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
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
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                      ),
                    ),
                    child: Text('Continue', style: AppThemeResponsiveness.getButtonTextStyle(context)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}