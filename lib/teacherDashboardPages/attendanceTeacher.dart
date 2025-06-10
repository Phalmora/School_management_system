import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:flutter/services.dart';

// attendance_models.dart
class AttendanceRecord {
  final String id;
  final DateTime date;
  final String status; // 'present', 'absent', 'late'
  final String? reason;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String studentId;
  final String studentName;

  AttendanceRecord({
    required this.id,
    required this.date,
    required this.status,
    this.reason,
    this.checkInTime,
    this.checkOutTime,
    required this.studentId,
    required this.studentName,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      reason: json['reason'],
      checkInTime: json['checkInTime'] != null
          ? DateTime.parse(json['checkInTime'])
          : null,
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'])
          : null,
      studentId: json['studentId'],
      studentName: json['studentName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status,
      'reason': reason,
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'studentId': studentId,
      'studentName': studentName,
    };
  }
}



class AttendanceService {
  static final AttendanceService _instance = AttendanceService._internal();
  factory AttendanceService() => _instance;
  AttendanceService._internal();

  List<AttendanceRecord> _attendanceRecords = [];

  // Initialize with sample data
  void initializeSampleData() {
    final now = DateTime.now();
    _attendanceRecords = [
      AttendanceRecord(
        id: '1',
        date: now.subtract(const Duration(days: 1)),
        status: 'present',
        checkInTime: DateTime(now.year, now.month, now.day - 1, 8, 30),
        checkOutTime: DateTime(now.year, now.month, now.day - 1, 15, 30),
        studentId: 'STD001',
        studentName: 'Current Student',
      ),
      AttendanceRecord(
        id: '2',
        date: now.subtract(const Duration(days: 2)),
        status: 'present',
        checkInTime: DateTime(now.year, now.month, now.day - 2, 8, 45),
        checkOutTime: DateTime(now.year, now.month, now.day - 2, 15, 30),
        studentId: 'STD001',
        studentName: 'Current Student',
      ),
      AttendanceRecord(
        id: '3',
        date: now.subtract(const Duration(days: 3)),
        status: 'late',
        reason: 'Traffic jam',
        checkInTime: DateTime(now.year, now.month, now.day - 3, 9, 15),
        checkOutTime: DateTime(now.year, now.month, now.day - 3, 15, 30),
        studentId: 'STD001',
        studentName: 'Current Student',
      ),
      AttendanceRecord(
        id: '4',
        date: now.subtract(const Duration(days: 4)),
        status: 'absent',
        reason: 'Sick leave',
        studentId: 'STD001',
        studentName: 'Current Student',
      ),
    ];
  }

  Future<List<AttendanceRecord>> getAttendanceRecords() async {
    if (_attendanceRecords.isEmpty) {
      initializeSampleData();
    }
    return _attendanceRecords;
  }

  Future<AttendanceRecord?> getTodayAttendance() async {
    final today = DateTime.now();
    final todayRecords = _attendanceRecords.where((record) =>
    record.date.year == today.year &&
        record.date.month == today.month &&
        record.date.day == today.day);

    return todayRecords.isNotEmpty ? todayRecords.first : null;
  }

  Future<bool> markAttendance({
    required String status,
    String? reason,
  }) async {
    try {
      final today = DateTime.now();
      final existingRecord = await getTodayAttendance();

      if (existingRecord != null) {
        // Update existing record
        _attendanceRecords.removeWhere((record) => record.id == existingRecord.id);
      }

      final newRecord = AttendanceRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: today,
        status: status,
        reason: reason,
        checkInTime: status != 'absent' ? today : null,
        studentId: 'STD001',
        studentName: 'Current Student',
      );

      _attendanceRecords.insert(0, newRecord);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> markCheckOut() async {
    try {
      final todayRecord = await getTodayAttendance();
      if (todayRecord != null && todayRecord.checkOutTime == null) {
        final updatedRecord = AttendanceRecord(
          id: todayRecord.id,
          date: todayRecord.date,
          status: todayRecord.status,
          reason: todayRecord.reason,
          checkInTime: todayRecord.checkInTime,
          checkOutTime: DateTime.now(),
          studentId: todayRecord.studentId,
          studentName: todayRecord.studentName,
        );

        _attendanceRecords.removeWhere((record) => record.id == todayRecord.id);
        _attendanceRecords.insert(0, updatedRecord);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Map<String, int> getAttendanceStats() {
    final total = _attendanceRecords.length;
    final present = _attendanceRecords.where((r) => r.status == 'present').length;
    final absent = _attendanceRecords.where((r) => r.status == 'absent').length;
    final late = _attendanceRecords.where((r) => r.status == 'late').length;

    return {
      'total': total,
      'present': present,
      'absent': absent,
      'late': late,
      'percentage': total > 0 ? ((present + late) * 100 / total).round() : 0,
    };
  }
}

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
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          const SizedBox(width: AppTheme.smallSpacing),
          const Icon(Icons.how_to_reg, color: AppTheme.white, size: 30),
          const SizedBox(width: AppTheme.smallSpacing),
          const Text('Attendance', style: AppTheme.FontStyle),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        labelColor: AppTheme.primaryBlue,
        unselectedLabelColor: AppTheme.white,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'Mark Attendance'),
          Tab(text: 'History'),
        ],
      ),
    );
  }

  Widget _buildMarkAttendanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Column(
        children: [
          _buildTodayStatusCard(),
          const SizedBox(height: AppTheme.defaultSpacing),
          _buildQuickActions(),
          const SizedBox(height: AppTheme.defaultSpacing),
          _buildStatsCard(),
        ],
      ),
    );
  }

  Widget _buildTodayStatusCard() {
    final today = DateTime.now();
    final isMarked = _todayAttendance != null;

    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      '${_getFormattedDate(today)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(isMarked ? _todayAttendance!.status : 'not_marked'),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isMarked ? _todayAttendance!.status.toUpperCase() : 'NOT MARKED',
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (isMarked) ...[
              const SizedBox(height: AppTheme.mediumSpacing),
              Row(
                children: [
                  if (_todayAttendance!.checkInTime != null) ...[
                    Icon(Icons.login, color: Colors.green[600]),
                    const SizedBox(width: 8),
                    Text('Check-in: ${_getFormattedTime(_todayAttendance!.checkInTime!)}'),
                  ],
                  const Spacer(),
                  if (_todayAttendance!.checkOutTime != null) ...[
                    Icon(Icons.logout, color: Colors.red[600]),
                    const SizedBox(width: 8),
                    Text('Check-out: ${_getFormattedTime(_todayAttendance!.checkOutTime!)}'),
                  ],
                ],
              ),
              if (_todayAttendance!.reason != null) ...[
                const SizedBox(height: AppTheme.smallSpacing),
                Row(
                  children: [
                    const Icon(Icons.note, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Reason: ${_todayAttendance!.reason}')),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final isMarked = _todayAttendance != null;
    final canCheckOut = isMarked &&
        _todayAttendance!.checkOutTime == null &&
        _todayAttendance!.status != 'absent';

    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            if (!isMarked) ...[
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
                  const SizedBox(width: AppTheme.smallSpacing),
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
              const SizedBox(height: AppTheme.smallSpacing),
              _buildActionButton(
                'Mark Absent',
                Icons.cancel,
                Colors.red,
                    () => _markAttendance('absent'),
                fullWidth: true,
              ),
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
                  padding: const EdgeInsets.all(AppTheme.mediumSpacing),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  ),
                  child: Text(
                    'Attendance already marked for today',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
            ],
          ],
        ),
      ),
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
      height: AppTheme.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: AppTheme.white),
        label: Text(label, style: AppTheme.buttonTextStyle.copyWith(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total', _stats['total'] ?? 0, Icons.calendar_today),
                _buildStatItem('Present', _stats['present'] ?? 0, Icons.check_circle, Colors.green),
                _buildStatItem('Absent', _stats['absent'] ?? 0, Icons.cancel, Colors.red),
                _buildStatItem('Late', _stats['late'] ?? 0, Icons.access_time, Colors.orange),
              ],
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.mediumSpacing),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
              ),
              child: Text(
                'Attendance Rate: ${_stats['percentage'] ?? 0}%',
                style: const TextStyle(
                  color: AppTheme.white,
                  fontSize: 16,
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

  Widget _buildStatItem(String label, int value, IconData icon, [Color? color]) {
    return Column(
      children: [
        Icon(icon, color: color ?? Colors.grey[600], size: 30),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.grey[800],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceHistoryTab() {
    if (_attendanceHistory.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: AppTheme.white70),
            SizedBox(height: AppTheme.defaultSpacing),
            Text(
              'No attendance records found',
              style: TextStyle(color: AppTheme.white70, fontSize: 18),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
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
      elevation: AppTheme.cardElevation,
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getFormattedDate(record.date),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(record.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    record.status.toUpperCase(),
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (record.checkInTime != null || record.checkOutTime != null) ...[
              const SizedBox(height: AppTheme.smallSpacing),
              Row(
                children: [
                  if (record.checkInTime != null) ...[
                    Icon(Icons.login, color: Colors.green[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'In: ${_getFormattedTime(record.checkInTime!)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                  if (record.checkInTime != null && record.checkOutTime != null)
                    const SizedBox(width: AppTheme.mediumSpacing),
                  if (record.checkOutTime != null) ...[
                    Icon(Icons.logout, color: Colors.red[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Out: ${_getFormattedTime(record.checkOutTime!)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ],
              ),
            ],
            if (record.reason != null) ...[
              const SizedBox(height: AppTheme.smallSpacing),
              Row(
                children: [
                  const Icon(Icons.note, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Reason: ${record.reason}',
                      style: const TextStyle(fontSize: 14),
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
        title: Text('Reason for ${status == 'absent' ? 'Absence' : 'Being Late'}'),
        content: TextField(
          onChanged: (value) => reason = value,
          decoration: InputDecoration(
            hintText: 'Enter reason...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            ),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, reason.trim()),
            child: const Text('Submit'),
          ),
        ],
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