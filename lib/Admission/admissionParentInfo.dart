import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionParentInfoScreen extends StatefulWidget {
  @override
  _AdmissionParentInfoScreenState createState() => _AdmissionParentInfoScreenState();
}

class _AdmissionParentInfoScreenState extends State<AdmissionParentInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fatherNameController = TextEditingController();
  final _fatherOccupationController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _motherOccupationController = TextEditingController();
  final _guardianNameController = TextEditingController();
  final _guardianRelationshipController = TextEditingController();
  final _guardianContactController = TextEditingController();

  @override
  void dispose() {
    _fatherNameController.dispose();
    _fatherOccupationController.dispose();
    _motherNameController.dispose();
    _motherOccupationController.dispose();
    _guardianNameController.dispose();
    _guardianRelationshipController.dispose();
    _guardianContactController.dispose();
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
                    _buildProgressIndicator(2, 4),
                    SizedBox(height: AppTheme.getDefaultSpacing(context)),
                    Text(
                      'Parent/Guardian Information',
                      style: AppTheme.getFontStyle(context),
                    ),
                    SizedBox(height: AppTheme.getSmallSpacing(context)),
                    Text(
                      'Please provide details about parent/guardian',
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
                              _buildSectionHeader('Father\'s Information'),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _fatherNameController,
                                label: 'Father\'s Name *',
                                icon: Icons.person,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter father\'s name' : null,
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _fatherOccupationController,
                                label: 'Father\'s Occupation',
                                icon: Icons.work,
                              ),
                              SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                              _buildSectionHeader('Mother\'s Information'),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _motherNameController,
                                label: 'Mother\'s Name *',
                                icon: Icons.person,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter mother\'s name' : null,
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _motherOccupationController,
                                label: 'Mother\'s Occupation',
                                icon: Icons.work,
                              ),
                              SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                              _buildSectionHeader('Guardian Information (if different)'),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _guardianNameController,
                                label: 'Guardian Name',
                                icon: Icons.person_outline,
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _guardianRelationshipController,
                                label: 'Relationship with Student',
                                icon: Icons.family_restroom,
                              ),
                              SizedBox(height: AppTheme.getMediumSpacing(context)),
                              _buildTextField(
                                controller: _guardianContactController,
                                label: 'Guardian Contact Number',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty && value.length < 10) {
                                    return 'Please enter valid phone number';
                                  }
                                  return null;
                                },
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
      Navigator.pushNamed(context, '/admission-contact');
    }
  }
}