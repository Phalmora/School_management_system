import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionPaymentsScreen extends StatefulWidget {
  const AdmissionPaymentsScreen({super.key});

  @override
  State<AdmissionPaymentsScreen> createState() => _AdmissionPaymentsScreenState();
}

class _AdmissionPaymentsScreenState extends State<AdmissionPaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Center(child: Text('Enter Payment Mode', style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),)),
      ),

    );
  }
}
