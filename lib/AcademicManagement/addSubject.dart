import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeColor.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectNameController = TextEditingController();
  final _subjectCodeController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<String> _selectedClasses = [];
  List<String> _availableClasses = ['Class 1-A', 'Class 2-B', 'Class 3-C', 'Class 4-A'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader('Add New Subject'),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.white,
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                    boxShadow: [
                      BoxShadow(
                        color: AppThemeColor.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _buildSubjectForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: AppThemeResponsiveness.getScreenPadding(context),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getHeaderIconSize(context),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
          Icon(
            Icons.book,
            color: AppThemeColor.white,
            size: AppThemeResponsiveness.getHeaderIconSize(context),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: Text(
              title,
              style: AppThemeResponsiveness.getFontStyle(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectForm() {
    return SingleChildScrollView(
      padding: AppThemeResponsiveness.getScreenPadding(context),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _subjectNameController,
              label: 'Subject Name',
              hint: 'e.g., Mathematics',
              icon: Icons.book,
              validator: (value) => value!.isEmpty ? 'Please enter subject name' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _subjectCodeController,
              label: 'Subject Code',
              hint: 'e.g., MATH101',
              icon: Icons.code,
              validator: (value) => value!.isEmpty ? 'Please enter subject code' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Brief description of the subject',
              icon: Icons.description,
              maxLines: 3,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildClassSelection(),
            SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),
            _buildSubmitButton('Create Subject'),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppThemeResponsiveness.getSubtitleTextStyle(context),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        TextFormField(
          controller: controller,
          maxLines: maxLines ?? AppThemeResponsiveness.getTextFieldMaxLines(context),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppThemeResponsiveness.getInputHintStyle(context),
            prefixIcon: Icon(
              icon,
              color: AppThemeColor.primaryBlue,
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(color: AppThemeColor.greyd),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: AppThemeColor.primaryBlue,
                width: AppThemeResponsiveness.getFocusedBorderWidth(context),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(color: AppThemeColor.greyl),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(color: AppThemeColor.red400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: AppThemeColor.red600,
                width: AppThemeResponsiveness.getFocusedBorderWidth(context),
              ),
            ),
            filled: true,
            fillColor: AppThemeColor.blue50,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
              vertical: AppThemeResponsiveness.getMediumSpacing(context),
            ),
          ),
          style: AppThemeResponsiveness.getBodyTextStyle(context),
        ),
      ],
    );
  }

  Widget _buildClassSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assign to Classes',
          style: AppThemeResponsiveness.getSubtitleTextStyle(context),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Container(
          padding: AppThemeResponsiveness.getScreenPadding(context),
          decoration: BoxDecoration(
            border: Border.all(color: AppThemeColor.greyl),
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
            color: AppThemeColor.blue50,
          ),
          child: Column(
            children: _availableClasses.map((className) {
              return CheckboxListTile(
                title: Text(
                  className,
                  style: AppThemeResponsiveness.getBodyTextStyle(context),
                ),
                value: _selectedClasses.contains(className),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedClasses.add(className);
                    } else {
                      _selectedClasses.remove(className);
                    }
                  });
                },
                activeColor: AppThemeColor.primaryBlue,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(String text) {
    return Container(
      height: AppThemeResponsiveness.getButtonHeight(context),
      child: ElevatedButton(
        onPressed: () => _submitForm(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppThemeColor.primaryBlue,
          foregroundColor: AppThemeColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
          elevation: AppThemeResponsiveness.getButtonElevation(context),
          shadowColor: AppThemeColor.primaryBlue.withOpacity(0.3),
        ),
        child: Text(
          text,
          style: AppThemeResponsiveness.getButtonTextStyle(context),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessMessage();
      Navigator.pop(context);
    }
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Expanded(
              child: Text(
                'Subject created successfully!',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  color: AppThemeColor.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppThemeColor.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        margin: AppThemeResponsiveness.getScreenPadding(context),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    _subjectCodeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}