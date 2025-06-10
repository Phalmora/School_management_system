import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

// Fee Slip Model
class FeeSlip {
  final String id;
  final String studentId;
  final String studentName;
  final String className;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String status; // 'Paid', 'Due', 'Late'
  final DateTime dueDate;
  final DateTime? paidDate;
  final List<FeeItem> feeItems;

  FeeSlip({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.className,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.status,
    required this.dueDate,
    this.paidDate,
    required this.feeItems,
  });
}

// Fee Item Model
class FeeItem {
  final String name;
  final double amount;
  final String type; // 'tuition', 'transport', 'library', etc.

  FeeItem({
    required this.name,
    required this.amount,
    required this.type,
  });
}

// Discount Model
class Discount {
  final String id;
  final String name;
  final String type; // 'percentage', 'fixed'
  final double value;
  final String description;
  final bool isActive;

  Discount({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    required this.description,
    required this.isActive,
  });
}

class FeeManagementPage extends StatefulWidget {
  @override
  _FeeManagementPageState createState() => _FeeManagementPageState();
}

class _FeeManagementPageState extends State<FeeManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample Data
  List<FeeSlip> feeSlips = [
    FeeSlip(
      id: 'FEE001',
      studentId: 'STU001',
      studentName: 'John Doe',
      className: 'Class 10-A',
      totalAmount: 5000.0,
      paidAmount: 5000.0,
      dueAmount: 0.0,
      status: 'Paid',
      dueDate: DateTime.now().subtract(Duration(days: 5)),
      paidDate: DateTime.now().subtract(Duration(days: 3)),
      feeItems: [
        FeeItem(name: 'Tuition Fee', amount: 3000.0, type: 'tuition'),
        FeeItem(name: 'Transport Fee', amount: 1500.0, type: 'transport'),
        FeeItem(name: 'Library Fee', amount: 500.0, type: 'library'),
      ],
    ),
    FeeSlip(
      id: 'FEE002',
      studentId: 'STU002',
      studentName: 'Jane Smith',
      className: 'Class 9-B',
      totalAmount: 4800.0,
      paidAmount: 2400.0,
      dueAmount: 2400.0,
      status: 'Due',
      dueDate: DateTime.now().add(Duration(days: 7)),
      feeItems: [
        FeeItem(name: 'Tuition Fee', amount: 2800.0, type: 'tuition'),
        FeeItem(name: 'Transport Fee', amount: 1500.0, type: 'transport'),
        FeeItem(name: 'Activity Fee', amount: 500.0, type: 'activity'),
      ],
    ),
    FeeSlip(
      id: 'FEE003',
      studentId: 'STU003',
      studentName: 'Mike Johnson',
      className: 'Class 8-A',
      totalAmount: 4500.0,
      paidAmount: 0.0,
      dueAmount: 4500.0,
      status: 'Late',
      dueDate: DateTime.now().subtract(Duration(days: 10)),
      feeItems: [
        FeeItem(name: 'Tuition Fee', amount: 3000.0, type: 'tuition'),
        FeeItem(name: 'Lab Fee', amount: 1000.0, type: 'lab'),
        FeeItem(name: 'Sports Fee', amount: 500.0, type: 'sports'),
      ],
    ),
  ];

  List<Discount> discounts = [
    Discount(
      id: 'DIS001',
      name: 'Sibling Discount',
      type: 'percentage',
      value: 10.0,
      description: '10% discount for siblings',
      isActive: true,
    ),
    Discount(
      id: 'DIS002',
      name: 'Merit Scholarship',
      type: 'percentage',
      value: 25.0,
      description: '25% scholarship for merit students',
      isActive: true,
    ),
    Discount(
      id: 'DIS003',
      name: 'Early Payment',
      type: 'fixed',
      value: 200.0,
      description: 'Rs. 200 off for early payment',
      isActive: true,
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

  // Fee Slip Methods
  void _generateFeeSlip() {
    _showFeeSlipDialog();
  }

  void _editFeeSlip(FeeSlip feeSlip) {
    _showFeeSlipDialog(feeSlip: feeSlip);
  }

  void _showFeeSlipDialog({FeeSlip? feeSlip}) {
    final isEditing = feeSlip != null;
    final studentNameController = TextEditingController(text: feeSlip?.studentName ?? '');
    final classNameController = TextEditingController(text: feeSlip?.className ?? '');
    final totalAmountController = TextEditingController(text: feeSlip?.totalAmount.toString() ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Fee Slip' : 'Generate Fee Slip'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Student Name', studentNameController, Icons.person),
                SizedBox(height: AppTheme.smallSpacing),
                _buildTextField('Class', classNameController, Icons.class_),
                SizedBox(height: AppTheme.smallSpacing),
                _buildTextField('Total Amount', totalAmountController, Icons.currency_rupee),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add fee slip logic here
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
              child: Text(
                isEditing ? 'Update' : 'Generate',
                style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  // Discount Methods
  void _addDiscount() {
    _showDiscountDialog();
  }

  void _editDiscount(Discount discount) {
    _showDiscountDialog(discount: discount);
  }

  void _showDiscountDialog({Discount? discount}) {
    final isEditing = discount != null;
    final nameController = TextEditingController(text: discount?.name ?? '');
    final valueController = TextEditingController(text: discount?.value.toString() ?? '');
    final descriptionController = TextEditingController(text: discount?.description ?? '');
    String selectedType = discount?.type ?? 'percentage';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Discount' : 'Add Discount'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField('Discount Name', nameController, Icons.local_offer),
                    SizedBox(height: AppTheme.smallSpacing),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        prefixIcon: Icon(Icons.type_specimen),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                        ),
                      ),
                      items: ['percentage', 'fixed'].map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type == 'percentage' ? 'Percentage (%)' : 'Fixed Amount (₹)'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Value', valueController, Icons.numbers),
                    SizedBox(height: AppTheme.smallSpacing),
                    _buildTextField('Description', descriptionController, Icons.description),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add discount logic here
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
                  child: Text(
                    isEditing ? 'Update' : 'Add',
                    style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
          borderSide: BorderSide(
            color: AppTheme.primaryBlue,
            width: AppTheme.focusedBorderWidth,
          ),
        ),
      ),
    );
  }

  Widget _buildFeeSlipsTab() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(AppTheme.defaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fee Slips (${feeSlips.length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _generateFeeSlip,
                icon: Icon(Icons.add),
                label: Text('Generate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: feeSlips.length,
            itemBuilder: (context, index) {
              final feeSlip = feeSlips[index];
              return Card(
                margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: feeSlip.status == 'Paid'
                        ? Colors.green
                        : feeSlip.status == 'Due'
                        ? Colors.orange
                        : Colors.red,
                    child: Icon(Icons.receipt, color: Colors.white),
                  ),
                  title: Text(
                    feeSlip.studentName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Class: ${feeSlip.className}'),
                      Text('Total: ₹${feeSlip.totalAmount}'),
                      Text('Due: ₹${feeSlip.dueAmount}'),
                      Row(
                        children: [
                          Text('Status: '),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: feeSlip.status == 'Paid'
                                  ? Colors.green.shade100
                                  : feeSlip.status == 'Due'
                                  ? Colors.orange.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              feeSlip.status,
                              style: TextStyle(
                                color: feeSlip.status == 'Paid'
                                    ? Colors.green.shade800
                                    : feeSlip.status == 'Due'
                                    ? Colors.orange.shade800
                                    : Colors.red.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () => _editFeeSlip(feeSlip),
                    icon: Icon(Icons.edit, color: AppTheme.primaryBlue),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppTheme.mediumSpacing),
                      child: Column(
                        children: feeSlip.feeItems.map((item) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.name),
                              Text('₹${item.amount}', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatusTab() {
    final paidCount = feeSlips.where((f) => f.status == 'Paid').length;
    final dueCount = feeSlips.where((f) => f.status == 'Due').length;
    final lateCount = feeSlips.where((f) => f.status == 'Late').length;

    return Padding(
      padding: EdgeInsets.all(AppTheme.defaultSpacing),
      child: Column(
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.mediumSpacing),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 30),
                        Text('$paidCount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Paid', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppTheme.smallSpacing),
              Expanded(
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.mediumSpacing),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: Colors.orange, size: 30),
                        Text('$dueCount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Due', style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppTheme.smallSpacing),
              Expanded(
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.mediumSpacing),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 30),
                        Text('$lateCount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Late', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.defaultSpacing),

          // Payment Status List
          Expanded(
            child: ListView.builder(
              itemCount: feeSlips.length,
              itemBuilder: (context, index) {
                final feeSlip = feeSlips[index];
                return Card(
                  margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: feeSlip.status == 'Paid'
                          ? Colors.green
                          : feeSlip.status == 'Due'
                          ? Colors.orange
                          : Colors.red,
                      child: Text(
                        feeSlip.status[0],
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(feeSlip.studentName),
                    subtitle: Text('₹${feeSlip.dueAmount} remaining'),
                    trailing: Text(
                      feeSlip.status,
                      style: TextStyle(
                        color: feeSlip.status == 'Paid'
                            ? Colors.green
                            : feeSlip.status == 'Due'
                            ? Colors.orange
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountsTab() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(AppTheme.defaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discounts & Scholarships',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _addDiscount,
                icon: Icon(Icons.add),
                label: Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
            itemCount: discounts.length,
            itemBuilder: (context, index) {
              final discount = discounts[index];
              return Card(
                margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(AppTheme.mediumSpacing),
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryBlue,
                    child: Icon(Icons.local_offer, color: Colors.white),
                  ),
                  title: Text(
                    discount.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Value: ${discount.type == 'percentage' ? '${discount.value}%' : '₹${discount.value}'}'),
                      Text(discount.description),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: discount.isActive ? Colors.green.shade100 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          discount.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: discount.isActive ? Colors.green.shade800 : Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _editDiscount(discount),
                        icon: Icon(Icons.edit, color: AppTheme.primaryBlue),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(AppTheme.defaultSpacing),
                padding: EdgeInsets.all(AppTheme.mediumSpacing),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment, size: 32, color: AppTheme.primaryBlue),
                    SizedBox(width: AppTheme.smallSpacing),
                    Text(
                      'Fee Management',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppTheme.white,
                  tabs: [
                    Tab(text: 'Fee Slips', icon: Icon(Icons.receipt)),
                    Tab(text: 'Payment Status', icon: Icon(Icons.payment)),
                    Tab(text: 'Discounts', icon: Icon(Icons.local_offer)),
                  ],
                ),
              ),

              // Tab Bar View
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    AppTheme.defaultSpacing,
                    AppTheme.smallSpacing,
                    AppTheme.defaultSpacing,
                    AppTheme.defaultSpacing,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildFeeSlipsTab(),
                      _buildPaymentStatusTab(),
                      _buildDiscountsTab(),
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
}