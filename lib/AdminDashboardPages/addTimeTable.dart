import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'dart:io';

enum TimeTableType { teacher, student }

class TimeTableOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;
  final TimeTableType type;
  final String stats;

  TimeTableOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.type,
    required this.stats,
  });
}

class AddTimeTableScreen extends StatefulWidget {
  @override
  _AddTimeTableScreenState createState() => _AddTimeTableScreenState();
}

class _AddTimeTableScreenState extends State<AddTimeTableScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _cardAnimations;

  final List<TimeTableOption> _timeTableOptions = [
    TimeTableOption(
      icon: Icons.person_outline,
      title: 'Teacher Timetable',
      subtitle: 'Create and manage\nteacher schedules',
      primaryColor: Color(0xFF667EEA),
      secondaryColor: Color(0xFF764BA2),
      type: TimeTableType.teacher,
      stats: '15 Teachers',
    ),
    TimeTableOption(
      icon: Icons.school_outlined,
      title: 'Student Timetable',
      subtitle: 'Create and manage\nstudent schedules',
      primaryColor: Color(0xFF11998E),
      secondaryColor: Color(0xFF38EF7D),
      type: TimeTableType.student,
      stats: '24 Classes',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.2, 0.8, curve: Curves.easeOutBack),
    ));

    _cardAnimations = List.generate(
      _timeTableOptions.length,
          (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _cardAnimationController,
          curve: Interval(
            0.1 * index,
            0.4 + (0.1 * index),
            curve: Curves.easeOutBack,
          ),
        ),
      ),
    );

    _animationController.forward();
    _cardAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
                    vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
                  ),
                  child: _buildEnhancedHeader(context),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      topRight: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: AppThemeResponsiveness.getCardElevation(context),
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildEnhancedContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 1.2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.schedule_outlined,
                color: Colors.white,
                size: AppThemeResponsiveness.getHeaderIconSize(context),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getDefaultSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Time Table Management',
                      style: AppThemeResponsiveness.getWelcomeNameTextStyle(context).copyWith(
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.5),
                  Text(
                    'Create and manage schedules efficiently',
                    style: AppThemeResponsiveness.getWelcomeBackTextStyle(context).copyWith(
                      color: Colors.white.withOpacity(0.85),
                      letterSpacing: 0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
      ],
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: AppThemeResponsiveness.getIconSize(context) * 0.9,
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.5),
        Text(
          number,
          style: AppThemeResponsiveness.getStatValueStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.3),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppThemeResponsiveness.getStatTitleStyle(context).copyWith(
            color: Colors.white.withOpacity(0.8),
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildEnhancedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Create Timetables',
                  style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppThemeResponsiveness.getSmallSpacing(context) * 1.2,
                  vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                ),
                child: Text(
                  '${_timeTableOptions.length} Options',
                  style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667EEA),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
            ),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppThemeResponsiveness.getDashboardGridCrossAxisCount(context),
                crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
                mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
                childAspectRatio: AppThemeResponsiveness.isTablet(context) ? 1.1 : 0.9,
              ),
              itemCount: _timeTableOptions.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _cardAnimations[index],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _cardAnimations[index].value,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          30 * (1 - _cardAnimations[index].value),
                        ),
                        child: Opacity(
                          opacity: _cardAnimations[index].value,
                          child: _buildEnhancedOptionCard(_timeTableOptions[index], context),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
      ],
    );
  }

  Widget _buildEnhancedOptionCard(TimeTableOption option, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: AppThemeResponsiveness.getCardElevation(context),
            offset: Offset(0, AppThemeResponsiveness.getCardElevation(context) * 0.5),
          ),
          BoxShadow(
            color: option.primaryColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: AppThemeResponsiveness.getCardElevation(context) * 0.6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          onTap: () => _navigateToTimeTableForm(option.type),
          child: Padding(
            padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [option.primaryColor, option.secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                    boxShadow: [
                      BoxShadow(
                        color: option.primaryColor.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: AppThemeResponsiveness.getCardElevation(context) * 0.8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    option.icon,
                    size: AppThemeResponsiveness.getDashboardCardIconSize(context),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 1.2),
                Text(
                  option.title,
                  style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.5),
                Expanded(
                  child: Text(
                    option.subtitle,
                    style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).copyWith(
                      height: 1.3,
                      letterSpacing: 0.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                          vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: option.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) * 0.8),
                        ),
                        child: Text(
                          option.stats,
                          style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                            fontWeight: FontWeight.w600,
                            color: option.primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 0.6),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7FAFC),
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) * 0.6),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: AppThemeResponsiveness.getCaptionTextStyle(context).fontSize,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToTimeTableForm(TimeTableType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimeTableFormScreen(type: type),
      ),
    );
  }
}

class TimeTableFormScreen extends StatefulWidget {
  final TimeTableType type;

  const TimeTableFormScreen({Key? key, required this.type}) : super(key: key);

  @override
  _TimeTableFormScreenState createState() => _TimeTableFormScreenState();
}

class _TimeTableFormScreenState extends State<TimeTableFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedTeacher;
  String? _selectedClass;
  String? _selectedSubject;

  List<File> _attachedFiles = [];

  final List<String> _teachers = ['John Doe', 'Jane Smith', 'Bob Johnson', 'Alice Brown'];
  final List<String> _classes = ['Class 1A', 'Class 1B', 'Class 2A', 'Class 2B'];
  final List<String> _subjects = ['Mathematics', 'English', 'Science', 'History'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      topRight: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: AppThemeResponsiveness.getCardElevation(context),
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: _buildForm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
        vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 1.2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              widget.type == TimeTableType.teacher ? Icons.person_outline : Icons.school_outlined,
              color: Colors.white,
              size: AppThemeResponsiveness.getHeaderIconSize(context),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getDefaultSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.type == TimeTableType.teacher ? 'Teacher Timetable' : 'Student Timetable',
                    style: AppThemeResponsiveness.getWelcomeNameTextStyle(context).copyWith(
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.5),
                Text(
                  'Create and customize schedule',
                  style: AppThemeResponsiveness.getWelcomeBackTextStyle(context).copyWith(
                    color: Colors.white.withOpacity(0.85),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardHorizontalPadding(context)),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

          _buildFormField(
            label: 'Timetable Title',
            child: TextFormField(
              controller: _titleController,
              decoration: _getInputDecoration('Enter timetable title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
          ),

          if (widget.type == TimeTableType.teacher) ...[
            _buildFormField(
              label: 'Select Teacher',
              child: DropdownButtonFormField<String>(
                value: _selectedTeacher,
                decoration: _getInputDecoration('Choose teacher'),
                items: _teachers.map((teacher) {
                  return DropdownMenuItem(
                    value: teacher,
                    child: Text(teacher),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTeacher = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a teacher';
                  }
                  return null;
                },
              ),
            ),

            _buildFormField(
              label: 'Select Subject',
              child: DropdownButtonFormField<String>(
                value: _selectedSubject,
                decoration: _getInputDecoration('Choose subject'),
                items: _subjects.map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a subject';
                  }
                  return null;
                },
              ),
            ),
          ] else ...[
            _buildFormField(
              label: 'Select Class',
              child: DropdownButtonFormField<String>(
                value: _selectedClass,
                decoration: _getInputDecoration('Choose class'),
                items: _classes.map((className) {
                  return DropdownMenuItem(
                    value: className,
                    child: Text(className),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClass = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a class';
                  }
                  return null;
                },
              ),
            ),
          ],

          _buildFormField(
            label: 'Description',
            child: TextFormField(
              controller: _descriptionController,
              decoration: _getInputDecoration('Enter description (optional)'),
              maxLines: 3,
            ),
          ),

          _buildFormField(
            label: 'Attachments',
            child: _buildAttachmentSection(),
          ),

          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context) * 2),

          _buildActionButtons(context),

          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
        ],
      ),
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getDefaultSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
              fontSize: AppThemeResponsiveness.getSectionTitleStyle(context).fontSize! * 0.9,
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          child,
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        borderSide: BorderSide(color: Color(0xFF667EEA), width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
        vertical: AppThemeResponsiveness.getSmallSpacing(context) * 1.5,
      ),
    );
  }

  Widget _buildAttachmentSection() {
    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        border: Border.all(color: Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file_outlined,
                color: Color(0xFF667EEA),
                size: AppThemeResponsiveness.getIconSize(context),
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Attach Files (PNG, PDF, JPG)',
                style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF667EEA),
                ),
              ),
            ],
          ),

          if (_attachedFiles.isNotEmpty) ...[
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            ...(_attachedFiles.map((file) => _buildAttachedFileItem(file)).toList()),
          ],

          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

          InkWell(
            onTap: _pickFiles,
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AppThemeResponsiveness.getDefaultSpacing(context),
                horizontal: AppThemeResponsiveness.getSmallSpacing(context),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF667EEA).withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                color: Color(0xFF667EEA).withOpacity(0.05),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: Color(0xFF667EEA),
                    size: AppThemeResponsiveness.getHeaderIconSize(context),
                  ),
                  SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                  Text(
                    'Tap to browse files',
                    style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                      color: Color(0xFF667EEA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.5),
                  Text(
                    'Supported formats: PNG, PDF, JPG',
                    style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                      color: Color(0xFF718096),
                      fontSize: AppThemeResponsiveness.getCaptionTextStyle(context).fontSize! * 0.9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachedFileItem(File file) {
    String fileName = file.path.split('/').last;
    String fileExtension = fileName.split('.').last.toLowerCase();

    IconData fileIcon;
    Color fileColor;

    switch (fileExtension) {
      case 'pdf':
        fileIcon = Icons.picture_as_pdf_outlined;
        fileColor = Color(0xFFDC2626);
        break;
      case 'png':
      case 'jpg':
      case 'jpeg':
        fileIcon = Icons.image_outlined;
        fileColor = Color(0xFF059669);
        break;
      default:
        fileIcon = Icons.insert_drive_file_outlined;
        fileColor = Color(0xFF6B7280);
    }

    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getSmallSpacing(context)),
      padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) * 0.8),
        border: Border.all(color: Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 0.8),
            decoration: BoxDecoration(
              color: fileColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) * 0.6),
            ),
            child: Icon(
              fileIcon,
              color: fileColor,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) * 0.3),
                Text(
                  '${(file.lengthSync() / 1024).toStringAsFixed(1)} KB',
                  style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                    color: Color(0xFF718096),
                    fontSize: AppThemeResponsiveness.getCaptionTextStyle(context).fontSize! * 0.9,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _removeFile(file),
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) * 0.6),
            child: Container(
              padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context) * 0.6),
              child: Icon(
                Icons.close,
                color: Color(0xFF718096),
                size: AppThemeResponsiveness.getIconSize(context) * 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: AppThemeResponsiveness.getDefaultSpacing(context),
              ),
              side: BorderSide(
                color: Color(0xFF667EEA),
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
            ),
            child: Text(
              'Cancel',
              style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                color: Color(0xFF667EEA),
              ),
            ),
          ),
        ),
        SizedBox(width: AppThemeResponsiveness.getDefaultSpacing(context)),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveTimeTable,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF667EEA),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: AppThemeResponsiveness.getDefaultSpacing(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
              elevation: 0,
            ),
            child: Text(
              'Save Timetable',
              style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _attachedFiles.addAll(
            result.paths.map((path) => File(path!)).toList(),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking files: $e'),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
    }
  }

  void _removeFile(File file) {
    setState(() {
      _attachedFiles.remove(file);
    });
  }

  void _saveTimeTable() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save the timetable data to your backend
      // For now, we'll just show a success message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text('Timetable saved successfully!'),
            ],
          ),
          backgroundColor: Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
        ),
      );

      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }
}