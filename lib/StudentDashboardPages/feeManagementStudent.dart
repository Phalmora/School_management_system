import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/customWidgets/appBar.dart';


// Fee Data Model
class FeeRecord {
  final String id;
  final String description;
  final double amount;
  final DateTime dueDate;
  late final DateTime? paidDate;
  late final String status; // 'paid', 'pending', 'overdue'
  late final String receiptNumber;
  final String academicYear;
  final String term;

  FeeRecord({
    required this.id,
    required this.description,
    required this.amount,
    required this.dueDate,
    this.paidDate,
    required this.status,
    required this.receiptNumber,
    required this.academicYear,
    required this.term,
  });
}

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
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: AppTheme.mediumSpacing, left: AppTheme.defaultSpacing, right: AppTheme.defaultSpacing),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius * 2),
                      topRight: Radius.circular(AppTheme.cardBorderRadius * 2),
                    ),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildFeeHistoryTab(),
                      _buildPaymentStatusTab(),
                      _buildDownloadsTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          SizedBox(width: 70),
          Icon(Icons.account_balance_wallet, color: AppTheme.white, size: 32),
          SizedBox(width: AppTheme.mediumSpacing),
          Text(
            'Fee Management',
            style: AppTheme.FontStyle.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        labelColor: AppTheme.primaryBlue,
        unselectedLabelColor: AppTheme.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        tabs: [
          Tab(text: 'History'),
          Tab(text: 'Status'),
          Tab(text: 'Downloads'),
        ],
      ),
    );
  }

  Widget _buildFeeHistoryTab() {
    return ListView.builder(
      padding: EdgeInsets.all(AppTheme.defaultSpacing),
      itemCount: _feeRecords.length,
      itemBuilder: (context, index) {
        final record = _feeRecords[index];
        return _buildFeeCard(record);
      },
    );
  }

  Widget _buildPaymentStatusTab() {
    final pendingFees = _feeRecords.where((r) => r.status != 'paid').toList();
    final paidFees = _feeRecords.where((r) => r.status == 'paid').toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppTheme.defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(),
          SizedBox(height: AppTheme.defaultSpacing),
          if (pendingFees.isNotEmpty) ...[
            Text(
              'Pending Payments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            SizedBox(height: AppTheme.smallSpacing),
            ...pendingFees.map((record) => _buildFeeCard(record)).toList(),
            SizedBox(height: AppTheme.defaultSpacing),
          ],
          Text(
            'Completed Payments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
          SizedBox(height: AppTheme.smallSpacing),
          ...paidFees.map((record) => _buildFeeCard(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildDownloadsTab() {
    final paidFees = _feeRecords.where((r) => r.status == 'paid').toList();

    return ListView.builder(
      padding: EdgeInsets.all(AppTheme.defaultSpacing),
      itemCount: paidFees.length,
      itemBuilder: (context, index) {
        final record = paidFees[index];
        return _buildDownloadCard(record);
      },
    );
  }

  Widget _buildFeeCard(FeeRecord record) {
    Color statusColor = _getStatusColor(record.status);
    IconData statusIcon = _getStatusIcon(record.status);

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    record.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.smallSpacing,
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
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.smallSpacing),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  'Due: ${_formatDate(record.dueDate)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                if (record.paidDate != null) ...[
                  SizedBox(width: AppTheme.mediumSpacing),
                  Icon(Icons.check_circle, size: 16, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    'Paid: ${_formatDate(record.paidDate!)}',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ],
              ],
            ),
            SizedBox(height: AppTheme.smallSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${record.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                if (record.status == 'pending' || record.status == 'overdue')
                  ElevatedButton(
                    onPressed: () => _showPaymentDialog(record),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Pay Now', style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
            if (record.receiptNumber.isNotEmpty) ...[
              SizedBox(height: AppTheme.smallSpacing),
              Text(
                'Receipt: ${record.receiptNumber}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadCard(FeeRecord record) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.blue50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.receipt, color: AppTheme.primaryBlue),
        ),
        title: Text(
          record.description,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Receipt: ${record.receiptNumber}'),
            Text('Amount: ₹${record.amount.toStringAsFixed(2)}'),
            Text('Date: ${_formatDate(record.paidDate!)}'),
          ],
        ),
        trailing: IconButton(
          onPressed: () => _downloadReceipt(record),
          icon: Icon(Icons.download, color: AppTheme.primaryBlue),
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    double totalPaid = _feeRecords
        .where((r) => r.status == 'paid')
        .fold(0, (sum, r) => sum + r.amount);
    double totalPending = _feeRecords
        .where((r) => r.status != 'paid')
        .fold(0, (sum, r) => sum + r.amount);

    return Container(
      padding: EdgeInsets.all(AppTheme.defaultSpacing),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Column(
        children: [
          Text(
            'Payment Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppTheme.mediumSpacing),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem('Total Paid', totalPaid, Colors.green),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildSummaryItem('Pending', totalPending, Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Text('Confirm Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fee: ${record.description}'),
              SizedBox(height: 8),
              Text('Amount: ₹${record.amount.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              Text('Due Date: ${_formatDate(record.dueDate)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _processPayment(record);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Pay Now', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _processPayment(FeeRecord record) {
    setState(() {
      _isLoading = true;
    });

    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        record.status = 'paid';
        record.paidDate = DateTime.now();
        record.receiptNumber = 'RPS${DateTime.now().millisecondsSinceEpoch}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment successful!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    });
  }

  Future<void> _downloadReceipt(FeeRecord record) async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Create PDF document
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text('Royal Public School'),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Fee Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Receipt Number: ${record.receiptNumber}'),
                pw.Text('Date: ${_formatDate(record.paidDate!)}'),
                pw.Text('Academic Year: ${record.academicYear}'),
                pw.Text('Term: ${record.term}'),
                pw.SizedBox(height: 20),
                pw.Text('Fee Details:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text('Description: ${record.description}'),
                pw.Text('Amount: ₹${record.amount.toStringAsFixed(2)}'),
                pw.Text('Status: ${record.status.toUpperCase()}'),
                pw.SizedBox(height: 40),
                pw.Text('Thank you for your payment!'),
              ],
            );
          },
        ),
      );

      // Save PDF (in a real app, you'd use proper file handling)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receipt downloaded successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download receipt'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}