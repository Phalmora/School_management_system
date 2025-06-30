// Add House Group Screen
import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeColor.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';

class AddHouseGroupScreen extends StatefulWidget {
  @override
  _AddHouseGroupScreenState createState() => _AddHouseGroupScreenState();
}

class _AddHouseGroupScreenState extends State<AddHouseGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _houseNameController = TextEditingController();
  final _captainController = TextEditingController();
  final _viceCaptainController = TextEditingController();
  String _selectedColor = 'Red';
  List<String> _houseColors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'];

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
              _buildHeader('Create House Group'),
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
                  child: _buildHouseGroupForm(),
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
            Icons.home,
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

  Widget _buildHouseGroupForm() {
    return SingleChildScrollView(
      padding: AppThemeResponsiveness.getScreenPadding(context),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _houseNameController,
              label: 'House Name',
              hint: 'e.g., Phoenix House',
              icon: Icons.home,
              validator: (value) => value!.isEmpty ? 'Please enter house name' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildColorDropdown(),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _captainController,
              label: 'House Captain',
              hint: 'Captain name',
              icon: Icons.person,
              validator: (value) => value!.isEmpty ? 'Please enter captain name' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            _buildInputField(
              controller: _viceCaptainController,
              label: 'Vice Captain',
              hint: 'Vice captain name',
              icon: Icons.person_outline,
              validator: (value) => value!.isEmpty ? 'Please enter vice captain name' : null,
            ),
            SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),
            _buildSubmitButton('Create House Group'),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'House Color',
          style: AppThemeResponsiveness.getSubtitleTextStyle(context),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        DropdownButtonFormField<String>(
          value: _selectedColor,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.palette,
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
          items: _houseColors.map((String color) {
            return DropdownMenuItem<String>(
              value: color,
              child: Row(
                children: [
                  Container(
                    width: AppThemeResponsiveness.getIconSize(context),
                    height: AppThemeResponsiveness.getIconSize(context),
                    decoration: BoxDecoration(
                      color: _getColorFromString(color),
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getIconSize(context) / 2),
                      border: Border.all(color: AppThemeColor.greyl),
                    ),
                  ),
                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
                  Text(
                    color,
                    style: AppThemeResponsiveness.getBodyTextStyle(context),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedColor = newValue!;
            });
          },
        ),
      ],
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return AppThemeColor.red;
      case 'blue':
        return AppThemeColor.primaryBlue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
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
                'House group created successfully!',
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
    _houseNameController.dispose();
    _captainController.dispose();
    _viceCaptainController.dispose();
    super.dispose();
  }
}