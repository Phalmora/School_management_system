import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionStatusScreen extends StatefulWidget {
  @override
  _AdmissionStatusScreenState createState() => _AdmissionStatusScreenState();
}

class _AdmissionStatusScreenState extends State<AdmissionStatusScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _animationController;
  late AnimationController _headerAnimationController;
  late AnimationController _statusAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _headerFadeAnimation;
  late Animation<double> _statusFadeAnimation;

  // Form Controllers
  final _admissionNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();

  // Status Data
  bool _isSearching = false;
  bool _showStatus = false;
  AdmissionStatusData? _statusData;

  // Search Method
  String _searchMethod = 'admission'; // 'admission' or 'email'

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
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

    // Status animation controller
    _statusAnimationController = AnimationController(
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

    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeInOut,
    ));

    _statusFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _statusAnimationController,
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
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppTheme.getSmallSpacing(context)),
              Padding(
                padding: AppTheme.getHorizontalPadding(context),
                child: Text(
                  'Check Admission Status',
                  style: AppTheme.getFontStyle(context),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: AppTheme.getMaxWidth(context),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: AppTheme.getDashboardHorizontalPadding(context),
                        vertical: AppTheme.getDashboardVerticalPadding(context),
                      ),
                      child: Card(
                        elevation: AppTheme.getCardElevation(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.getCardBorderRadius(context),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            AppTheme.getExtraLargeSpacing(context),
                          ),
                          child: Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitle(),
                                  SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                                  _buildSearchMethodSelector(),
                                  SizedBox(height: AppTheme.getDefaultSpacing(context)),
                                  _buildSearchForm(),
                                  SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                                  _buildTrackButton(),
                                  if (_showStatus) ...[
                                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                                    _buildStatusSection(),
                                  ],
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
    );
  }

  Widget _buildTitle() {
    return TweenAnimationBuilder<double>(
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
                  'Track Your Application',
                  style: AppTheme.getSectionTitleStyle(context).copyWith(
                    color: AppTheme.blue800,
                  ),
                ),
                SizedBox(height: AppTheme.getSmallSpacing(context)),
                Text(
                  'Enter your admission number or email with date of birth to check your application status',
                  style: AppTheme.getSubHeadingStyle(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchMethodSelector() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600),
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
                  'Search Method',
                  style: AppTheme.getHeadingStyle(context).copyWith(
                    color: AppTheme.blue800,
                  ),
                ),
                SizedBox(height: AppTheme.getSmallSpacing(context)),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.blue50,
                    borderRadius: BorderRadius.circular(
                      AppTheme.getInputBorderRadius(context),
                    ),
                    border: Border.all(color: AppTheme.blue200),
                  ),
                  child: AppTheme.isSmallPhone(context)
                      ? Column(
                    children: [
                      _buildMethodOption(
                        'admission',
                        'Admission Number',
                        Icons.confirmation_number,
                        isFullWidth: true,
                      ),
                      Container(
                        height: 1,
                        color: AppTheme.blue200,
                      ),
                      _buildMethodOption(
                        'email',
                        'Email Address',
                        Icons.email,
                        isFullWidth: true,
                      ),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _buildMethodOption(
                          'admission',
                          'Admission Number',
                          Icons.confirmation_number,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: AppTheme.blue200,
                      ),
                      Expanded(
                        child: _buildMethodOption(
                          'email',
                          'Email Address',
                          Icons.email,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMethodOption(
      String method,
      String title,
      IconData icon, {
        bool isFullWidth = false,
      }) {
    bool isSelected = _searchMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchMethod = method;
          // Clear controllers when switching methods
          _admissionNumberController.clear();
          _emailController.clear();
          _dobController.clear();
          _showStatus = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppTheme.getDefaultSpacing(context),
          horizontal: AppTheme.getSmallSpacing(context),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppTheme.getInputBorderRadius(context),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppTheme.blue600,
              size: AppTheme.getIconSize(context) * 0.8,
            ),
            SizedBox(width: AppTheme.getSmallSpacing(context) / 2),
            Flexible(
              child: Text(
                title,
                style: AppTheme.getBodyTextStyle(context).copyWith(
                  color: isSelected ? Colors.white : AppTheme.blue800,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: AppTheme.isSmallPhone(context) ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (_searchMethod == 'admission') ...[
            _buildAnimatedTextFormField(
              controller: _admissionNumberController,
              label: 'Admission Number',
              icon: Icons.confirmation_number,
              validator: _validateAdmissionNumber,
              delay: 100,
            ),
          ] else ...[
            _buildAnimatedTextFormField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              delay: 100,
            ),
          ],
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          _buildAnimatedDateField(
            controller: _dobController,
            label: 'Date of Birth',
            icon: Icons.calendar_today,
            delay: 200,
          ),
        ],
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
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                labelText: label,
                labelStyle: AppTheme.getBodyTextStyle(context).copyWith(
                  color: Colors.grey[600],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.getInputBorderRadius(context),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.getInputBorderRadius(context),
                  ),
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
              style: AppTheme.getBodyTextStyle(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: AppTheme.blue600,
                  size: AppTheme.getIconSize(context),
                ),
                labelText: label,
                labelStyle: AppTheme.getBodyTextStyle(context).copyWith(
                  color: Colors.grey[600],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.getInputBorderRadius(context),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.getInputBorderRadius(context),
                  ),
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
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().subtract(Duration(days: 365 * 10)),
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
                  return 'Please select date of birth';
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrackButton() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: SizedBox(
              width: double.infinity,
              height: AppTheme.getButtonHeight(context),
              child: ElevatedButton(
                onPressed: _isSearching ? null : _handleTrackApplication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.getButtonBorderRadius(context),
                    ),
                  ),
                  elevation: AppTheme.getButtonElevation(context),
                ),
                child: _isSearching
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppTheme.getIconSize(context) * 0.8,
                      height: AppTheme.getIconSize(context) * 0.8,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: AppTheme.getSmallSpacing(context)),
                    Text(
                      'Searching...',
                      style: AppTheme.getButtonTextStyle(context),
                    ),
                  ],
                )
                    : Text(
                  'Track My Application',
                  style: AppTheme.getButtonTextStyle(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusSection() {
    return FadeTransition(
      opacity: _statusFadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Status',
            style: AppTheme.getSectionTitleStyle(context).copyWith(
              color: AppTheme.blue800,
            ),
          ),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          _buildStatusCard(),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    if (_statusData == null) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(AppTheme.getDefaultSpacing(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppTheme.getCardBorderRadius(context),
        ),
        border: Border.all(color: AppTheme.blue200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatusRow(
            'Admission Number',
            _statusData!.admissionNumber,
            Icons.confirmation_number,
          ),
          _buildDivider(),
          _buildStatusRow(
            'Student Name',
            _statusData!.studentName,
            Icons.person,
          ),
          _buildDivider(),
          _buildStatusRow(
            'Class Applied',
            _statusData!.classApplied,
            Icons.school,
          ),
          _buildDivider(),
          _buildStatusRowWithIcon(
            'Status',
            _statusData!.status,
            _getStatusIcon(_statusData!.status),
            _getStatusColor(_statusData!.status),
          ),
          _buildDivider(),
          _buildStatusRow(
            'Status Updated On',
            _statusData!.statusUpdatedOn,
            Icons.access_time,
          ),
          if (_statusData!.remarks.isNotEmpty) ...[
            _buildDivider(),
            _buildRemarksSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.getSmallSpacing(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(
              AppTheme.getSmallSpacing(context),
            ),
            decoration: BoxDecoration(
              color: AppTheme.blue50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppTheme.blue600,
              size: AppTheme.getIconSize(context) * 0.7,
            ),
          ),
          SizedBox(width: AppTheme.getDefaultSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.getCaptionTextStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: AppTheme.getBodyTextStyle(context).copyWith(
                    color: AppTheme.blue800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRowWithIcon(
      String label,
      String value,
      IconData statusIcon,
      Color statusColor,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.getSmallSpacing(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(
              AppTheme.getSmallSpacing(context),
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: AppTheme.getIconSize(context) * 0.7,
            ),
          ),
          SizedBox(width: AppTheme.getDefaultSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.getCaptionTextStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: AppTheme.getIconSize(context) * 0.7,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        value,
                        style: AppTheme.getBodyTextStyle(context).copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemarksSection() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.getSmallSpacing(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(
              AppTheme.getSmallSpacing(context),
            ),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.info_outline,
              color: Colors.orange,
              size: AppTheme.getIconSize(context) * 0.7,
            ),
          ),
          SizedBox(width: AppTheme.getDefaultSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remarks',
                  style: AppTheme.getCaptionTextStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.all(
                    AppTheme.getSmallSpacing(context),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.orange.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    _statusData!.remarks,
                    style: AppTheme.getBodyTextStyle(context).copyWith(
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppTheme.blue100,
      height: 1,
      thickness: 1,
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'accepted':
        return Icons.check_circle;
      case 'rejected':
      case 'declined':
        return Icons.cancel;
      case 'under review':
      case 'pending':
        return Icons.schedule;
      case 'document required':
        return Icons.upload_file;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'accepted':
        return Colors.green;
      case 'rejected':
      case 'declined':
        return Colors.red;
      case 'under review':
      case 'pending':
        return Colors.orange;
      case 'document required':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // Validation Methods
  String? _validateAdmissionNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter admission number';
    }
    if (value.trim().length < 5) {
      return 'Please enter a valid admission number';
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

  void _handleTrackApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSearching = true;
      _showStatus = false;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock data based on search criteria
    _statusData = AdmissionStatusData(
      admissionNumber: _searchMethod == 'admission'
          ? _admissionNumberController.text
          : 'ADM2025-0001',
      studentName: 'Aman Singh',
      classApplied: 'Class 6 – Section A',
      status: 'Under Review',
      statusUpdatedOn: 'June 4, 2025',
      remarks: 'Waiting for TC document upload',
    );

    setState(() {
      _isSearching = false;
      _showStatus = true;
    });

    // Start status animation
    _statusAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _headerAnimationController.dispose();
    _statusAnimationController.dispose();
    _admissionNumberController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// Data Model
class AdmissionStatusData {
  final String admissionNumber;
  final String studentName;
  final String classApplied;
  final String status;
  final String statusUpdatedOn;
  final String remarks;

  AdmissionStatusData({
    required this.admissionNumber,
    required this.studentName,
    required this.classApplied,
    required this.status,
    required this.statusUpdatedOn,
    required this.remarks,
  });
}