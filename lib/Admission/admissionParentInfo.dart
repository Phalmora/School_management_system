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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.defaultSpacing),
              child: Column(
                children: [
                  _buildProgressIndicator(2, 4),
                  SizedBox(height: AppTheme.defaultSpacing),
                  Text(
                    'Parent/Guardian Information',
                    style: AppTheme.FontStyle,
                  ),
                  SizedBox(height: AppTheme.extraLargeSpacing),
                  Card(
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
                            Text(
                              'Father\'s Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.blue600,
                              ),
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _fatherNameController,
                              label: 'Father\'s Name *',
                              icon: Icons.person,
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter father\'s name' : null,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _fatherOccupationController,
                              label: 'Father\'s Occupation',
                              icon: Icons.work,
                            ),
                            SizedBox(height: AppTheme.extraLargeSpacing),

                            Text(
                              'Mother\'s Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.blue600,
                              ),
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _motherNameController,
                              label: 'Mother\'s Name *',
                              icon: Icons.person,
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter mother\'s name' : null,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _motherOccupationController,
                              label: 'Mother\'s Occupation',
                              icon: Icons.work,
                            ),
                            SizedBox(height: AppTheme.extraLargeSpacing),

                            Text(
                              'Guardian Information (if different)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.blue600,
                              ),
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _guardianNameController,
                              label: 'Guardian Name',
                              icon: Icons.person_outline,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _guardianRelationshipController,
                              label: 'Relationship with Student',
                              icon: Icons.family_restroom,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _guardianContactController,
                              label: 'Guardian Contact Number',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: AppTheme.extraLargeSpacing),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAnimatedButton(
                                    text: 'Back',
                                    onPressed: () => Navigator.pop(context),
                                    isSecondary: true,
                                  ),
                                ),
                                SizedBox(width: AppTheme.mediumSpacing),
                                Expanded(
                                  child: _buildAnimatedButton(
                                    text: 'Next',
                                    onPressed: _nextPage,
                                  ),
                                ),
                              ],
                            ),
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
    );
  }

  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 4,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppTheme.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
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
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return Container(
      height: AppTheme.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.grey[300] : AppTheme.blue600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSecondary ? Colors.grey[700] : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/admission-contact');
    }
  }
}
