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
                  _buildProgressIndicator(3, 4),
                  SizedBox(height: AppTheme.defaultSpacing),
                  Text(
                    'Contact & Address Information',
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
                              'Address Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.blue600,
                              ),
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _addressController,
                              label: 'Full Address *',
                              icon: Icons.location_on,
                              maxLines: 3,
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter full address' : null,
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
                            Row(
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
                                SizedBox(width: AppTheme.mediumSpacing),
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
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
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
                            SizedBox(height: AppTheme.extraLargeSpacing),

                            Text(
                              'Contact Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.blue600,
                              ),
                            ),
                            SizedBox(height: AppTheme.mediumSpacing),
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
                            SizedBox(height: AppTheme.mediumSpacing),
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
                            SizedBox(height: AppTheme.mediumSpacing),
                            _buildTextField(
                              controller: _alternateContactController,
                              label: 'Alternate Contact Number',
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
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
      Navigator.pushNamed(context, '/admission-documents');
    }
  }
}
