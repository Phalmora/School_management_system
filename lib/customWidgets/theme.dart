import 'package:flutter/material.dart';

class AppTheme {
  // Color Constants
  static const Color primaryBlue = Color(0xFF42A5F5); // Colors.blue.shade400
  static const Color primaryPurple = Color(0xFF8E24AA); // Colors.purple.shade600
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue200 = Color(0xFF90CAF9);
  static final Color blue800 = Colors.blue.shade800;
  static final Color blue600 = Colors.blue.shade600;


  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryPurple],
  );

  // Card Styling
  static const double cardElevation = 8.0;
  static const double cardBorderRadius = 15.0;

  // Input Field Styling
  static const double inputBorderRadius = 10.0;
  static const double focusedBorderWidth = 2.0;

  // Button Styling
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 25.0;
  static const double buttonElevation = 5.0;

  //Button text style
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: white,
    fontFamily: 'Roboto',
  );

  // Text Styles
  static const TextStyle FontStyle = TextStyle(
    fontSize: 28,
    color: white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto', // You can change this to your preferred font
  );


  static const TextStyle splashSubtitleStyle = TextStyle(
    fontSize: 16,
    color: white70,
    fontFamily: 'Roboto', // You can change this to your preferred font
  );

  // Animation Durations
  static const Duration splashAnimationDuration = Duration(seconds: 2);
  static const Duration splashScreenDuration = Duration(seconds: 3);
  static const Duration slideAnimationDuration = Duration(milliseconds: 800);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 300);

  // Spacing
  static const double defaultSpacing = 20.0;
  static const double smallSpacing = 10.0;
  static const double mediumSpacing = 15.0;
  static const double largeSpacing = 50.0;
  static const double extraLargeSpacing = 30.0;

  //Logo size
  static const double logoSize = 50.0;
}

