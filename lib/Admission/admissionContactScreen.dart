import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionContactScreen extends StatefulWidget {
  @override
  _AdmissionContactScreenState createState() => _AdmissionContactScreenState();
}

class _AdmissionContactScreenState extends State<AdmissionContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _alternateContactController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _alternateContactController.dispose();
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                padding: AppTheme.getScreenPadding(context),
                child: Column(
                  children: [
                    _buildProgressIndicator(3, 4),
                    SizedBox(height: AppTheme.getDefaultSpacing(context)),
                    Text(
                      'Contact & Address Information',
                      style: AppTheme.getFontStyle(context),
                    ),
                    SizedBox(height: AppTheme.getSmallSpacing(context)),
                    Text(
                      'Please provide your contact details and address',
                      style: AppTheme.getSplashSubtitleStyle(context),
                    ),
                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                    Card(
                      elevation: AppTheme.getCardElevation(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
                      ),
                      child: Padding(
                        padding: AppTheme.getCardPadding(context),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildSectionHeader('Address Information'),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _addressController,
                                label: 'Full Address *',
                                icon: Icons.location_on,
                                maxLines: AppTheme.isMobile(context) ? 2 : 3,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter full address' : null,
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildCityStateRow(),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _zipCodeController,
                                label: 'ZIP/Postal Code *',
                                icon: Icons.local_post_office,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Please enter ZIP code';
                                  if (value.length < 5) return 'Please enter valid ZIP code';
                                  return null;
                                },
                              ),
                              SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                              _buildSectionHeader('Contact Information'),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _mobileController,
                                label: 'Mobile Number (Student/Parent) *',
                                icon: Icons.phone_android,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Please enter mobile number';
                                  if (value.length < 10) return 'Please enter valid mobile number';
                                  return null;
                                },
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _emailController,
                                label: 'Email (Parent/Student) *',
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Please enter email';
                                  if (!value.contains('@')) return 'Please enter valid email';
                                  return null;
                                },
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _alternateContactController,
                                label: 'Alternate Contact Number',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                              buildActionButtons(),
                            ],
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
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: AppTheme.getVerticalPadding(context),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppTheme.getSmallSpacing(context) / 4,
              ),
              height: AppTheme.isMobile(context) ? 4 : 6,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppTheme.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(AppTheme.isMobile(context) ? 2 : 3),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.getSmallSpacing(context)),
      child: Text(
        title,
        style: AppTheme.getHeadingStyle(context).copyWith(
          color: AppTheme.blue600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    int effectiveMaxLines = maxLines ?? AppTheme.getTextFieldMaxLines(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: effectiveMaxLines,
      validator: validator,
      style: AppTheme.getBodyTextStyle(context),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.getSubHeadingStyle(context),
        prefixIcon: Icon(
          icon,
          size: AppTheme.getIconSize(context),
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.getDefaultSpacing(context),
          vertical: AppTheme.getMediumSpacing(context),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildCityStateRow() {
    // On mobile, stack vertically for better UX
    if (AppTheme.isMobile(context)) {
      return Column(
        children: [
          _buildTextField(
            controller: _cityController,
            label: 'City *',
            icon: Icons.location_city,
            validator: (value) =>
            value!.isEmpty ? 'Please enter city' : null,
          ),
          SizedBox(height: AppTheme.getMediumSpacing(context)),
          _buildTextField(
            controller: _stateController,
            label: 'State/Province *',
            icon: Icons.map,
            validator: (value) =>
            value!.isEmpty ? 'Please enter state' : null,
          ),
        ],
      );
    }

    // On tablet and desktop, use row layout
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _cityController,
            label: 'City *',
            icon: Icons.location_city,
            validator: (value) =>
            value!.isEmpty ? 'Please enter city' : null,
          ),
        ),
        SizedBox(width: AppTheme.getMediumSpacing(context)),
        Expanded(
          child: _buildTextField(
            controller: _stateController,
            label: 'State/Province *',
            icon: Icons.map,
            validator: (value) =>
            value!.isEmpty ? 'Please enter state' : null,
          ),
        ),
      ],
    );
  }

  Widget buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Back',
              onPressed: () => Navigator.pop(context),
              isSecondary: true,
            ),
          ),
        ),
        SizedBox(width: AppTheme.getMediumSpacing(context)),
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Next',
              onPressed: _nextPage,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? Colors.grey[300] : AppTheme.blue600,
        foregroundColor: isSecondary ? Colors.black87 : Colors.white,
        elevation: AppTheme.getButtonElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
      ),
      child: Text(
        text,
        style: AppTheme.getButtonTextStyle(context).copyWith(
          color: isSecondary ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      // Save data and navigate to next page
      Navigator.pushNamed(context, '/admission-documents');
    }
  }
}