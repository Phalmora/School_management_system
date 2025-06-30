import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeColor.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';

class AddSportGroupScreen extends StatefulWidget {
  @override
  _AddSportGroupScreenState createState() => _AddSportGroupScreenState();
}

class _AddSportGroupScreenState extends State<AddSportGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final _coachController = TextEditingController();
  final _maxMembersController = TextEditingController();
  String _selectedSportType = 'Football';
  List<String> _sportTypes = ['Football', 'Basketball', 'Cricket', 'Tennis', 'Swimming', 'Athletics'];

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
              _buildHeader('Create Sport Group'),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.white,
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _buildSportGroupForm(),
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
            Icons.sports_soccer,
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

  Widget _buildSportGroupForm() {
    return SingleChildScrollView(
      padding: AppThemeResponsiveness.getScreenPadding(context),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _groupNameController,
              label: 'Group Name',
              hint: 'e.g., Royal Eagles',
              icon: Icons.group,
              validator: (value) => value!.isEmpty ? 'Please enter group name' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildSportTypeDropdown(),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _coachController,
              label: 'Coach Name',
              hint: 'Assigned coach',
              icon: Icons.person,
              validator: (value) => value!.isEmpty ? 'Please enter coach name' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _maxMembersController,
              label: 'Maximum Members',
              hint: 'Team size limit',
              icon: Icons.people,
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Please enter max members' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),
            _buildSubmitButton('Create Sport Group'),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSportTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sport Type',
          style: AppThemeResponsiveness.getSubtitleTextStyle(context),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        DropdownButtonFormField<String>(
          value: _selectedSportType,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.sports,
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
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: Colors.red.shade600,
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
          items: _sportTypes.map((String sport) {
            return DropdownMenuItem<String>(
              value: sport,
              child: Text(
                sport,
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSportType = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
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
          keyboardType: keyboardType,
          validator: validator,
          maxLines: AppThemeResponsiveness.getTextFieldMaxLines(context),
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
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              borderSide: BorderSide(
                color: Colors.red.shade600,
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
      // Here you would typically save to database
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
                'Sport group created successfully!',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  color: AppThemeColor.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
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
    _groupNameController.dispose();
    _coachController.dispose();
    _maxMembersController.dispose();
    super.dispose();
  }
}