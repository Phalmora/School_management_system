import 'package:flutter/material.dart';
import 'package:school/CommonLogic/tabBar.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/attendanceModel.dart';
import 'package:school/model/attendanceService.dart';

class AttendancePageTeacher extends StatefulWidget {
  const AttendancePageTeacher({Key? key}) : super(key: key);

  @override
  State<AttendancePageTeacher> createState() => _AttendancePageTeacherState();
}

class _AttendancePageTeacherState extends State<AttendancePageTeacher>
    with SingleTickerProviderStateMixin {
  final AttendanceService _attendanceService = AttendanceService();
  late TabController _tabController;
  AttendanceRecord? _todayAttendance;
  List<AttendanceRecord> _attendanceHistory = [];
  Map<String, int> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final todayAttendance = await _attendanceService.getTodayAttendance();
      final history = await _attendanceService.getAttendanceRecords();
      final stats = _attendanceService.getAttendanceStats();

      setState(() {
        _todayAttendance = todayAttendance;
        _attendanceHistory = history;
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error loading attendance data', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(gradient: AppThemeColor.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: AppThemeResponsiveness.getMaxWidth(context)),
              child: Column(
                children: [
                  _buildHeader(),
                  CustomTabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Mark Attendance'),
                      Tab(text: 'History'),
                    ],
                    getSpacing: AppThemeResponsiveness.getDefaultSpacing,
                    getBorderRadius: AppThemeResponsiveness.getInputBorderRadius,
                    getFontSize: AppThemeResponsiveness.getTabFontSize,
                    backgroundColor: AppThemeColor.blue50,
                    selectedColor: AppThemeColor.primaryBlue,
                    unselectedColor: AppThemeColor.blue600,
                  ),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                        child: CircularProgressIndicator(color: AppThemeColor.white))
                        : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildMarkAttendanceTab(),
                        _buildAttendanceHistoryTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
        horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.how_to_reg,
            color: AppThemeColor.white,
            size: AppThemeResponsiveness.getHeaderIconSize(context),
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
          Flexible(
            child: Text(
              'Attendance',
              style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                fontSize: AppThemeResponsiveness.getResponsiveFontSize(
                    context,
                    AppThemeResponsiveness.getSectionTitleStyle(context).fontSize! + 4
                ),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkAttendanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: AppThemeResponsiveness.getDashboardVerticalPadding(context),
        bottom: AppThemeResponsiveness.getDashboardVerticalPadding(context),
        left: AppThemeResponsiveness.getSmallSpacing(context),
        right: AppThemeResponsiveness.getSmallSpacing(context),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: AppThemeResponsiveness.getMaxWidth(context),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
          ),
          decoration: BoxDecoration(
            color: AppThemeColor.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
            child: Column(
              children: [
                _buildTodayStatusCard(),
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                _buildQuickActions(),
                SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                _buildStatsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayStatusCard() {
    final today = DateTime.now();
    final isMarked = _todayAttendance != null;

    return Container(
      width: double.infinity,
      padding: AppThemeResponsiveness.getCardPadding(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppThemeColor.primaryBlue.withOpacity(0.1),
            AppThemeColor.primaryBlue600.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        border: Border.all(color: AppThemeColor.primaryBlue.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Status',
                      style: AppThemeResponsiveness.getHeadingStyle(context),
                    ),
                    SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                    Text(
                      _getFormattedDate(today),
                      style: AppThemeResponsiveness.getSubHeadingStyle(context),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: AppThemeResponsiveness.getStatusBadgePadding(context),
                  decoration: BoxDecoration(
                    color: _getStatusColor(isMarked ? _todayAttendance!.status : 'not_marked'),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    isMarked ? _todayAttendance!.status.toUpperCase() : 'NOT MARKED',
                    style: TextStyle(
                      color: AppThemeColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          if (isMarked) ...[
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
            Wrap(
              spacing: AppThemeResponsiveness.getSmallSpacing(context),
              runSpacing: AppThemeResponsiveness.getSmallSpacing(context) / 2,
              children: [
                if (_todayAttendance!.checkInTime != null)
                  _buildTimeChip(
                    Icons.login,
                    'Check-in: ${_getFormattedTime(_todayAttendance!.checkInTime!)}',
                    Colors.green[600]!,
                  ),
                if (_todayAttendance!.checkOutTime != null)
                  _buildTimeChip(
                    Icons.logout,
                    'Check-out: ${_getFormattedTime(_todayAttendance!.checkOutTime!)}',
                    Colors.red[600]!,
                  ),
              ],
            ),
            if (_todayAttendance!.reason != null) ...[
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note,
                    color: Colors.orange,
                    size: AppThemeResponsiveness.getIconSize(context) * 0.7,
                  ),
                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                  Expanded(
                    child: Text(
                      'Reason: ${_todayAttendance!.reason}',
                      style: AppThemeResponsiveness.getBodyTextStyle(context),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildTimeChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getSmallSpacing(context),
        vertical: AppThemeResponsiveness.getSmallSpacing(context) / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: AppThemeResponsiveness.getIconSize(context) * 0.7,
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
          Text(
            text,
            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final isMarked = _todayAttendance != null;
    final canCheckOut = isMarked &&
        _todayAttendance!.checkOutTime == null &&
        _todayAttendance!.status != 'absent';

    return Container(
      padding: AppThemeResponsiveness.getCardPadding(context),
      decoration: BoxDecoration(
        color: AppThemeColor.blue50,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(color: Colors.black87),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          if (!isMarked) ...[
            // Use responsive layout for action buttons
            AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context)
                ? _buildMobileActionLayout()
                : _buildTabletActionLayout1(),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                 _buildTabletActionLayout2(),
          ] else ...[
            if (canCheckOut)
              _buildActionButton(
                'Check Out',
                Icons.logout,
                Colors.red[700]!,
                _markCheckOut,
                fullWidth: true,
              )
            else
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
                child: Text(
                  'Attendance already marked for today',
                  textAlign: TextAlign.center,
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(color: Colors.grey[600]),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMobileActionLayout() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _markAttendance('present'),
            icon: Icon(
              Icons.check_circle,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
            ),
            label: Text('Present', style: AppThemeResponsiveness.getButtonTextStyle(context)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              elevation: AppThemeResponsiveness.getButtonElevation(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
              ),
            ),
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _markAttendance('late'),
            icon: Icon(
              Icons.access_time,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
            ),
            label: Text('Late', style: AppThemeResponsiveness.getButtonTextStyle(context)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              elevation: AppThemeResponsiveness.getButtonElevation(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
              ),
            ),
          ),
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _markAttendance('absent'),
            icon: Icon(
              Icons.cancel,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
            ),
            label: Text('Mark Absent', style: AppThemeResponsiveness.getButtonTextStyle(context)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: AppThemeResponsiveness.getButtonElevation(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletActionLayout1() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'Present',
            Icons.check_circle,
            Colors.green,
                () => _markAttendance('present'),
          ),
        ),
        SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
        Expanded(
          child: _buildActionButton(
            'Late',
            Icons.access_time,
            Colors.orange,
                () => _markAttendance('late'),
          ),
        ),
        SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),

      ],
    );
  }

  Widget _buildTabletActionLayout2() {
    return Row(
      children: [

        Expanded(
          child: _buildActionButton(
            'Mark Absent',
            Icons.cancel,
            Colors.red,
                () => _markAttendance('absent'),
          ),
        ),
      ],
    );
  }



  Widget _buildActionButton(
      String label,
      IconData icon,
      Color color,
      VoidCallback onPressed, {
        bool fullWidth = false,
      }) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: AppThemeResponsiveness.getButtonHeight(context),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppThemeColor.white,
          size: AppThemeResponsiveness.getIconSize(context) * 0.8,
        ),
        label: Text(
          label,
          style: AppThemeResponsiveness.getButtonTextStyle(context),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
          ),
          elevation: AppThemeResponsiveness.getButtonElevation(context),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: AppThemeResponsiveness.getCardPadding(context),
      decoration: BoxDecoration(
        color: AppThemeColor.blue50,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Summary',
            style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(color: Colors.black87),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          // Responsive grid for stats
          AppThemeResponsiveness.isMobile(context)
              ? _buildMobileStatsLayout()
              : _buildTabletStatsLayout(),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
            decoration: BoxDecoration(
              gradient: AppThemeColor.primaryGradient,
              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
            ),
            child: Text(
              'Attendance Rate: ${_stats['percentage'] ?? 0}%',
              style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                color: AppThemeColor.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileStatsLayout() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Total', _stats['total'] ?? 0, Icons.calendar_today),
            _buildStatItem('Present', _stats['present'] ?? 0, Icons.check_circle, Colors.green),
          ],
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Absent', _stats['absent'] ?? 0, Icons.cancel, Colors.red),
            _buildStatItem('Late', _stats['late'] ?? 0, Icons.access_time, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletStatsLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('Total', _stats['total'] ?? 0, Icons.calendar_today),
        _buildStatItem('Present', _stats['present'] ?? 0, Icons.check_circle, Colors.green),
        _buildStatItem('Absent', _stats['absent'] ?? 0, Icons.cancel, Colors.red),
        _buildStatItem('Late', _stats['late'] ?? 0, Icons.access_time, Colors.orange),
      ],
    );
  }

  Widget _buildStatItem(String label, int value, IconData icon, [Color? color]) {
    return Flexible(
      child: Column(
        children: [
          Icon(
            icon,
            color: color ?? Colors.grey[600],
            size: AppThemeResponsiveness.getHeaderIconSize(context),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
          Text(
            value.toString(),
            style: AppThemeResponsiveness.getStatValueStyle(context).copyWith(color: color),
          ),
          Text(
            label,
            style: AppThemeResponsiveness.getStatTitleStyle(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceHistoryTab() {
    if (_attendanceHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: AppThemeResponsiveness.getIconSize(context) * 3,
              color: AppThemeColor.white70,
            ),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
            Text(
              'No attendance records found',
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                color: AppThemeColor.white70,
                fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, AppThemeResponsiveness.getBodyTextStyle(context).fontSize! + 2),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
          vertical: AppThemeResponsiveness.getDefaultSpacing(context),
        ),
        itemCount: _attendanceHistory.length,
        itemBuilder: (context, index) {
          final record = _attendanceHistory[index];
          return _buildAttendanceHistoryCard(record);
        },
      ),
    );
  }

  Widget _buildAttendanceHistoryCard(AttendanceRecord record) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: AppThemeResponsiveness.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    _getFormattedDate(record.date),
                    style: AppThemeResponsiveness.getDashboardCardTitleStyle(context),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: AppThemeResponsiveness.getStatusBadgePadding(context),
                    decoration: BoxDecoration(
                      color: _getStatusColor(record.status),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      record.status.toUpperCase(),
                      style: TextStyle(
                        color: AppThemeColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (record.checkInTime != null || record.checkOutTime != null) ...[
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Wrap(
                spacing: AppThemeResponsiveness.getSmallSpacing(context),
                runSpacing: AppThemeResponsiveness.getSmallSpacing(context) / 2,
                children: [
                  if (record.checkInTime != null)
                    _buildHistoryTimeChip(
                      Icons.login,
                      'In: ${_getFormattedTime(record.checkInTime!)}',
                      Colors.green[600]!,
                    ),
                  if (record.checkOutTime != null)
                    _buildHistoryTimeChip(
                      Icons.logout,
                      'Out: ${_getFormattedTime(record.checkOutTime!)}',
                      Colors.red[600]!,
                    ),
                ],
              ),
            ],
            if (record.reason != null) ...[
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note,
                    color: Colors.orange,
                    size: AppThemeResponsiveness.getIconSize(context) * 0.6,
                  ),
                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                  Expanded(
                    child: Text(
                      'Reason: ${record.reason}',
                      style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTimeChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getSmallSpacing(context) * 0.8,
        vertical: AppThemeResponsiveness.getSmallSpacing(context) * 0.4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context) * 0.8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: AppThemeResponsiveness.getIconSize(context) * 0.6,
          ),
          SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) * 0.3),
          Text(
            text,
            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
              color: color,
              fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, AppThemeResponsiveness.getBodyTextStyle(context).fontSize! - 2),
            ),
          ),
        ],
      ),
    );
  }

  void _markAttendance(String status) async {
    String? reason;

    if (status == 'absent' || status == 'late') {
      reason = await _showReasonDialog(status);
      if (reason == null) return; // User cancelled
    }

    final success = await _attendanceService.markAttendance(
      status: status,
      reason: reason,
    );

    if (success) {
      _showSnackBar('Attendance marked successfully!');
      _loadData();
    } else {
      _showSnackBar('Failed to mark attendance', isError: true);
    }
  }

  void _markCheckOut() async {
    final success = await _attendanceService.markCheckOut();

    if (success) {
      _showSnackBar('Checked out successfully!');
      _loadData();
    } else {
      _showSnackBar('Failed to check out', isError: true);
    }
  }

  Future<String?> _showReasonDialog(String status) async {
    String reason = '';
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        title: Text(
          'Reason for ${status == 'absent' ? 'Absence' : 'Being Late'}',
          style: AppThemeResponsiveness.getHeadingStyle(context),
        ),
        content: Container(
          width: AppThemeResponsiveness.isMobile(context)
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            onChanged: (value) => reason = value,
            decoration: InputDecoration(
              hintText: 'Enter reason...',
              hintStyle: AppThemeResponsiveness.getBodyTextStyle(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                borderSide: BorderSide(
                  color: AppThemeColor.primaryBlue,
                  width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                ),
              ),
            ),
            style: AppThemeResponsiveness.getBodyTextStyle(context),
            maxLines: AppThemeResponsiveness.isMobile(context) ? 2 : 3,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, reason.trim()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppThemeColor.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
                vertical: AppThemeResponsiveness.getSmallSpacing(context),
              ),
            ),
            child: Text(
              'Submit',
              style: AppThemeResponsiveness.getButtonTextStyle(context),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getFormattedDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getFormattedTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:${time.minute.toString().padLeft(2, '0')} $period';
  }
}