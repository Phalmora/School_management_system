import 'package:flutter/material.dart';
import 'package:school/customWidgets/button.dart';
import 'package:school/customWidgets/commonCustomWidget/themeColor.dart';
import 'package:school/customWidgets/commonCustomWidget/themeResponsiveness.dart';

class FormNavigationButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const FormNavigationButtons({
    Key? key,
    required this.onNext,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          title: 'Next',
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: onNext,
        ),
        SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
        if (onBack != null)
          SecondaryButton(
            title: 'Back',
            icon: Icon(Icons.arrow_back_rounded, color: AppThemeColor.blue600),
            color: AppThemeColor.blue600,
            onPressed: onBack!,
          ),
      ],
    );
  }
}
