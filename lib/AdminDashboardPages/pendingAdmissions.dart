import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

class PendingAdmissionsPage extends StatefulWidget {
  const PendingAdmissionsPage({Key? key}) : super(key: key);

  @override
  State<PendingAdmissionsPage> createState() => _PendingAdmissionsPageState();
}

class _PendingAdmissionsPageState extends State<PendingAdmissionsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLoading = false;
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'New', 'Under Review', 'Pending Documents'];

  // Sample data for pending admissions
  final List<Map<String, dynamic>> _pendingAdmissions = [
    {
      'id': 'ADM001',
      'name': 'John Smith',
      'grade': 'Grade 10',
      'submittedDate': '2024-01-15',
      'status': 'New',
      'parentName': 'Robert Smith',
      'phone': '+91 9876543210',
      'priority': 'High',
    },
    {
      'id': 'ADM002',
      'name': 'Emma Johnson',
      'grade': 'Grade 8',
      'submittedDate': '2024-01-14',
      'status': 'Under Review',
      'parentName': 'Michael Johnson',
      'phone': '+91 9876543211',
      'priority': 'Medium',
    },
    {
      'id': 'ADM003',
      'name': 'Rahul Sharma',
      'grade': 'Grade 12',
      'submittedDate': '2024-01-13',
      'status': 'Pending Documents',
      'parentName': 'Suresh Sharma',
      'phone': '+91 9876543212',
      'priority': 'Low',
    },
    {
      'id': 'ADM004',
      'name': 'Priya Patel',
      'grade': 'Grade 9',
      'submittedDate': '2024-01-12',
      'status': 'New',
      'parentName': 'Amit Patel',
      'phone': '+91 9876543213',
      'priority': 'High',
    },
    {
      'id': 'ADM005',
      'name': 'David Wilson',
      'grade': 'Grade 11',
      'submittedDate': '2024-01-11',
      'status': 'Under Review',
      'parentName': 'James Wilson',
      'phone': '+91 9876543214',
      'priority': 'Medium',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: AppThemeColor.slideAnimationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredAdmissions {
    if (_selectedFilter == 'All') {
      return _pendingAdmissions;
    }
    return _pendingAdmissions
        .where((admission) => admission['status'] == _selectedFilter)
        .toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.green;
      case 'Under Review':
        return Colors.orange;
      case 'Pending Documents':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showActionDialog(Map<String, dynamic> admission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
          ),
          elevation: AppThemeResponsiveness.getCardElevation(context),
          child: Container(
            padding: AppThemeResponsiveness.getResponsivePadding(context, 24.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Actions for ${admission['name']}',
                  style: AppThemeResponsiveness.getDialogTitleStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                _buildActionButton(
                  'Approve Application',
                  Icons.check_circle,
                  Colors.green,
                      () => _performAction('approve', admission),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                _buildActionButton(
                  'Request Documents',
                  Icons.description,
                  Colors.orange,
                      () => _performAction('request_docs', admission),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                _buildActionButton(
                  'Schedule Interview',
                  Icons.calendar_today,
                  Colors.blue,
                      () => _performAction('schedule', admission),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                _buildActionButton(
                  'Reject Application',
                  Icons.cancel,
                  Colors.red,
                      () => _performAction('reject', admission),
                ),
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                    ),
                    padding: AppThemeResponsiveness.getResponsivePadding(context, 12.0),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: AppThemeResponsiveness.getIconSize(context)),
        label: Text(
          title,
          style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
          padding: AppThemeResponsiveness.getResponsivePadding(context, 12.0),
        ),
      ),
    );
  }

  void _performAction(String action, Map<String, dynamic> admission) {
    Navigator.of(context).pop();

    String message = '';
    switch (action) {
      case 'approve':
        message = 'Application approved for ${admission['name']}';
        break;
      case 'request_docs':
        message = 'Document request sent to ${admission['name']}';
        break;
      case 'schedule':
        message = 'Interview scheduled for ${admission['name']}';
        break;
      case 'reject':
        message = 'Application rejected for ${admission['name']}';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildFilterBar(),
              Expanded(
                child: _buildAdmissionsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: AppThemeResponsiveness.getResponsivePadding(context, 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: AppThemeResponsiveness.getResponsivePadding(context, 12.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.pending_actions_rounded,
                color: Colors.white,
                size: AppThemeResponsiveness.getHeaderIconSize(context),
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pending Admissions',
                    style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${_filteredAdmissions.length} applications',
                    style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: AppThemeResponsiveness.getResponsiveSize(context, 14.0, 16.0, 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: AppThemeResponsiveness.getResponsiveSize(context, 60.0, 65.0, 70.0),
        margin: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _filterOptions.length,
          itemBuilder: (context, index) {
            final option = _filterOptions[index];
            final isSelected = _selectedFilter == option;

            return Container(
              margin: EdgeInsets.only(
                right: AppThemeResponsiveness.getSmallSpacing(context),
              ),
              child: FilterChip(
                label: Text(
                  option,
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = option;
                  });
                },
                backgroundColor: Colors.white,
                selectedColor: AppThemeColor.blue600,
                checkmarkColor: Colors.white,
                elevation: isSelected ? 4 : 2,
                shadowColor: Colors.black.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                  side: BorderSide(
                    color: isSelected ? AppThemeColor.blue600 : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAdmissionsList() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
              : _filteredAdmissions.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
            itemCount: _filteredAdmissions.length,
            itemBuilder: (context, index) {
              return _buildAdmissionCard(_filteredAdmissions[index], index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: AppThemeResponsiveness.getResponsivePadding(context, 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: AppThemeResponsiveness.getResponsiveSize(context, 64.0, 72.0, 80.0),
              color: Colors.white.withOpacity(0.7),
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
            Text(
              'No pending admissions',
              style: AppThemeResponsiveness.getHeadingTextStyle(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'All admission applications have been processed',
              textAlign: TextAlign.center,
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionCard(Map<String, dynamic> admission, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppThemeResponsiveness.getCardElevation(context) * 2,
            offset: Offset(0, AppThemeResponsiveness.getSmallSpacing(context)),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          onTap: () => _showActionDialog(admission),
          child: Padding(
            padding: AppThemeResponsiveness.getCardPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  admission['name'],
                                  style: AppThemeResponsiveness.getRecentTitleStyle(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                                  vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(admission['priority']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 12.0)),
                                  border: Border.all(
                                    color: _getPriorityColor(admission['priority']).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  admission['priority'],
                                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                                    color: _getPriorityColor(admission['priority']),
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppThemeResponsiveness.getResponsiveSize(context, 12.0, 13.0, 14.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                          Text(
                            'ID: ${admission['id']} • ${admission['grade']}',
                            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: AppThemeResponsiveness.getIconSize(context),
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                    Expanded(
                      child: Text(
                        admission['parentName'],
                        style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: AppThemeResponsiveness.getIconSize(context),
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                    Expanded(
                      child: Text(
                        admission['phone'],
                        style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                        vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(admission['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getResponsiveRadius(context, 16.0)),
                        border: Border.all(
                          color: _getStatusColor(admission['status']).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        admission['status'],
                        style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                          color: _getStatusColor(admission['status']),
                          fontWeight: FontWeight.w600,
                          fontSize: AppThemeResponsiveness.getResponsiveSize(context, 12.0, 13.0, 14.0),
                        ),
                      ),
                    ),
                    Text(
                      'Submitted: ${admission['submittedDate']}',
                      style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                        color: Colors.grey.shade500,
                        fontSize: AppThemeResponsiveness.getResponsiveSize(context, 12.0, 13.0, 14.0),
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
}