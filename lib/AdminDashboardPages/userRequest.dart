import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart' as AppTheme;
import 'package:school/model/userRequestModel.dart';

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
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: AppTheme.AppTheme.slideAnimationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

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
        decoration: const BoxDecoration(gradient: AppTheme.AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              _buildContentArea(context),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: AppTheme.AppTheme.getScreenPadding(context),
      child: Text(
        'USER REQUESTS',
        style: AppTheme.AppTheme.getFontStyle(context),
      ),
    );
  }

  Widget _buildContentArea(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(maxWidth: AppTheme.AppTheme.getMaxWidth(context)),
        margin: EdgeInsets.only(
          top: AppTheme.AppTheme.getSmallSpacing(context),
          left: AppTheme.AppTheme.getMediumSpacing(context),
          right: AppTheme.AppTheme.getMediumSpacing(context),
          bottom: AppTheme.AppTheme.getMediumSpacing(context), // Added bottom margin
        ),
        decoration: BoxDecoration(
          color: AppTheme.AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.AppTheme.getExtraLargeSpacing(context)), // Full border radius
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: _buildRequestsList(context),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestsList(BuildContext context) {
    return ListView.builder(
      padding: AppTheme.AppTheme.getScreenPadding(context),
      itemCount: userRequests.length,
      itemBuilder: (context, index) => _buildUserRequestCard(context, index),
    );
  }

  Widget _buildUserRequestCard(BuildContext context, int index) {
    final request = userRequests[index];

    return Container(
      margin: AppTheme.AppTheme.getHistoryCardMargin(context),
      decoration: BoxDecoration(
        color: AppTheme.AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.AppTheme.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: AppTheme.AppTheme.getCardElevation(context),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: AppTheme.AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRequestInfo(context, index, request),
            SizedBox(height: AppTheme.AppTheme.getSmallSpacing(context)),
            _buildStatusBadge(context, request),
            SizedBox(height: AppTheme.AppTheme.getMediumSpacing(context)),
            _buildActionButtons(context, index),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestInfo(BuildContext context, int index, UserRequest request) {
    return Row(
      children: [
        _buildRequestNumber(context, index),
        SizedBox(width: AppTheme.AppTheme.getMediumSpacing(context)),
        Expanded(child: _buildRequestDetails(context, request)),
      ],
    );
  }

  Widget _buildRequestNumber(BuildContext context, int index) {
    final iconSize = AppTheme.AppTheme.getIconSize(context);

    return Container(
      width: iconSize * 1.5,
      height: iconSize * 1.5,
      decoration: BoxDecoration(
        gradient: AppTheme.AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(iconSize * 0.75),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppTheme.AppTheme.getButtonTextStyle(context).copyWith(
            fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize,
          ),
        ),
      ),
    );
  }

  Widget _buildRequestDetails(BuildContext context, UserRequest request) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email: ${request.email}',
          style: AppTheme.AppTheme.getHeadingStyle(context),
        ),
        SizedBox(height: AppTheme.AppTheme.getSmallSpacing(context) * 0.4),
        Text(
          'Requested role: ${request.requestedRole}',
          style: AppTheme.AppTheme.getSubHeadingStyle(context).copyWith(
            color: AppTheme.AppTheme.blue600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, UserRequest request) {
    return Container(
      padding: AppTheme.AppTheme.getStatusBadgePadding(context),
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
          fontSize: AppTheme.AppTheme.getStatusBadgeFontSize(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, int index) {
    if (AppTheme.AppTheme.isMobile(context)) {
      return _buildMobileActionButtons(context, index);
    }
    return _buildDesktopActionButtons(context, index);
  }

  Widget _buildMobileActionButtons(BuildContext context, int index) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildApproveButton(context, index)),
            SizedBox(width: AppTheme.AppTheme.getSmallSpacing(context)),
            Expanded(child: _buildModifyButton(context, index)),
          ],
        ),
        SizedBox(height: AppTheme.AppTheme.getSmallSpacing(context)),
        SizedBox(
          width: double.infinity,
          child: _buildDeclineButton(context, index),
        ),
      ],
    );
  }

  Widget _buildDesktopActionButtons(BuildContext context, int index) {
    return Row(
      children: [
        Expanded(child: _buildApproveButton(context, index)),
        SizedBox(width: AppTheme.AppTheme.getSmallSpacing(context)),
        Expanded(child: _buildModifyButton(context, index)),
        SizedBox(width: AppTheme.AppTheme.getSmallSpacing(context)),
        Expanded(child: _buildDeclineButton(context, index)),
      ],
    );
  }

  Widget _buildApproveButton(BuildContext context, int index) {
    return ElevatedButton(
      onPressed: () => _handleApprove(index),
      style: _getButtonStyle(context, Colors.green),
      child: Text(
        'Approve',
        style: TextStyle(fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize),
      ),
    );
  }

  Widget _buildModifyButton(BuildContext context, int index) {
    return ElevatedButton(
      onPressed: () => _showModifyDialog(index),
      style: _getButtonStyle(context, AppTheme.AppTheme.blue600),
      child: Text(
        'Modify',
        style: TextStyle(fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize),
      ),
    );
  }

  Widget _buildDeclineButton(BuildContext context, int index) {
    return ElevatedButton(
      onPressed: () => _handleDecline(index),
      style: _getButtonStyle(context, Colors.red),
      child: Text(
        'Decline',
        style: TextStyle(fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize),
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context, Color backgroundColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: AppTheme.AppTheme.white,
      elevation: AppTheme.AppTheme.getButtonElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.AppTheme.getButtonBorderRadius(context)),
      ),
      minimumSize: Size(double.infinity, AppTheme.AppTheme.getButtonHeight(context) * 0.8),
    );
  }

  void _handleApprove(int index) {
    setState(() {
      userRequests[index].approvalStatus = 'Approved';
    });
    _showSuccessSnackBar('Request approved successfully');
  }

  void _handleDecline(int index) {
    setState(() {
      userRequests[index].approvalStatus = 'Declined';
    });
    _showErrorSnackBar('Request declined');
  }

  void _showModifyDialog(int index) {
    final roleController = TextEditingController(text: userRequests[index].requestedRole);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.AppTheme.getCardBorderRadius(context)),
        ),
        child: Container(
          width: AppTheme.AppTheme.getDialogWidth(context),
          padding: AppTheme.AppTheme.getScreenPadding(context),
          decoration: BoxDecoration(
            gradient: AppTheme.AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.AppTheme.getCardBorderRadius(context)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogTitle(context),
              SizedBox(height: AppTheme.AppTheme.getDefaultSpacing(context)),
              _buildDialogTextField(context, roleController),
              SizedBox(height: AppTheme.AppTheme.getDefaultSpacing(context)),
              _buildDialogActions(context, index, roleController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Text(
      'Modify Request',
      style: AppTheme.AppTheme.getFontStyle(context).copyWith(
        fontSize: AppTheme.AppTheme.getSubHeadingStyle(context).fontSize! * 1.25,
      ),
    );
  }

  Widget _buildDialogTextField(BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: AppTheme.AppTheme.white,
        fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize,
      ),
      decoration: InputDecoration(
        labelText: 'Requested Role',
        labelStyle: TextStyle(
          color: AppTheme.AppTheme.white70,
          fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.AppTheme.getInputBorderRadius(context)),
          borderSide: const BorderSide(color: AppTheme.AppTheme.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.AppTheme.white,
            width: AppTheme.AppTheme.getFocusedBorderWidth(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogActions(BuildContext context, int index, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.AppTheme.white.withOpacity(0.2),
              foregroundColor: AppTheme.AppTheme.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.AppTheme.getButtonBorderRadius(context)),
              ),
              side: const BorderSide(color: AppTheme.AppTheme.white70),
              minimumSize: Size(double.infinity, AppTheme.AppTheme.getButtonHeight(context) * 0.8),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize),
            ),
          ),
        ),
        SizedBox(width: AppTheme.AppTheme.getSmallSpacing(context)),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleModifySave(context, index, controller),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.AppTheme.white,
              foregroundColor: AppTheme.AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.AppTheme.getButtonBorderRadius(context)),
              ),
              minimumSize: Size(double.infinity, AppTheme.AppTheme.getButtonHeight(context) * 0.8),
            ),
            child: Text(
              'Save',
              style: TextStyle(fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize),
            ),
          ),
        ),
      ],
    );
  }

  void _handleModifySave(BuildContext context, int index, TextEditingController controller) {
    final newRole = controller.text.trim();

    if (newRole.isEmpty) {
      _showErrorSnackBar('Please enter a valid role');
      return;
    }

    setState(() {
      userRequests[index].requestedRole = newRole;
      userRequests[index].approvalStatus = 'Approved';
    });

    Navigator.pop(context);
    _showSuccessSnackBar('Request modified and approved successfully');
  }

  void _showSuccessSnackBar(String message) {
    _showSnackBar(message, Colors.green);
  }

  void _showErrorSnackBar(String message) {
    _showSnackBar(message, Colors.red);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: AppTheme.AppTheme.getBodyTextStyle(context).fontSize),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.AppTheme.getInputBorderRadius(context)),
        ),
        margin: AppTheme.AppTheme.getScreenPadding(context),
      ),
    );
  }
}