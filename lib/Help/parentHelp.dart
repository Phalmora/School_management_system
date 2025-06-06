import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';

class ParentHelp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Center(

        child: Text('Parents Help'),
      ),
    );
  }
}
