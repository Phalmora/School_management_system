import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:flutter/services.dart';

class StudentInformation extends StatefulWidget {
  const StudentInformation({super.key});

  @override
  State<StudentInformation> createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _previousSchoolController = TextEditingController();

  //Form State
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedCategory;

  //Static Data
  static const List<String> _genderOptions = ['Male', 'Female', 'Other'];
  static const List<String> _categoryOptions = ['General', 'SC', 'ST', 'OBC', 'EWS'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _nationalityController.dispose();
    _aadharController.dispose();
    _previousSchoolController.dispose();
    super.dispose();
  }

  // Helper method to determine screen size
  bool _isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  bool _isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;
  bool _isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1200;

  // Responsive spacing and sizing
  double _getHorizontalPadding(BuildContext context) {
    if (_isMobile(context)) return 16.0;
    if (_isTablet(context)) return 32.0;
    return 48.0;
  }

  double _getFormMaxWidth(BuildContext context) {
    if (_isMobile(context)) return double.infinity;
    if (_isTablet(context)) return 600.0;
    return 800.0;
  }

  EdgeInsets _getContainerMargin(BuildContext context) {
    final padding = _getHorizontalPadding(context);
    return EdgeInsets.all(padding);
  }

  //Data Selection Method
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
        lastDate: DateTime.now(),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: AppTheme.primaryBlue,
                  onPrimary: AppTheme.white,
                  onSurface: Colors.black),
            ),
            child: child!));

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  //Details Submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessSnackBar();
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Student information saved successfully!'),
      backgroundColor: AppTheme.primaryBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _getFormMaxWidth(context),
              ),
              child: Container(
                margin: _getContainerMargin(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(_getHorizontalPadding(context)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Section
                        _buildTitleSection(context),
                        const SizedBox(height: 24),

                        // Form Fields - Responsive Layout
                        if (_isDesktop(context)) ...[
                          _buildDesktopLayout(),
                        ] else if (_isTablet(context)) ...[
                          _buildTabletLayout(),
                        ] else ...[
                          _buildMobileLayout(),
                        ],

                        SizedBox(height: _isMobile(context) ? 24 : 32),
                        _buildSubmitButtons(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Student Information',
          style: TextStyle(
            fontSize: _isMobile(context) ? 24 : 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please fill in all the required information',
          style: TextStyle(
            fontSize: _isMobile(context) ? 14 : 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildTextField(
          controller: _fullNameController,
          label: 'Full Name',
          icon: Icons.person,
          isRequired: true,
          validator: _validateFullName,
        ),
        _buildDateField(),
        _buildDropdownField(
          label: 'Gender',
          icon: Icons.wc,
          value: _selectedGender,
          items: _genderOptions,
          onChanged: (value) => setState(() => _selectedGender = value),
          isRequired: true,
        ),
        _buildTextField(
          controller: _nationalityController,
          label: 'Nationality',
          icon: Icons.flag,
          isRequired: false,
        ),
        _buildTextField(
          controller: _aadharController,
          label: 'Aadhar Number / National ID',
          icon: Icons.credit_card,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
          ],
          validator: _validateAadhar,
          isRequired: false,
        ),
        _buildDropdownField(
          label: 'Category',
          icon: Icons.category,
          value: _selectedCategory,
          items: _categoryOptions,
          onChanged: (value) => setState(() => _selectedCategory = value),
          isRequired: false,
        ),
        _buildTextField(
          controller: _previousSchoolController,
          label: 'Previous School',
          icon: Icons.school_outlined,
          isRequired: false,
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                icon: Icons.person,
                isRequired: true,
                validator: _validateFullName,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildDateField()),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildDropdownField(
                label: 'Gender',
                icon: Icons.wc,
                value: _selectedGender,
                items: _genderOptions,
                onChanged: (value) => setState(() => _selectedGender = value),
                isRequired: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _nationalityController,
                label: 'Nationality',
                icon: Icons.flag,
                isRequired: false,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _aadharController,
                label: 'Aadhar Number / National ID',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
                validator: _validateAadhar,
                isRequired: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDropdownField(
                label: 'Category',
                icon: Icons.category,
                value: _selectedCategory,
                items: _categoryOptions,
                onChanged: (value) => setState(() => _selectedCategory = value),
                isRequired: false,
              ),
            ),
          ],
        ),
        _buildTextField(
          controller: _previousSchoolController,
          label: 'Previous School',
          icon: Icons.school_outlined,
          isRequired: false,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                icon: Icons.person,
                isRequired: true,
                validator: _validateFullName,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(child: _buildDateField()),
            const SizedBox(width: 20),
            Expanded(
              child: _buildDropdownField(
                label: 'Gender',
                icon: Icons.wc,
                value: _selectedGender,
                items: _genderOptions,
                onChanged: (value) => setState(() => _selectedGender = value),
                isRequired: true,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _nationalityController,
                label: 'Nationality',
                icon: Icons.flag,
                isRequired: false,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildTextField(
                controller: _aadharController,
                label: 'Aadhar Number / National ID',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
                validator: _validateAadhar,
                isRequired: false,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildDropdownField(
                label: 'Category',
                icon: Icons.category,
                value: _selectedCategory,
                items: _categoryOptions,
                onChanged: (value) => setState(() => _selectedCategory = value),
                isRequired: false,
              ),
            ),
          ],
        ),
        _buildTextField(
          controller: _previousSchoolController,
          label: 'Previous School',
          icon: Icons.school_outlined,
          isRequired: false,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isRequired,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 16 : 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator ?? (isRequired ? (value) => _validateRequired(value, label) : null),
        style: TextStyle(fontSize: _isMobile(context) ? 16 : 18),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: _isMobile(context) ? 14 : 16),
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: _isMobile(context) ? 20 : 24),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: _isMobile(context) ? 16 : 20,
            vertical: _isMobile(context) ? 16 : 20,
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 16 : 20),
      child: FormField<DateTime>(
        validator: (value) => _selectedDate == null ? 'Date of Birth is required' : null,
        builder: (FormFieldState<DateTime> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _isMobile(context) ? 16 : 20,
                    vertical: _isMobile(context) ? 16 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: state.hasError ? Colors.red : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey.shade600,
                        size: _isMobile(context) ? 20 : 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDate == null
                            ? 'Date of Birth'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: TextStyle(
                          color: _selectedDate == null ? Colors.grey.shade600 : Colors.black87,
                          fontSize: _isMobile(context) ? 16 : 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 5),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isRequired,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 16 : 20),
      child: DropdownButtonFormField<String>(
        value: value,
        validator: isRequired ? (value) => _validateRequired(value, label) : null,
        style: TextStyle(
          fontSize: _isMobile(context) ? 16 : 18,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: _isMobile(context) ? 14 : 16),
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: _isMobile(context) ? 20 : 24),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: _isMobile(context) ? 16 : 20,
            vertical: _isMobile(context) ? 16 : 20,
          ),
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSubmitButtons(BuildContext context) {
    return SizedBox(
      width: _isDesktop(context) ? 300 : double.infinity,
      height: _isMobile(context) ? 50 : 56,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: Colors.white,
          elevation: AppTheme.buttonElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
        ),
        child: Text(
          'Submit Details',
          style: TextStyle(
            fontSize: _isMobile(context) ? 16 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Validation Methods
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full Name is required';
    }
    if (value.trim().length < 2) {
      return 'Full Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateAadhar(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length != 12) {
        return 'Aadhar Number must be 12 digits';
      }
      if (!RegExp(r'^\d+$').hasMatch(value)) {
        return 'Aadhar Number must contain only digits';
      }
    }
    return null;
  }
}