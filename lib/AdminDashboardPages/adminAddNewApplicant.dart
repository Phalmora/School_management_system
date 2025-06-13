import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AddNewApplicantScreen extends StatefulWidget {
  @override
  _AddNewApplicantScreenState createState() => _AddNewApplicantScreenState();
}

class _AddNewApplicantScreenState extends State<AddNewApplicantScreen>
    with TickerProviderStateMixin {

  // Animation Controllers
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Form Controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  // Form Data
  DateTime _selectedDateOfBirth = DateTime.now().subtract(Duration(days: 365 * 18));

  // Loading state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Start animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _fullNameController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _cityController.dispose();
    _addressController.dispose();
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.defaultSpacing),
                  child: Column(
                    children: [
                      _buildHeader(),
                      SizedBox(height: AppTheme.extraLargeSpacing),
                      _buildMainCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Hero(
          tag: 'applicant_icon',
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.person_add_alt_1,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: AppTheme.mediumSpacing),
        Text(
          'Add New Applicant',
          style: AppTheme.FontStyle.copyWith(fontSize: 28),
        ),
        SizedBox(height: 8),
        Text(
          'Please fill in all the required information',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeader('Personal Information', Icons.person),
              SizedBox(height: AppTheme.mediumSpacing),

              _buildAnimatedTextField(
                controller: _fullNameController,
                label: 'Full Name *',
                icon: Icons.person,
                delay: 100,
                validator: (value) =>
                value!.isEmpty ? 'Please enter full name' : null,
              ),

              SizedBox(height: AppTheme.mediumSpacing),

              _buildAnimatedTextField(
                controller: _fatherNameController,
                label: "Father's Name *",
                icon: Icons.man,
                delay: 200,
                validator: (value) =>
                value!.isEmpty ? "Please enter father's name" : null,
              ),

              SizedBox(height: AppTheme.mediumSpacing),

              _buildAnimatedTextField(
                controller: _motherNameController,
                label: "Mother's Name *",
                icon: Icons.woman,
                delay: 300,
                validator: (value) =>
                value!.isEmpty ? "Please enter mother's name" : null,
              ),

              SizedBox(height: AppTheme.mediumSpacing),

              _buildAnimatedDatePicker(delay: 400),

              SizedBox(height: AppTheme.extraLargeSpacing),

              _buildSectionHeader('Address Information', Icons.location_on),
              SizedBox(height: AppTheme.mediumSpacing),

              _buildAnimatedTextField(
                controller: _cityController,
                label: 'City *',
                icon: Icons.location_city,
                delay: 500,
                validator: (value) =>
                value!.isEmpty ? 'Please enter city' : null,
              ),

              SizedBox(height: AppTheme.mediumSpacing),

              _buildAnimatedTextField(
                controller: _addressController,
                label: 'Current Address *',
                icon: Icons.home,
                delay: 600,
                maxLines: 3,
                validator: (value) =>
                value!.isEmpty ? 'Please enter current address' : null,
              ),

              SizedBox(height: AppTheme.extraLargeSpacing),

              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.blue600.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.blue600.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.blue600,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.blue600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required int delay,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              validator: validator,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(icon, color: AppTheme.blue600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide(
                    color: AppTheme.blue600,
                    width: AppTheme.focusedBorderWidth,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDatePicker({required int delay}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () => _selectDateOfBirth(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  color: Colors.grey[50],
                ),
                child: Row(
                  children: [
                    Icon(Icons.date_range, color: AppTheme.blue600),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Date of Birth: ${_selectedDateOfBirth.day}/${_selectedDateOfBirth.month}/${_selectedDateOfBirth.year}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 700),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: AppTheme.buttonHeight,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitApplicant,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.blue600,
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Add Applicant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppTheme.mediumSpacing),
              Container(
                width: double.infinity,
                height: AppTheme.buttonHeight,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.blue600, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, color: AppTheme.blue600),
                      SizedBox(width: 8),
                      Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppTheme.blue600,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.blue600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
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

  Future<void> _submitApplicant() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Applicant added successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

      // Navigate back or to next screen
      Navigator.pop(context);
    }
  }
}