import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/themeColor.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final IconData icon;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final bool enabled;
  final double? height;
  final String Function(T)? itemLabelBuilder;
  final Widget Function(T)? itemBuilder;

  const AppDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.hintText,
    this.enabled = true,
    this.height,
    this.itemLabelBuilder,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double defaultHeight = 56.0;

    return SizedBox(
      height: height ?? defaultHeight,
      child: DropdownButtonFormField<T>(
        value: value,
        style: AppThemeResponsiveness.getBodyTextStyle(context),
        dropdownColor: Colors.white,
        decoration: _getInputDecoration(context),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: itemBuilder?.call(item) ??
                Text(
                  itemLabelBuilder?.call(item) ?? item.toString(),
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                    color: enabled ? Colors.black87 : Colors.grey[400],
                  ),
                ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        validator: validator,
        icon: Icon(
          Icons.arrow_drop_down,
          color: enabled ? Colors.grey[600] : Colors.grey[400],
        ),
        hint: hintText != null
            ? Text(
          hintText!,
          style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
            color: Colors.grey[400],
          ),
        )
            : null,
      ),
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppThemeResponsiveness.getSubHeadingStyle(context),
      prefixIcon: Icon(
        icon,
        size: AppThemeResponsiveness.getIconSize(context),
        color: enabled ? Colors.grey[600] : Colors.grey[400],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(
          color: AppThemeColor.blue600,
          width: AppThemeResponsiveness.getFocusedBorderWidth(context),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppThemeResponsiveness.getFocusedBorderWidth(context),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
        vertical: 16.0,
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  // Factory constructors for common dropdowns
  static AppDropdown<String> gender({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return AppDropdown<String>(
      value: value,
      items: const ['Male', 'Female', 'Other'],
      label: 'Gender *',
      icon: Icons.person_outline,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select gender' : null,
    );
  }

  static AppDropdown<String> role({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customRoles,
  }) {
    final defaultRoles = ['Admin', 'Academic Officer', 'Teacher', 'Principal', 'Vice Principal', 'Department Head'];

    return AppDropdown<String>(
      value: value,
      items: customRoles ?? defaultRoles,
      label: 'Role *',
      icon: Icons.assignment_ind,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select a role' : null,
    );
  }

  static AppDropdown<String> relationship({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customRelationships,
  }) {
    final defaultRelationships = [
      'Father',
      'Mother',
      'Guardian',
      'Grandfather',
      'Grandmother',
      'Uncle',
      'Aunt',
      'Brother',
      'Sister',
      'Legal Guardian',
      'Foster Parent',
      'Other Relative',
    ];

    return AppDropdown<String>(
      value: value,
      items: customRelationships ?? defaultRelationships,
      label: 'Relationship to Child *',
      icon: Icons.family_restroom,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select your relationship to the child' : null,
    );
  }

  static AppDropdown<String> subject({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customSubjects,
  }) {
    final defaultSubjects = [
      'Mathematics',
      'Science',
      'English',
      'Hindi',
      'Social Studies',
      'Physics',
      'Chemistry',
      'Biology',
      'Computer Science',
      'Physical Education',
      'History',
      'Geography',
      'Economics',
      'Political Science',
      'Sanskrit',
      'French',
      'German',
      'Art & Craft',
      'Music',
      'Dance',
      'Environmental Science',
      'Psychology',
      'Sociology',
      'Philosophy',
      'Statistics',
      'Business Studies',
      'Accountancy',
    ];

    return AppDropdown<String>(
      value: value,
      items: customSubjects ?? defaultSubjects,
      label: 'Subject *',
      icon: Icons.book,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select a subject' : null,
    );
  }

  static AppDropdown<String> category({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return AppDropdown<String>(
      value: value,
      items: const ['General', 'SC', 'ST', 'OBC', 'EWS'],
      label: 'Category *',
      icon: Icons.category,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select category' : null,
    );
  }

  static AppDropdown<String> academicYear({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customYears,
  }) {
    final defaultYears = [
      '2024-2025',
      '2025-2026',
      '2026-2027',
      '2027-2028',
      '2028-2029'
    ];

    return AppDropdown<String>(
      value: value,
      items: customYears ?? defaultYears,
      label: 'Academic Year *',
      icon: Icons.calendar_today,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select an academic year' : null,
    );
  }

  static AppDropdown<String> classGrade({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customClasses,
  }) {
    final defaultClasses = [
      'Nursery', 'LKG', 'UKG',
      '1st Grade', '2nd Grade', '3rd Grade', '4th Grade',
      '5th Grade', '6th Grade', '7th Grade', '8th Grade',
      '9th Grade', '10th Grade', '11th Grade', '12th Grade'
    ];

    return AppDropdown<String>(
      value: value,
      items: customClasses ?? defaultClasses,
      label: 'Class to be Admitted In *',
      icon: Icons.class_,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select a class' : null,
    );
  }

  static AppDropdown<String> studentType({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customTypes,
  }) {
    final defaultTypes = ['New', 'Transfer'];

    return AppDropdown<String>(
      value: value,
      items: customTypes ?? defaultTypes,
      label: 'Student Type *',
      icon: Icons.person_outline,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select student type' : null,
    );
  }

  static AppDropdown<String> bloodGroup({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return AppDropdown<String>(
      value: value,
      items: const ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
      label: 'Blood Group',
      icon: Icons.bloodtype,
      onChanged: onChanged,
      validator: validator,
    );
  }

  static AppDropdown<String> religion({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customReligions,
  }) {
    final defaultReligions = [
      'Hinduism',
      'Islam',
      'Christianity',
      'Sikhism',
      'Buddhism',
      'Jainism',
      'Judaism',
      'Zoroastrianism',
      'Other',
      'Prefer not to say',
    ];

    return AppDropdown<String>(
      value: value,
      items: customReligions ?? defaultReligions,
      label: 'Religion',
      icon: Icons.mosque,
      onChanged: onChanged,
      validator: validator,
    );
  }

  static AppDropdown<String> nationality({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customNationalities,
  }) {
    final defaultNationalities = [
      'Indian',
      'American',
      'British',
      'Canadian',
      'Australian',
      'German',
      'French',
      'Japanese',
      'Chinese',
      'Other',
    ];

    return AppDropdown<String>(
      value: value,
      items: customNationalities ?? defaultNationalities,
      label: 'Nationality',
      icon: Icons.flag,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select nationality' : null,
    );
  }

  static AppDropdown<String> maritalStatus({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return AppDropdown<String>(
      value: value,
      items: const ['Single', 'Married', 'Divorced', 'Widowed', 'Separated'],
      label: 'Marital Status',
      icon: Icons.favorite,
      onChanged: onChanged,
      validator: validator,
    );
  }

  static AppDropdown<String> qualification({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customQualifications,
  }) {
    final defaultQualifications = [
      'Below 10th',
      '10th Pass',
      '12th Pass',
      'Diploma',
      'Graduate',
      'Post Graduate',
      'Professional Degree',
      'Doctorate',
    ];

    return AppDropdown<String>(
      value: value,
      items: customQualifications ?? defaultQualifications,
      label: 'Educational Qualification',
      icon: Icons.school,
      onChanged: onChanged,
      validator: validator,
    );
  }

  static AppDropdown<String> occupation({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customOccupations,
  }) {
    final defaultOccupations = [
      'Government Service',
      'Private Service',
      'Business',
      'Professional',
      'Farmer',
      'Teacher',
      'Doctor',
      'Engineer',
      'Lawyer',
      'Retired',
      'Housewife/Homemaker',
      'Self Employed',
      'Unemployed',
      'Other',
    ];

    return AppDropdown<String>(
      value: value,
      items: customOccupations ?? defaultOccupations,
      label: 'Occupation',
      icon: Icons.work,
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Generic factory constructor for custom dropdowns
  static AppDropdown<T> custom<T>({
    required T? value,
    required List<T> items,
    required String label,
    required IconData icon,
    required ValueChanged<T?> onChanged,
    String? Function(T?)? validator,
    String? hintText,
    bool enabled = true,
    double? height,
    String Function(T)? itemLabelBuilder,
    Widget Function(T)? itemBuilder,
  }) {
    return AppDropdown<T>(
      value: value,
      items: items,
      label: label,
      icon: icon,
      onChanged: onChanged,
      validator: validator,
      hintText: hintText,
      enabled: enabled,
      height: height,
      itemLabelBuilder: itemLabelBuilder,
      itemBuilder: itemBuilder,
    );
  }
}