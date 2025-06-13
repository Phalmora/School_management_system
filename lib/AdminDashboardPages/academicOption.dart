import 'package:flutter/material.dart';
import 'package:school/AcademicManagement/addClass.dart';
import 'package:school/AcademicManagement/addSubject.dart';
import 'package:school/AcademicManagement/houseGroups.dart';
import 'package:school/AcademicManagement/sportsGroups.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AcademicClass {
  final String id;
  final String className;
  final String section;
  final int capacity;
  final String classTeacher;
  final DateTime createdAt;

  AcademicClass({
    required this.id,
    required this.className,
    required this.section,
    required this.capacity,
    required this.classTeacher,
    required this.createdAt,
  });
}

class Subject {
  final String id;
  final String subjectName;
  final String subjectCode;
  final String description;
  final List<String> assignedClasses;
  final DateTime createdAt;

  Subject({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.description,
    required this.assignedClasses,
    required this.createdAt,
  });
}

class SportGroup {
  final String id;
  final String groupName;
  final String sportType;
  final String coach;
  final int maxMembers;
  final List<String> members;
  final DateTime createdAt;

  SportGroup({
    required this.id,
    required this.groupName,
    required this.sportType,
    required this.coach,
    required this.maxMembers,
    required this.members,
    required this.createdAt,
  });
}

class HouseGroup {
  final String id;
  final String houseName;
  final String houseColor;
  final String captain;
  final String viceCaptain;
  final int points;
  final List<String> members;
  final DateTime createdAt;

  HouseGroup({
    required this.id,
    required this.houseName,
    required this.houseColor,
    required this.captain,
    required this.viceCaptain,
    required this.points,
    required this.members,
    required this.createdAt,
  });
}

class AcademicScreen extends StatefulWidget {
  @override
  _AcademicScreenState createState() => _AcademicScreenState();
}

class _AcademicScreenState extends State<AcademicScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _cardAnimations;

  final List<AcademicOption> _academicOptions = [
    AcademicOption(
      icon: Icons.class_outlined,
      title: 'Add Class',
      subtitle: 'Create new classes\nand sections',
      primaryColor: Color(0xFF667EEA),
      secondaryColor: Color(0xFF764BA2),
      route: () => AddClassScreen(),
      stats: '12 Classes',
    ),
    AcademicOption(
      icon: Icons.menu_book_outlined,
      title: 'Add Subject',
      subtitle: 'Create and manage\nsubjects',
      primaryColor: Color(0xFF11998E),
      secondaryColor: Color(0xFF38EF7D),
      route: () => AddSubjectScreen(),
      stats: '24 Subjects',
    ),
    AcademicOption(
      icon: Icons.sports_soccer_outlined,
      title: 'Sport Groups',
      subtitle: 'Create and organize\nsport teams',
      primaryColor: Color(0xFFFC466B),
      secondaryColor: Color(0xFF3F5EFB),
      route: () => AddSportGroupScreen(),
      stats: '8 Teams',
    ),
    AcademicOption(
      icon: Icons.home_work_outlined,
      title: 'House Groups',
      subtitle: 'Manage house\nsystem & points',
      primaryColor: Color(0xFFFFCE00),
      secondaryColor: Color(0xFFFF9500),
      route: () => AddHouseGroupScreen(),
      stats: '4 Houses',
    ),
  ];

  @override
  void initState() {
    super.initState();
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
      _academicOptions.length,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white, // Changed to white for visible padding
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Enhanced Header Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                  child: _buildEnhancedHeader(screenWidth, screenHeight),
                ),
              ),

              // Main Content with improved design and visible white padding
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15), // White padding on sides
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildEnhancedContent(isTablet, screenWidth),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.school_outlined,
                color: Colors.white,
                size: screenWidth * 0.07,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Academic Management',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Streamline your educational administration',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.white.withOpacity(0.85),
                      fontWeight: FontWeight.w400,
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
        SizedBox(height: screenHeight * 0.02),
        // Quick stats row - Made more responsive
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.015,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: _buildStatItem('48', 'Total\nItems', Icons.dashboard_outlined, screenWidth),
                ),
                Container(
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                Flexible(
                  child: _buildStatItem('12', 'Active\nClasses', Icons.class_outlined, screenWidth),
                ),
                Container(
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                Flexible(
                  child: _buildStatItem('4', 'House\nGroups', Icons.home_outlined, screenWidth),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: screenWidth * 0.045),
        SizedBox(height: 4),
        Text(
          number,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.025,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildEnhancedContent(bool isTablet, double screenWidth) {
    final crossAxisCount = isTablet ? 3 : 2;
    final padding = screenWidth * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3748),
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_academicOptions.length} Options',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667EEA),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isTablet ? 1.1 : 0.9,
              ),
              itemCount: _academicOptions.length,
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
                          child: _buildEnhancedOptionCard(_academicOptions[index], screenWidth),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8), // Bottom padding
      ],
    );
  }

  Widget _buildEnhancedOptionCard(AcademicOption option, double screenWidth) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => option.route()),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: option.primaryColor.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => option.route()),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon with gradient background - Responsive
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [option.primaryColor, option.secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: option.primaryColor.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      option.icon,
                      size: screenWidth * 0.06,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: screenWidth * 0.03),

                  // Title and subtitle - Responsive
                  Text(
                    option.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D3748),
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4),

                  Expanded(
                    child: Text(
                      option.subtitle,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Color(0xFF718096),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Stats and arrow - Responsive
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: option.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            option.stats,
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
                              fontWeight: FontWeight.w600,
                              color: option.primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: screenWidth * 0.025,
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
      ),
    );
  }
}

class AcademicOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget Function() route;
  final String stats;

  AcademicOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.route,
    required this.stats,
  });
}