import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;
  final double Function(BuildContext) getSpacing;
  final double Function(BuildContext) getBorderRadius;
  final double Function(BuildContext) getFontSize;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    required this.getSpacing,
    required this.getBorderRadius,
    required this.getFontSize,
    required this.backgroundColor,
    required this.selectedColor,
    required this.unselectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getSpacing(context)),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(getBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: selectedColor,
          borderRadius: BorderRadius.circular(getBorderRadius(context)),
          boxShadow: [
            BoxShadow(
              color: selectedColor.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: unselectedColor,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: getFontSize(context),
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: getFontSize(context),
        ),
        tabs: tabs,
      ),
    );
  }
}
