import 'package:flutter/material.dart';

class ActionButtonData {
  final IconData? icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  ActionButtonData({
    this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });
}