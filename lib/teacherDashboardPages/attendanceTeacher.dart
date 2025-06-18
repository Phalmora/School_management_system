import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:flutter/services.dart';
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
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: AppTheme.getMaxWidth(context)),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildTabBar(),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                        child: CircularProgressIndicator(color: AppTheme.white))
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
      padding: AppTheme.getScreenPadding(context),
      child: Row(
        children: [
          SizedBox(width: AppTheme.getSmallSpacing(context)),
          Icon(
            Icons.how_to_reg,
            color: AppTheme.white,
            size: AppTheme.getHeaderIconSize(context),
          ),
          SizedBox(width: AppTheme.getSmallSpacing(context)),
          Flexible(
            child: Text(
              'Attendance',
              style: AppTheme.getFontStyle(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: AppTheme.getHorizontalPadding(context),
      height: AppTheme.getTabBarHeight(context),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        labelColor: AppTheme.primaryBlue,
        unselectedLabelColor: AppTheme.white,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 16 : 18),
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 16 : 18),
        ),
        tabs: const [
          Tab(text: 'Mark Attendance'),
          Tab(text: 'History'),
        ],
      ),
    );
  }

  Widget _buildMarkAttendanceTab() {
    return SingleChildScrollView(
      padding: AppTheme.getScreenPadding(context),
      child: Column(
        children: [
          _buildTodayStatusCard(),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          _buildQuickActions(),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          _buildStatsCard(),
        ],
      ),
    );
  }

  Widget _buildTodayStatusCard() {
    final today = DateTime.now();
    final isMarked = _todayAttendance != null;

    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Container(
        width: double.infinity,
        padding: AppTheme.getCardPadding(context),
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
                        style: AppTheme.getHeadingStyle(context),
                      ),
                      SizedBox(height: AppTheme.getSmallSpacing(context) / 2),
                      Text(
                        _getFormattedDate(today),
                        style: AppTheme.getSubHeadingStyle(context),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: AppTheme.getStatusBadgePadding(context),
                    decoration: BoxDecoration(
                      color: _getStatusColor(isMarked ? _todayAttendance!.status : 'not_marked'),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isMarked ? _todayAttendance!.status.toUpperCase() : 'NOT MARKED',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTheme.isMobile(context) ? 10 : (AppTheme.isTablet(context) ? 12 : 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (isMarked) ...[
              SizedBox(height: AppTheme.getMediumSpacing(context)),
              Wrap(
                spacing: AppTheme.getSmallSpacing(context),
                runSpacing: AppTheme.getSmallSpacing(context) / 2,
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
                SizedBox(height: AppTheme.getSmallSpacing(context)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note,
                      color: Colors.orange,
                      size: AppTheme.getIconSize(context) * 0.7,
                    ),
                    SizedBox(width: AppTheme.getSmallSpacing(context) / 2),
                    Expanded(
                      child: Text(
                        'Reason: ${_todayAttendance!.reason}',
                        style: AppTheme.getBodyTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.getSmallSpacing(context),
        vertical: AppTheme.getSmallSpacing(context) / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: AppTheme.getIconSize(context) * 0.7,
          ),
          SizedBox(width: AppTheme.getSmallSpacing(context) / 2),
          Text(
            text,
            style: AppTheme.getBodyTextStyle(context).copyWith(color: color),
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

    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: AppTheme.getHeadingStyle(context),
            ),
            SizedBox(height: AppTheme.getMediumSpacing(context)),
            if (!isMarked) ...[
              // Use responsive layout for action buttons
              AppTheme.isMobile(context)
                  ? _buildMobileActionLayout()
                  : _buildTabletActionLayout(),
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
                  padding: EdgeInsets.all(AppTheme.getMediumSpacing(context)),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                  ),
                  child: Text(
                    'Attendance already marked for today',
                    textAlign: TextAlign.center,
                    style: AppTheme.getBodyTextStyle(context).copyWith(color: Colors.grey[600]),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileActionLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Present',
                Icons.check_circle,
                Colors.green,
                    () => _markAttendance('present'),
              ),
            ),
            SizedBox(width: AppTheme.getSmallSpacing(context)),
            Expanded(
              child: _buildActionButton(
                'Late',
                Icons.access_time,
                Colors.orange,
                    () => _markAttendance('late'),
              ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.getSmallSpacing(context)),
        _buildActionButton(
          'Mark Absent',
          Icons.cancel,
          Colors.red,
              () => _markAttendance('absent'),
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildTabletActionLayout() {
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
        SizedBox(width: AppTheme.getSmallSpacing(context)),
        Expanded(
          child: _buildActionButton(
            'Late',
            Icons.access_time,
            Colors.orange,
                () => _markAttendance('late'),
          ),
        ),
        SizedBox(width: AppTheme.getSmallSpacing(context)),
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
      height: AppTheme.getButtonHeight(context),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppTheme.white,
          size: AppTheme.getIconSize(context) * 0.8,
        ),
        label: Text(
          label,
          style: AppTheme.getButtonTextStyle(context),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
          ),
          elevation: AppTheme.getButtonElevation(context),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance Summary',
              style: AppTheme.getHeadingStyle(context),
            ),
            SizedBox(height: AppTheme.getMediumSpacing(context)),
            // Responsive grid for stats
            AppTheme.isMobile(context)
                ? _buildMobileStatsLayout()
                : _buildTabletStatsLayout(),
            SizedBox(height: AppTheme.getMediumSpacing(context)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppTheme.getMediumSpacing(context)),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              ),
              child: Text(
                'Attendance Rate: ${_stats['percentage'] ?? 0}%',
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: AppTheme.isMobile(context) ? 14 : (AppTheme.isTablet(context) ? 16 : 18),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
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
        SizedBox(height: AppTheme.getMediumSpacing(context)),
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
            size: AppTheme.getStatIconSize(context),
          ),
          SizedBox(height: AppTheme.getSmallSpacing(context) / 2),
          Text(
            value.toString(),
            style: AppTheme.getStatValueStyle(context).copyWith(color: color),
          ),
          Text(
            label,
            style: AppTheme.getCaptionTextStyle(context),
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
              size: AppTheme.getIconSize(context) * 3,
              color: AppTheme.white70,
            ),
            SizedBox(height: AppTheme.getDefaultSpacing(context)),
            Text(
              'No attendance records found',
              style: TextStyle(
                color: AppTheme.white70,
                fontSize: AppTheme.isMobile(context) ? 16 : (AppTheme.isTablet(context) ? 18 : 20),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: AppTheme.getScreenPadding(context),
        itemCount: _attendanceHistory.length,
        itemBuilder: (context, index) {
          final record = _attendanceHistory[index];
          return _buildAttendanceHistoryCard(record);
        },
      ),
    );
  }

  Widget _buildAttendanceHistoryCard(AttendanceRecord record) {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      margin: EdgeInsets.only(bottom: AppTheme.getMediumSpacing(context)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Padding(
        padding: AppTheme.getCardPadding(context),
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
                    style: AppTheme.getHeadingStyle(context).copyWith(fontSize:
                    AppTheme.isMobile(context) ? 15 : (AppTheme.isTablet(context) ? 16 : 17)),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: AppTheme.getStatusBadgePadding(context),
                    decoration: BoxDecoration(
                      color: _getStatusColor(record.status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      record.status.toUpperCase(),
                      style: TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTheme.isMobile(context) ? 10 : (AppTheme.isTablet(context) ? 12 : 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (record.checkInTime != null || record.checkOutTime != null) ...[
              SizedBox(height: AppTheme.getSmallSpacing(context)),
              Wrap(
                spacing: AppTheme.getSmallSpacing(context),
                runSpacing: AppTheme.getSmallSpacing(context) / 2,
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
              SizedBox(height: AppTheme.getSmallSpacing(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note,
                    color: Colors.orange,
                    size: AppTheme.getIconSize(context) * 0.6,
                  ),
                  SizedBox(width: AppTheme.getSmallSpacing(context) / 2),
                  Expanded(
                    child: Text(
                      'Reason: ${record.reason}',
                      style: AppTheme.getBodyTextStyle(context),
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
        horizontal: AppTheme.getSmallSpacing(context) * 0.8,
        vertical: AppTheme.getSmallSpacing(context) * 0.4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context) * 0.8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: AppTheme.getIconSize(context) * 0.6,
          ),
          SizedBox(width: AppTheme.getSmallSpacing(context) * 0.3),
          Text(
            text,
            style: AppTheme.getBodyTextStyle(context).copyWith(
              color: color,
              fontSize: AppTheme.isMobile(context) ? 12 : (AppTheme.isTablet(context) ? 13 : 14),
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
          borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
        ),
        title: Text(
          'Reason for ${status == 'absent' ? 'Absence' : 'Being Late'}',
          style: AppTheme.getHeadingStyle(context),
        ),
        content: Container(
          width: AppTheme.isMobile(context) ?
          MediaQuery.of(context).size.width * 0.8 :
          MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            onChanged: (value) => reason = value,
            decoration: InputDecoration(
              hintText: 'Enter reason...',
              hintStyle: AppTheme.getBodyTextStyle(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                borderSide: BorderSide(
                  color: AppTheme.primaryBlue,
                  width: AppTheme.getFocusedBorderWidth(context),
                ),
              ),
            ),
            style: AppTheme.getBodyTextStyle(context),
            maxLines: AppTheme.isMobile(context) ? 2 : 3,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTheme.getBodyTextStyle(context).copyWith(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, reason.trim()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.getDefaultSpacing(context),
                vertical: AppTheme.getSmallSpacing(context),
              ),
            ),
            child: Text(
              'Submit',
              style: AppTheme.getButtonTextStyle(context).copyWith(
                fontSize: AppTheme.isMobile(context) ? 14 : 16,
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(AppTheme.getMediumSpacing(context)),
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