import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school/CommonLogic/tabBar.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/pagesMainHeading.dart';
import 'package:school/model/dashboard/feeManagementStudentDashboard.dart';

class FeeManagementScreenStudent extends StatefulWidget {
  @override
  _FeeManagementScreenStudentState createState() => _FeeManagementScreenStudentState();
}

class _FeeManagementScreenStudentState extends State<FeeManagementScreenStudent>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  // Mock data - replace with actual API calls
  final List<FeeRecord> _feeRecords = [
    FeeRecord(
      id: '001',
      description: 'Tuition Fee - Term 1',
      amount: 15000.0,
      dueDate: DateTime(2024, 4, 15),
      paidDate: DateTime(2024, 4, 10),
      status: 'paid',
      receiptNumber: 'RPS2024001',
      academicYear: '2024-25',
      term: 'Term 1',
    ),
    FeeRecord(
      id: '002',
      description: 'Examination Fee',
      amount: 2500.0,
      dueDate: DateTime(2024, 6, 20),
      paidDate: DateTime(2024, 6, 18),
      status: 'paid',
      receiptNumber: 'RPS2024002',
      academicYear: '2024-25',
      term: 'Term 1',
    ),
    FeeRecord(
      id: '003',
      description: 'Tuition Fee - Term 2',
      amount: 15000.0,
      dueDate: DateTime(2024, 8, 15),
      status: 'pending',
      receiptNumber: '',
      academicYear: '2024-25',
      term: 'Term 2',
    ),
    FeeRecord(
      id: '004',
      description: 'Library Fee',
      amount: 1000.0,
      dueDate: DateTime(2024, 7, 1),
      status: 'overdue',
      receiptNumber: '',
      academicYear: '2024-25',
      term: 'Term 2',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              bottom: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              left: AppThemeResponsiveness.getSmallSpacing(context),
              right: AppThemeResponsiveness.getSmallSpacing(context),
            ),
            child: Column(
              children: [
              HeaderSection(
              title: 'Fee Management',
              icon: Icons.account_balance_wallet,
            ),
                Expanded(
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
                    child: Column(
                      children: [
                        CustomTabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(text: 'History'),
                            Tab(text: 'Status'),
                            Tab(text: 'Downloads'),
                          ],
                          getSpacing: AppThemeResponsiveness.getDefaultSpacing,
                          getBorderRadius: AppThemeResponsiveness.getInputBorderRadius,
                          getFontSize: AppThemeResponsiveness.getTabFontSize,
                          backgroundColor: AppThemeColor.blue50,
                          selectedColor: AppThemeColor.primaryBlue,
                          unselectedColor: AppThemeColor.blue600,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildFeeHistoryTab(context),
                              _buildPaymentStatusTab(context),
                              _buildDownloadsTab(context),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildFeeHistoryTab(BuildContext context) {
    return AppThemeResponsiveness.isDesktop(context) || AppThemeResponsiveness.isTablet(context)
        ? _buildFeeHistoryGrid(context)
        : _buildFeeHistoryList(context);
  }

  Widget _buildFeeHistoryGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppThemeResponsiveness.getGridCrossAxisCount(context),
        crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: AppThemeResponsiveness.getGridChildAspectRatio(context) * 1.2,
      ),
      itemCount: _feeRecords.length,
      itemBuilder: (context, index) {
        final record = _feeRecords[index];
        return _buildFeeGridCard(context, record);
      },
    );
  }

  Widget _buildFeeHistoryList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      itemCount: _feeRecords.length,
      itemBuilder: (context, index) {
        final record = _feeRecords[index];
        return _buildFeeCard(context, record);
      },
    );
  }

  Widget _buildPaymentStatusTab(BuildContext context) {
    final pendingFees = _feeRecords.where((r) => r.status != 'paid').toList();
    final paidFees = _feeRecords.where((r) => r.status == 'paid').toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(context),
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          if (pendingFees.isNotEmpty) ...[
            Text(
              'Pending Payments',
              style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                color: Colors.red[700],
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            ...pendingFees.map((record) => _buildFeeCard(context, record)).toList(),
            SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          ],
          Text(
            'Completed Payments',
            style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
              color: Colors.green[700],
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          ...paidFees.map((record) => _buildFeeCard(context, record)).toList(),
        ],
      ),
    );
  }

  Widget _buildDownloadsTab(BuildContext context) {
    final paidFees = _feeRecords.where((r) => r.status == 'paid').toList();

    return AppThemeResponsiveness.isDesktop(context) || AppThemeResponsiveness.isTablet(context)
        ? _buildDownloadsGrid(context, paidFees)
        : _buildDownloadsList(context, paidFees);
  }

  Widget _buildDownloadsGrid(BuildContext context, List<FeeRecord> paidFees) {
    return GridView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppThemeResponsiveness.getGridCrossAxisCount(context),
        crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: AppThemeResponsiveness.getGridChildAspectRatio(context) * 1.1,
      ),
      itemCount: paidFees.length,
      itemBuilder: (context, index) {
        final record = paidFees[index];
        return _buildDownloadGridCard(context, record);
      },
    );
  }

  Widget _buildDownloadsList(BuildContext context, List<FeeRecord> paidFees) {
    return ListView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      itemCount: paidFees.length,
      itemBuilder: (context, index) {
        final record = paidFees[index];
        return _buildDownloadCard(context, record);
      },
    );
  }

  Widget _buildFeeGridCard(BuildContext context, FeeRecord record) {
    Color statusColor = _getStatusColor(record.status);
    IconData statusIcon = _getStatusIcon(record.status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.all(AppThemeResponsiveness.getGridItemPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    record.description,
                    style: AppThemeResponsiveness.getGridItemTitleStyle(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: statusColor, size: 12),
                      SizedBox(width: 4),
                      Text(
                        record.status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context) - 2,
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
                Icon(Icons.calendar_today,
                    size: AppThemeResponsiveness.getIconSize(context) * 0.6,
                    color: Colors.grey[600]
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Due: ${_formatDate(record.dueDate)}',
                    style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
                  ),
                ),
              ],
            ),
            if (record.paidDate != null) ...[
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.check_circle,
                      size: AppThemeResponsiveness.getIconSize(context) * 0.6,
                      color: Colors.green
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Paid: ${_formatDate(record.paidDate!)}',
                      style: AppThemeResponsiveness.getGridItemSubtitleStyle(context).copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${record.amount.toStringAsFixed(2)}',
                  style: AppThemeResponsiveness.getStatValueStyle(context).copyWith(
                    color: AppThemeColor.primaryBlue,
                  ),
                ),
                if (record.status == 'pending' || record.status == 'overdue')
                  ElevatedButton(
                    onPressed: () => _showPaymentDialog(record),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemeColor.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                        vertical: 4,
                      ),
                    ),
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                      ),
                    ),
                  ),
              ],
            ),
            if (record.receiptNumber.isNotEmpty) ...[
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Receipt: ${record.receiptNumber}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context) - 2,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeeCard(BuildContext context, FeeRecord record) {
    Color statusColor = _getStatusColor(record.status);
    IconData statusIcon = _getStatusIcon(record.status);

    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    record.description,
                    style: AppThemeResponsiveness.getDashboardCardTitleStyle(context),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: statusColor, size: 16),
                      SizedBox(width: 4),
                      Text(
                        record.status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
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
                Icon(Icons.calendar_today,
                    size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                    color: Colors.grey[600]
                ),
                SizedBox(width: 4),
                Text(
                  'Due: ${_formatDate(record.dueDate)}',
                  style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
                ),
                if (record.paidDate != null) ...[
                  SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                  Icon(Icons.check_circle,
                      size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                      color: Colors.green
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Paid: ${_formatDate(record.paidDate!)}',
                    style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).copyWith(
                      color: Colors.green,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${record.amount.toStringAsFixed(2)}',
                  style: AppThemeResponsiveness.getStatValueStyle(context).copyWith(
                    color: AppThemeColor.primaryBlue,
                  ),
                ),
                if (record.status == 'pending' || record.status == 'overdue')
                  SizedBox(
                    height: AppThemeResponsiveness.getButtonHeight(context) * 0.8,
                    child: ElevatedButton(
                      onPressed: () => _showPaymentDialog(record),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppThemeColor.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                        ),
                      ),
                      child: Text(
                        'Pay Now',
                        style: AppThemeResponsiveness.getButtonTextStyle(context),
                      ),
                    ),
                  ),
              ],
            ),
            if (record.receiptNumber.isNotEmpty) ...[
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Receipt: ${record.receiptNumber}',
                style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context).copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadGridCard(BuildContext context, FeeRecord record) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.all(AppThemeResponsiveness.getGridItemPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getSmallSpacing(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.blue50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.receipt,
                    color: AppThemeColor.primaryBlue,
                    size: AppThemeResponsiveness.getGridItemIconSize(context) * 0.8,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _downloadReceipt(record),
                  icon: Icon(
                    Icons.download,
                    color: AppThemeColor.primaryBlue,
                    size: AppThemeResponsiveness.getIconSize(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
            Text(
              record.description,
              style: AppThemeResponsiveness.getGridItemTitleStyle(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Receipt: ${record.receiptNumber}',
              style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              'Amount: ₹${record.amount.toStringAsFixed(2)}',
              style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
            ),
            const Spacer(),
            Text(
              'Date: ${_formatDate(record.paidDate!)}',
              style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadCard(BuildContext context, FeeRecord record) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: ListTile(
        contentPadding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
        leading: Container(
          padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
          decoration: BoxDecoration(
            color: AppThemeColor.blue50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.receipt,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getDashboardCardIconSize(context),
          ),
        ),
        title: Text(
          record.description,
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Receipt: ${record.receiptNumber}',
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
            Text(
              'Amount: ₹${record.amount.toStringAsFixed(2)}',
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
            Text(
              'Date: ${_formatDate(record.paidDate!)}',
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () => _downloadReceipt(record),
          icon: Icon(
            Icons.download,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getIconSize(context),
          ),
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    double totalPaid = _feeRecords
        .where((r) => r.status == 'paid')
        .fold(0, (sum, r) => sum + r.amount);
    double totalPending = _feeRecords
        .where((r) => r.status != 'paid')
        .fold(0, (sum, r) => sum + r.amount);

    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      decoration: BoxDecoration(
        gradient: AppThemeColor.primaryGradient,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      child: Column(
        children: [
          Text(
            'Payment Summary',
            style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          AppThemeResponsiveness.isMobile(context)
              ? Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryItem(context, 'Total Paid', totalPaid, Colors.green),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.3),
                    margin: EdgeInsets.symmetric(horizontal: AppThemeResponsiveness.getSmallSpacing(context)),
                  ),
                  Expanded(
                    child: _buildSummaryItem(context, 'Pending', totalPending, Colors.orange),
                  ),
                ],
              ),
            ],
          )
              : Row(
            children: [
              Expanded(
                child: _buildSummaryItem(context, 'Total Paid', totalPaid, Colors.green),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildSummaryItem(context, 'Pending', totalPending, Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: AppThemeResponsiveness.getStatTitleStyle(context).copyWith(
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: AppThemeResponsiveness.getStatValueStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'paid':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'overdue':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showPaymentDialog(FeeRecord record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
          ),
          title: Text(
            'Payment Confirmation',
            style: AppThemeResponsiveness.getDialogTitleStyle(context),
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: AppThemeResponsiveness.isMobile(context)
                  ? MediaQuery.of(context).size.width * 0.9
                  : 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to pay the following fee?',
                  style: AppThemeResponsiveness.getDialogContentStyle(context),
                ),
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.blue50,
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.description,
                        style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount:',
                            style: AppThemeResponsiveness.getDialogContentStyle(context),
                          ),
                          Text(
                            '₹${record.amount.toStringAsFixed(2)}',
                            style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppThemeColor.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Due Date:',
                            style: AppThemeResponsiveness.getDialogContentStyle(context),
                          ),
                          Text(
                            _formatDate(record.dueDate),
                            style: AppThemeResponsiveness.getDialogContentStyle(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
                  vertical: AppThemeResponsiveness.getSmallSpacing(context),
                ),
              ),
              child: Text(
                'Cancel',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processPayment(record);
              },
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
                'Pay Now',
                style: AppThemeResponsiveness.getButtonTextStyle(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _processPayment(FeeRecord record) async {
    setState(() {
      _isLoading = true;
    });

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: AppThemeResponsiveness.isMobile(context)
                  ? MediaQuery.of(context).size.width * 0.8
                  : 300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.primaryBlue),
                ),
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                Text(
                  'Processing Payment...',
                  style: AppThemeResponsiveness.getDialogContentStyle(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    // Update record status
    setState(() {
      record.status = 'paid';
      record.paidDate = DateTime.now();
      record.receiptNumber = 'RPS${DateTime.now().millisecondsSinceEpoch}';
      _isLoading = false;
    });

    // Close loading dialog
    Navigator.of(context).pop();

    // Show success dialog
    _showPaymentSuccessDialog(record);
  }

  void _showPaymentSuccessDialog(FeeRecord record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: AppThemeResponsiveness.isMobile(context)
                  ? MediaQuery.of(context).size.width * 0.9
                  : 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: AppThemeResponsiveness.getHeaderIconSize(context),
                  ),
                ),
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                Text(
                  'Payment Successful!',
                  style: AppThemeResponsiveness.getDialogTitleStyle(context).copyWith(
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                Text(
                  'Your payment has been processed successfully.',
                  style: AppThemeResponsiveness.getDialogContentStyle(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                Container(
                  padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
                  decoration: BoxDecoration(
                    color: AppThemeColor.blue50,
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Receipt Number:',
                            style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              record.receiptNumber,
                              style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                                color: AppThemeColor.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount Paid:',
                            style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '₹${record.amount.toStringAsFixed(2)}',
                            style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                if (!AppThemeResponsiveness.isMobile(context))
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _downloadReceipt(record);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: AppThemeResponsiveness.getSmallSpacing(context),
                        ),
                      ),
                      child: Text(
                        'Download Receipt',
                        style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                          color: AppThemeColor.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                if (!AppThemeResponsiveness.isMobile(context))
                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemeColor.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: AppThemeResponsiveness.getSmallSpacing(context),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: AppThemeResponsiveness.getButtonTextStyle(context),
                    ),
                  ),
                ),
              ],
            ),
            if (AppThemeResponsiveness.isMobile(context)) ...[
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _downloadReceipt(record);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: AppThemeResponsiveness.getSmallSpacing(context),
                    ),
                  ),
                  child: Text(
                    'Download Receipt',
                    style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                      color: AppThemeColor.primaryBlue,
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _downloadReceipt(FeeRecord record) async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
              Expanded(
                child: Text(
                  'Generating receipt...',
                  style: TextStyle(
                    fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppThemeColor.primaryBlue,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
        ),
      );

      // Generate PDF receipt
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    'Fee Receipt',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Receipt Number: ${record.receiptNumber}'),
                pw.SizedBox(height: 10),
                pw.Text('Description: ${record.description}'),
                pw.SizedBox(height: 10),
                pw.Text('Amount: ₹${record.amount.toStringAsFixed(2)}'),
                pw.SizedBox(height: 10),
                pw.Text('Payment Date: ${record.paidDate != null ? _formatDate(record.paidDate!) : 'N/A'}'),
                pw.SizedBox(height: 10),
                pw.Text('Academic Year: ${record.academicYear}'),
                pw.SizedBox(height: 10),
                pw.Text('Term: ${record.term}'),
                pw.SizedBox(height: 30),
                pw.Text(
                  'This is a computer-generated receipt.',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Simulate PDF generation delay
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
              Expanded(
                child: Text(
                  'Receipt downloaded successfully!',
                  style: TextStyle(
                    fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
          action: SnackBarAction(
            label: 'View',
            textColor: Colors.white,
            onPressed: () {
              // Open PDF viewer or file manager
              _viewReceipt(record);
            },
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
              Expanded(
                child: Text(
                  'Failed to download receipt. Please try again.',
                  style: TextStyle(
                    fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          ),
        ),
      );
    }
  }

  void _viewReceipt(FeeRecord record) {
    // Navigate to PDF viewer or show receipt details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getDialogBorderRadius(context)),
          ),
          title: Text(
            'Receipt Details',
            style: AppThemeResponsiveness.getDialogTitleStyle(context),
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: AppThemeResponsiveness.isMobile(context)
                  ? MediaQuery.of(context).size.width * 0.9
                  : 400,
              maxHeight: AppThemeResponsiveness.isMobile(context)
                  ? MediaQuery.of(context).size.height * 0.6
                  : 500,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildReceiptDetailRow(context, 'Receipt Number', record.receiptNumber),
                  _buildReceiptDetailRow(context, 'Description', record.description),
                  _buildReceiptDetailRow(context, 'Amount', '₹${record.amount.toStringAsFixed(2)}'),
                  _buildReceiptDetailRow(context, 'Payment Date',
                      record.paidDate != null ? _formatDate(record.paidDate!) : 'N/A'),
                  _buildReceiptDetailRow(context, 'Due Date', _formatDate(record.dueDate)),
                  _buildReceiptDetailRow(context, 'Academic Year', record.academicYear),
                  _buildReceiptDetailRow(context, 'Term', record.term),
                  _buildReceiptDetailRow(context, 'Status', record.status.toUpperCase()),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _downloadReceipt(record);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeColor.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
              ),
              child: Text(
                'Download',
                style: AppThemeResponsiveness.getButtonTextStyle(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReceiptDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppThemeResponsiveness.getSmallSpacing(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppThemeResponsiveness.isMobile(context) ? 100 : 120,
            child: Text(
              '$label:',
              style: AppThemeResponsiveness.getDialogContentStyle(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppThemeResponsiveness.getDialogContentStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}