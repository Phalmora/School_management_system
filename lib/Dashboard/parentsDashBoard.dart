import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class ParentsDashboard extends StatefulWidget {
  const ParentsDashboard({super.key});

  @override
  State<ParentsDashboard> createState() => _ParentsDashboardState();
}

class _ParentsDashboardState extends State<ParentsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Center(child: Text('Parents Dashboard')),
      ),
    );
  }
}
