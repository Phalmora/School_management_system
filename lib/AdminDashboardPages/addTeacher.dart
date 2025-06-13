import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AddTeacherScreen extends StatefulWidget {
  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _teacherIdController = TextEditingController();
  final _dobController = TextEditingController();
  final _designationController = TextEditingController();
  final _tagsController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  File? _selectedImage;
  DateTime? _selectedDate;
  bool _isLoading = false;

  // Predefined designations for dropdown
  final List<String> _designations = [
    'Principal',
    'Vice Principal',
    'Head Teacher',
    'Senior Teacher',
    'Teacher',
    'Assistant Teacher',
    'Subject Coordinator',
    'Department Head',
    'Lab Assistant',
    'Physical Education Teacher',
    'Librarian',
    'Counselor'
  ];

  String? _selectedDesignation;

  @override
  void dispose() {
    _nameController.dispose();
    _teacherIdController.dispose();
    _dobController.dispose();
    _designationController.dispose();
    _tagsController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Photo Source',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildImageSourceOption(
                        icon: Icons.camera_alt,
                        label: 'Camera',
                        onTap: () => _getImage(ImageSource.camera),
                      ),
                      _buildImageSourceOption(
                        icon: Icons.photo_library,
                        label: 'Gallery',
                        onTap: () => _getImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      _showErrorDialog('Error selecting image source');
    }
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: AppTheme.primaryBlue),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    Navigator.pop(context);
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorDialog('Error picking image: ${e.toString()}');
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 25)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number must contain only digits';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Future<void> _saveTeacher() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedImage == null) {
      _showErrorDialog('Please select a photo for the teacher');
      return;
    }

    if (_selectedDate == null) {
      _showErrorDialog('Please select date of birth');
      return;
    }

    if (_selectedDesignation == null) {
      _showErrorDialog('Please select a designation');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Here you would typically save to database/API
      // For now, we'll just show success message

      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog('Error saving teacher: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: Text('Teacher has been added successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
              },
              child: Text(
                'OK',
                style: TextStyle(color: AppTheme.primaryBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red, size: 30),
              SizedBox(width: 10),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add_alt, color: Colors.white,),
                  SizedBox(width: 10),
                  Text(
                    'Add New Teacher',
                    style: AppTheme.FontStyle,
                  ),
                ],
              ),
            ),

            // Form Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Photo Selection Section
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.blue50,
                                      border: Border.all(
                                        color: AppTheme.primaryBlue,
                                        width: 2,
                                      ),
                                    ),
                                    child: _selectedImage != null
                                        ? ClipOval(
                                      child: Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                        : Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: AppTheme.primaryBlue,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Tap to add photo',
                                  style: TextStyle(
                                    color: AppTheme.primaryBlue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30),

                          // Name Field
                          _buildInputField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person,
                            validator: (value) => _validateRequired(value, 'Name'),
                            textCapitalization: TextCapitalization.words,
                          ),

                          SizedBox(height: 20),

                          // Teacher ID Field
                          _buildInputField(
                            controller: _teacherIdController,
                            label: 'Teacher ID',
                            icon: Icons.badge,
                            validator: (value) => _validateRequired(value, 'Teacher ID'),
                            textCapitalization: TextCapitalization.characters,
                          ),

                          SizedBox(height: 20),

                          // Date of Birth Field
                          _buildInputField(
                            controller: _dobController,
                            label: 'Date of Birth',
                            icon: Icons.calendar_today,
                            readOnly: true,
                            onTap: _selectDate,
                            validator: (value) => _validateRequired(value, 'Date of Birth'),
                          ),

                          SizedBox(height: 20),

                          // Designation Dropdown
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _selectedDesignation,
                              decoration: InputDecoration(
                                labelText: 'Designation',
                                prefixIcon: Icon(Icons.work, color: AppTheme.primaryBlue),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              ),
                              items: _designations.map((String designation) {
                                return DropdownMenuItem<String>(
                                  value: designation,
                                  child: Text(designation),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDesignation = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a designation';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 20),

                          // Tags Field (Optional)
                          _buildInputField(
                            controller: _tagsController,
                            label: 'Tags (Optional)',
                            icon: Icons.local_offer,
                            hintText: 'e.g., Mathematics, Science, Sports',
                            textCapitalization: TextCapitalization.words,
                          ),

                          SizedBox(height: 20),

                          // Mobile Field
                          _buildInputField(
                            controller: _mobileController,
                            label: 'Mobile Number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: _validateMobile,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                          ),

                          SizedBox(height: 20),

                          // Email Field
                          _buildInputField(
                            controller: _emailController,
                            label: 'Email Address',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),

                          SizedBox(height: 40),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            height: AppTheme.buttonHeight,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _saveTeacher,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                elevation: AppTheme.buttonElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                                ),
                              ),
                              child: _isLoading
                                  ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Saving...', style: AppTheme.buttonTextStyle),
                                ],
                              )
                                  : Text('Save Teacher', style: AppTheme.buttonTextStyle),
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppTheme.primaryBlue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide(
              color: AppTheme.primaryBlue,
              width: AppTheme.focusedBorderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}