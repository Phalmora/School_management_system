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
    return DropdownButtonFormField<T>(
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
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.grey[600],
        size: AppThemeResponsiveness.getIconSize(context),
      ),
      hint: hintText != null
          ? Text(
        hintText!,
        style: AppThemeResponsiveness.getSubHeadingStyle(context)?.copyWith(
          color: Colors.grey[600],
        ),
      )
          : null,
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppThemeResponsiveness.getSubHeadingStyle(context),
      prefixIcon: Icon(
        icon,
        size: AppThemeResponsiveness.getIconSize(context),
        color: Colors.grey[600],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getInputBorderRadius(context),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getInputBorderRadius(context),
        ),
        borderSide: BorderSide(
          color: AppThemeColor.blue600,
          width: AppThemeResponsiveness.getFocusedBorderWidth(context),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getInputBorderRadius(context),
        ),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getInputBorderRadius(context),
        ),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppThemeResponsiveness.getInputBorderRadius(context),
        ),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDefaultSpacing(context) * 1.5,
        vertical: AppThemeResponsiveness.getSmallSpacing(context) * 2.5,
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

  static AppDropdown<String> houseColor({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customColors,
  }) {
    final defaultColors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange', 'Pink', 'Cyan'];

    return AppDropdown<String>(
      value: value,
      items: customColors ?? defaultColors,
      label: 'House Color *',
      icon: Icons.palette,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select house color' : null,
      itemBuilder: (String color) {
        return Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _getColorFromString(color),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              color,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }

  static Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'cyan':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
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
      '2023-2024',
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

  static AppDropdown<String> section({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customSections,
  }) {
    final defaultSections = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

    return AppDropdown<String>(
      value: value,
      items: customSections ?? defaultSections,
      label: 'Section *',
      icon: Icons.category,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select section' : null,
    );
  }

  static AppDropdown<String> medium({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customMediums,
  }) {
    final defaultMediums = ['English', 'Hindi', 'Regional Language', 'Bilingual'];

    return AppDropdown<String>(
      value: value,
      items: customMediums ?? defaultMediums,
      label: 'Medium of Instruction *',
      icon: Icons.language,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select medium' : null,
    );
  }

  static AppDropdown<String> stream({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customStreams,
  }) {
    final defaultStreams = ['Science', 'Commerce', 'Arts', 'Vocational'];

    return AppDropdown<String>(
      value: value,
      items: customStreams ?? defaultStreams,
      label: 'Stream *',
      icon: Icons.school,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select stream' : null,
    );
  }

  static AppDropdown<String> sportType({
    required String? value,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    List<String>? customSportTypes,
  }) {
    final defaultSportTypes = [
      'Football',
      'Basketball',
      'Cricket',
      'Tennis',
      'Swimming',
      'Athletics',
      'Badminton',
      'Volleyball',
      'Hockey',
      'Table Tennis',
      'Baseball',
      'Rugby',
      'Wrestling',
      'Boxing',
      'Gymnastics',
      'Cycling',
      'Running',
      'Chess',
      'Kabaddi',
      'Kho Kho',
    ];

    return AppDropdown<String>(
      value: value,
      items: customSportTypes ?? defaultSportTypes,
      label: 'Sport Type *',
      icon: Icons.sports,
      onChanged: onChanged,
      validator: validator ?? (value) => value == null ? 'Please select sport type' : null,
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
