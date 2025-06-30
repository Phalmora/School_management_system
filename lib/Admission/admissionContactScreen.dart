import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/inputField.dart';
import 'package:school/customWidgets/sectionTitle.dart';

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
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppThemeResponsiveness.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                padding: AppThemeResponsiveness.getScreenPadding(context),
                child: Column(
                  children: [
                    _buildProgressIndicator(3, 4),
                    SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                    Text(
                      'Contact & Address Information',
                      style: AppThemeResponsiveness.getFontStyle(context),
                    ),
                    SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                    Text(
                      'Please provide your contact details and address',
                      style: AppThemeResponsiveness.getSplashSubtitleStyle(context),
                    ),
                    SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                    Card(
                      elevation: AppThemeResponsiveness.getCardElevation(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      ),
                      child: Padding(
                        padding: AppThemeResponsiveness.getCardPadding(context),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SectionTitleBlueAdmission(title: 'Address Information'),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
                                controller: _addressController,
                                label: 'Full Address *',
                                icon: Icons.location_on,
                                validator: (value) =>
                                value!.isEmpty ? 'Please enter full address' : null,
                              ),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              _buildCityStateRow(),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
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
                              SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
                              SectionTitleBlueAdmission(title: 'Contact Information'),
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
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
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
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
                              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                              AppTextFieldBuilder.build(
                                context: context,
                                controller: _alternateContactController,
                                label: 'Alternate Contact Number',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),
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
      padding: AppThemeResponsiveness.getVerticalPadding(context),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getSmallSpacing(context) / 4,
              ),
              height: AppThemeResponsiveness.isMobile(context) ? 4 : 6,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppThemeColor.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.isMobile(context) ? 2 : 3),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCityStateRow() {
    // On mobile, stack vertically for better UX
    if (AppThemeResponsiveness.isMobile(context)) {
      return Column(
        children: [
          AppTextFieldBuilder.build(
            context: context,
            controller: _cityController,
            label: 'City *',
            icon: Icons.location_city,
            validator: (value) =>
            value!.isEmpty ? 'Please enter city' : null,
          ),

          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          AppTextFieldBuilder.build(
            context: context,
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
          child: AppTextFieldBuilder.build(
            context: context,
            controller: _cityController,
            label: 'City *',
            icon: Icons.location_city,
            validator: (value) =>
            value!.isEmpty ? 'Please enter city' : null,
          ),
        ),
        SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
        Expanded(
          child: AppTextFieldBuilder.build(
            context: context,
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
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Back',
              onPressed: () => Navigator.pop(context),
              isSecondary: true,
            ),
          ),
        ),
        SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
        Expanded(
          child: Container(
            height: AppThemeResponsiveness.getButtonHeight(context),
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
        backgroundColor: isSecondary ? Colors.grey[300] : AppThemeColor.blue600,
        foregroundColor: isSecondary ? Colors.black87 : Colors.white,
        elevation: AppThemeResponsiveness.getButtonElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
      ),
      child: Text(
        text,
        style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
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