import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class FeePaymentParentPage extends StatefulWidget {
  @override
  _FeePaymentParentPageState createState() => _FeePaymentParentPageState();
}

class _FeePaymentParentPageState extends State<FeePaymentParentPage> {
  // Sample data - replace with actual data from your backend
  final List<PaymentRecord> paymentHistory = [
    PaymentRecord(
      month: 'November 2024',
      amount: 5000.0,
      status: PaymentStatus.paid,
      dueDate: DateTime(2024, 11, 15),
      paidDate: DateTime(2024, 11, 10),
    ),
    PaymentRecord(
      month: 'December 2024',
      amount: 5000.0,
      status: PaymentStatus.pending,
      dueDate: DateTime(2024, 12, 15),
    ),
    PaymentRecord(
      month: 'January 2025',
      amount: 5000.0,
      status: PaymentStatus.overdue,
      dueDate: DateTime(2025, 1, 15),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Summary Card
              _buildPaymentSummaryCard(),
              SizedBox(height: AppTheme.defaultSpacing),

              // Quick Actions
              _buildQuickActionsCard(),
              SizedBox(height: AppTheme.defaultSpacing),

              // Payment History
              Text(
                'Payment History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: AppTheme.mediumSpacing),

              // Payment Records
              ...paymentHistory.map((record) => _buildPaymentCard(record)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummaryCard() {
    final pendingAmount = paymentHistory
        .where((record) => record.status != PaymentStatus.paid)
        .fold(0.0, (sum, record) => sum + record.amount);

    final lastPayment = paymentHistory
        .where((record) => record.status == PaymentStatus.paid)
        .isNotEmpty
        ? paymentHistory.where((record) => record.status == PaymentStatus.paid).last
        : null;

    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Container(
        color: AppTheme.blue200,
        padding: EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: AppTheme.blue600, size: 28),
                SizedBox(width: AppTheme.smallSpacing),
                Text(
                  'Payment Summary',
                  style: AppTheme.FontStyle.copyWith(fontSize: 20, color: AppTheme.blue600),
                ),
              ],
            ),
            SizedBox(height: AppTheme.defaultSpacing),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pending Amount',
                      style: AppTheme.splashSubtitleStyle,
                    ),
                    Text(
                      '₹${pendingAmount.toStringAsFixed(0)}',
                      style: AppTheme.FontStyle.copyWith(fontSize: 24),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Last Payment',
                      style: AppTheme.splashSubtitleStyle,
                    ),
                    Text(
                      lastPayment != null
                          ? '₹${lastPayment.amount.toStringAsFixed(0)}'
                          : 'No payments',
                      style: AppTheme.FontStyle.copyWith(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),

            if (lastPayment != null) ...[
              SizedBox(height: AppTheme.smallSpacing),
              Text(
                'Paid on: ${_formatDate(lastPayment.paidDate!)}',
                style: AppTheme.splashSubtitleStyle.copyWith(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.blue800,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: AppTheme.mediumSpacing),

            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Make Payment',
                    Icons.payment,
                    AppTheme.primaryBlue,
                        () => _showPaymentDialog(),
                  ),
                ),
                SizedBox(width: AppTheme.mediumSpacing),
                Expanded(
                  child: _buildActionButton(
                    'Download Receipt',
                    Icons.download,
                    AppTheme.primaryPurple,
                        () => _downloadReceipt(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppTheme.white,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        elevation: 3,
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(PaymentRecord record) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.month,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blue800,
                    fontFamily: 'Roboto',
                  ),
                ),
                _buildStatusChip(record.status),
              ],
            ),
            SizedBox(height: AppTheme.smallSpacing),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      '₹${record.amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blue800,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      record.status == PaymentStatus.paid ? 'Paid Date' : 'Due Date',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      _formatDate(record.status == PaymentStatus.paid
                          ? record.paidDate!
                          : record.dueDate),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: record.status == PaymentStatus.overdue
                            ? Colors.red
                            : AppTheme.blue600,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ],
            ),

            if (record.status != PaymentStatus.paid) ...[
              SizedBox(height: AppTheme.mediumSpacing),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _payNow(record),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: record.status == PaymentStatus.overdue
                            ? Colors.red
                            : AppTheme.primaryBlue,
                        foregroundColor: AppTheme.white,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              SizedBox(height: AppTheme.mediumSpacing),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _downloadReceiptForRecord(record),
                      icon: Icon(Icons.download, size: 16),
                      label: Text('Download Receipt'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryBlue,
                        side: BorderSide(color: AppTheme.primaryBlue),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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

  Widget _buildStatusChip(PaymentStatus status) {
    Color color;
    String text;

    switch (status) {
      case PaymentStatus.paid:
        color = Colors.green;
        text = 'Paid';
        break;
      case PaymentStatus.pending:
        color = Colors.orange;
        text = 'Pending';
        break;
      case PaymentStatus.overdue:
        color = Colors.red;
        text = 'Overdue';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select payment method:'),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Credit/Debit Card'),
                onTap: () {
                  Navigator.pop(context);
                  _processPayment('Card');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text('Net Banking'),
                onTap: () {
                  Navigator.pop(context);
                  _processPayment('Net Banking');
                },
              ),
              ListTile(
                leading: Icon(Icons.phone_android),
                title: Text('UPI'),
                onTap: () {
                  Navigator.pop(context);
                  _processPayment('UPI');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _processPayment(String method) {
    // Implement payment processing logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Processing payment via $method...'),
        backgroundColor: AppTheme.primaryBlue,
      ),
    );
  }

  void _payNow(PaymentRecord record) {
    // Implement specific payment for a record
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Processing payment for ${record.month}...'),
        backgroundColor: AppTheme.primaryBlue,
      ),
    );
  }

  void _downloadReceipt() {
    // Implement receipt download logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading latest receipt...'),
        backgroundColor: AppTheme.primaryPurple,
      ),
    );
  }

  void _downloadReceiptForRecord(PaymentRecord record) {
    // Implement specific receipt download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading receipt for ${record.month}...'),
        backgroundColor: AppTheme.primaryPurple,
      ),
    );
  }
}

// Data Models
enum PaymentStatus { paid, pending, overdue }

class PaymentRecord {
  final String month;
  final double amount;
  final PaymentStatus status;
  final DateTime dueDate;
  final DateTime? paidDate;

  PaymentRecord({
    required this.month,
    required this.amount,
    required this.status,
    required this.dueDate,
    this.paidDate,
  });
}