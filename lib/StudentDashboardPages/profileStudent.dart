import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/dashboardItem.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _staggerController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    _staggerController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(context),
                      vertical: _getVerticalPadding(context),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Top spacing
                        SizedBox(height: _getSpacing(context, 16)),

                        // Enhanced Welcome section with profile info
                        _buildEnhancedWelcomeSection(context),

                        // Spacing
                        SizedBox(height: _getSpacing(context, 24)),

                        // Dashboard grid title
                        _buildSectionTitle(context, 'Profile Management'),

                        SizedBox(height: _getSpacing(context, 16)),
                      ]),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(context),
                    ),
                    sliver: _buildDashboardGrid(context),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: _getSpacing(context, 20),
                    ),
                    sliver: SliverToBoxAdapter(child: Container()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Responsive helper methods
  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 12.0;
    if (width < 400) return 16.0;
    return 20.0;
  }

  double _getVerticalPadding(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (height < 600) return 8.0;
    if (height < 700) return 12.0;
    return 16.0;
  }

  double _getSpacing(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    final scaleFactor = width < 360 ? 0.8 : width < 400 ? 0.9 : 1.0;
    return baseSize * scaleFactor;
  }

  double _getFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    final scaleFactor = width < 360 ? 0.85 : width < 400 ? 0.9 : 1.0;
    return baseSize * scaleFactor;
  }

  Widget _buildEnhancedWelcomeSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * _animationController.value),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(_getSpacing(context, 20)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(_getSpacing(context, 16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: _getSpacing(context, 15),
                  offset: Offset(0, _getSpacing(context, 5)),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: AppThemeColor.primaryBlue.withOpacity(0.1),
                  blurRadius: _getSpacing(context, 10),
                  offset: Offset(0, _getSpacing(context, 2)),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Enhanced Avatar
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient: AppThemeColor.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppThemeColor.primaryBlue.withOpacity(0.3),
                            blurRadius: _getSpacing(context, 8),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: isSmallScreen ? 25 : 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: isSmallScreen ? 30 : 35,
                          color: AppThemeColor.primaryBlue,
                        ),
                      ),
                    ),

                    SizedBox(width: _getSpacing(context, 12)),

                    // Welcome text and info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: _getFontSize(context, 16),
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: _getSpacing(context, 4)),
                          Text(
                            'Student Profile',
                            style: TextStyle(
                              fontSize: _getFontSize(context, 20),
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = AppThemeColor.primaryGradient.createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                                ),
                            ),
                          ),
                          SizedBox(height: _getSpacing(context, 6)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: _getSpacing(context, 8),
                              vertical: _getSpacing(context, 4),
                            ),
                            decoration: BoxDecoration(
                              color: AppThemeColor.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(_getSpacing(context, 8)),
                              border: Border.all(
                                color: AppThemeColor.primaryBlue.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'Class XII - Science',
                              style: TextStyle(
                                fontSize: _getFontSize(context, 12),
                                fontWeight: FontWeight.w600,
                                color: AppThemeColor.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status indicator
                    Container(
                      padding: EdgeInsets.all(_getSpacing(context, 8)),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: _getSpacing(context, 18),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: _getSpacing(context, 16)),

                Text(
                  'Manage your account settings, privacy preferences, and academic information',
                  style: TextStyle(
                    fontSize: _getFontSize(context, 14),
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: AppThemeColor.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: _getSpacing(context, 8)),
        Text(
          title,
          style: TextStyle(
            fontSize: _getFontSize(context, 18),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.dashboard_customize,
          color: Colors.white70,
          size: _getSpacing(context, 20),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 360 ? 2 : 2;
    final childAspectRatio = screenWidth < 360 ? 0.85 : 1.0;

    final items = [
      DashboardItem(
        'View Personal Info',
        Icons.person_outline,
        Colors.purple,
            () => Navigator.pushNamed(context, '/profile-info'),
        'About student'
      ),
      DashboardItem(
        'Privacy & Security',
        Icons.security_outlined,
        Colors.blue,
            () => Navigator.pushNamed(context, '/privacy-security'),
        ''
      ),
      DashboardItem(
        'Performance Summary',
        Icons.show_chart,
        Colors.teal,
            () => Navigator.pushNamed(context, '/privacy-security'),
          ''
      ),
      DashboardItem(
        'Admission Form',
        Icons.school_outlined,
        Colors.red,
            () => Navigator.pushNamed(context, '/admission-main'),
        '',
        badge: 'New',
      ),
      DashboardItem(
        'Upload Documents',
        Icons.upload_file,
        Colors.orange,
            () => Navigator.pushNamed(context, '/admission-main'),
        'Upload the remaining document',
        badge: '1',
      ),
      DashboardItem(
        'Change Password',
        Icons.lock_outline,
        Colors.green,
            () => Navigator.pushNamed(context, '/change-password'),
        ''
      ),
      DashboardItem(
        'Forgot Password',
        Icons.lock_reset,
        Colors.deepOrange,
            () => Navigator.pushNamed(context, '/forget-password'),
        ''
      ),
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: _getSpacing(context, 12),
        mainAxisSpacing: _getSpacing(context, 12),
        childAspectRatio: childAspectRatio,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return AnimatedBuilder(
            animation: _staggerController,
            builder: (context, child) {
              double animationValue = Curves.easeOutCubic.transform(
                (_staggerController.value - (index * 0.1)).clamp(0.0, 1.0),
              );

              return Transform.translate(
                offset: Offset(0, 30 * (1 - animationValue)),
                child: Opacity(
                  opacity: animationValue,
                  child: _buildEnhancedDashboardCard(items[index], index),
                ),
              );
            },
          );
        },
        childCount: items.length,
      ),
    );
  }

  Widget _buildEnhancedDashboardCard(DashboardItem item, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_getSpacing(context, 16)),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            item.onTap();
          },
          borderRadius: BorderRadius.circular(_getSpacing(context, 16)),
          splashColor: item.color.withOpacity(0.1),
          highlightColor: item.color.withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.all(_getSpacing(context, 12)),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Enhanced icon container
                    Container(
                      padding: EdgeInsets.all(_getSpacing(context, 12)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            item.color.withOpacity(0.15),
                            item.color.withOpacity(0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(_getSpacing(context, 16)),
                        border: Border.all(
                          color: item.color.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: item.color.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        item.icon,
                        size: isSmallScreen ? 28 : 32,
                        color: item.color,
                      ),
                    ),

                    SizedBox(height: _getSpacing(context, 8)),

                    // Title text
                    Flexible(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: _getFontSize(context, isSmallScreen ? 14 : 15),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: _getSpacing(context, 4)),


                    const Spacer(),

                    // Enhanced arrow indicator
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: _getSpacing(context, 10),
                        color: item.color,
                      ),
                    ),
                  ],
                ),

                // Enhanced badge
                if (item.badge != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: _getSpacing(context, 6),
                        vertical: _getSpacing(context, 2),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade400, Colors.red.shade600],
                        ),
                        borderRadius: BorderRadius.circular(_getSpacing(context, 8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        item.badge!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _getFontSize(context, 10),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
