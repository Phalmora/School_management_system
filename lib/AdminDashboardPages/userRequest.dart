import 'package:flutter/material.dart';

import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/customWidgets/appBar.dart';

class UserRequestsPage extends StatefulWidget {
  const UserRequestsPage({Key? key}) : super(key: key);

  @override
  State<UserRequestsPage> createState() => _UserRequestsPageState();
}

class _UserRequestsPageState extends State<UserRequestsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  List<UserRequest> userRequests = [
    UserRequest(
      id: '1',
      email: 'simrdeep@example.com',
      approvalStatus: 'Approval Application is Pending',
      requestedRole: 'Academic Officer',
    ),
    UserRequest(
      id: '2',
      email: 'john.doe@example.com',
      approvalStatus: 'Approved',
      requestedRole: 'Teacher',
    ),
    UserRequest(
      id: '3',
      email: 'jane.smith@example.com',
      approvalStatus: 'Declined',
      requestedRole: 'Student',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.slideAnimationDuration,
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'declined':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(AppTheme.defaultSpacing),
                child: Text(
                  'USER REQUESTS',
                  style: AppTheme.FontStyle.copyWith(fontSize: 24),
                ),
              ),
              // Content with side padding to show background
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: AppTheme.smallSpacing,
                    left: AppTheme.mediumSpacing,
                    right: AppTheme.mediumSpacing,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.extraLargeSpacing),
                      topRight: Radius.circular(AppTheme.extraLargeSpacing),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
                        itemCount: userRequests.length,
                        itemBuilder: (context, index) {
                          return _buildUserRequestCard(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserRequestCard(int index) {
    final request = userRequests[index];
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: AppTheme.cardElevation,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Request Info
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email: ${request.email}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Requested role: ${request.requestedRole}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.blue600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.smallSpacing),

            // Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(request.approvalStatus).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getStatusColor(request.approvalStatus),
                  width: 1,
                ),
              ),
              child: Text(
                request.approvalStatus,
                style: TextStyle(
                  color: _getStatusColor(request.approvalStatus),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: AppTheme.mediumSpacing),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        userRequests[index].approvalStatus = 'Approved';
                      });
                      _showSuccessSnackBar('Request approved successfully');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: AppTheme.white,
                      elevation: AppTheme.buttonElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                      ),
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text('Approve',style: TextStyle(fontSize: 13),),
                  ),
                ),
                const SizedBox(width: AppTheme.smallSpacing),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showModifyDialog(index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.blue600,
                      foregroundColor: AppTheme.white,
                      elevation: AppTheme.buttonElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                      ),
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text('Modify',style: TextStyle(fontSize: 13),),
                  ),
                ),
                const SizedBox(width: AppTheme.smallSpacing),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        userRequests[index].approvalStatus = 'Declined';
                      });
                      _showErrorSnackBar('Request declined');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: AppTheme.white,
                      elevation: AppTheme.buttonElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                      ),
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text('Decline',style: TextStyle(fontSize: 13),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showModifyDialog(int index) {
    final TextEditingController roleController = TextEditingController();
    roleController.text = userRequests[index].requestedRole;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          child: Container(
            padding: const EdgeInsets.all(AppTheme.defaultSpacing),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Modify Request',
                  style: AppTheme.FontStyle.copyWith(fontSize: 20),
                ),
                const SizedBox(height: AppTheme.defaultSpacing),
                TextField(
                  controller: roleController,
                  style: const TextStyle(color: AppTheme.white),
                  decoration: InputDecoration(
                    labelText: 'Requested Role',
                    labelStyle: const TextStyle(color: AppTheme.white70),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                      borderSide: const BorderSide(color: AppTheme.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                      borderSide: const BorderSide(color: AppTheme.white, width: AppTheme.focusedBorderWidth),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.defaultSpacing),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white.withOpacity(0.2),
                          foregroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                          ),
                          side: const BorderSide(color: AppTheme.white70),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: AppTheme.smallSpacing),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (roleController.text.trim().isNotEmpty) {
                            setState(() {
                              userRequests[index].requestedRole = roleController.text.trim();
                              userRequests[index].approvalStatus = 'Approved';
                            });
                            Navigator.pop(context);
                            _showSuccessSnackBar('Request modified and approved successfully');
                          } else {
                            _showErrorSnackBar('Please enter a valid role');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          foregroundColor: AppTheme.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                          ),
                        ),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        margin: const EdgeInsets.all(AppTheme.defaultSpacing),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        margin: const EdgeInsets.all(AppTheme.defaultSpacing),
      ),
    );
  }
}

class UserRequest {
  String id;
  String email;
  String approvalStatus;
  String requestedRole;

  UserRequest({
    required this.id,
    required this.email,
    required this.approvalStatus,
    required this.requestedRole,
  });
}