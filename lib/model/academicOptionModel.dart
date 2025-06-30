import 'package:flutter/material.dart';

class AcademicOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget Function() route;
  final String stats;

  AcademicOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.route,
    required this.stats,
  });
}


class AcademicClass {
  final String id;
  final String className;
  final String section;
  final int capacity;
  final String classTeacher;
  final DateTime createdAt;

  AcademicClass({
    required this.id,
    required this.className,
    required this.section,
    required this.capacity,
    required this.classTeacher,
    required this.createdAt,
  });
}

class Subject {
  final String id;
  final String subjectName;
  final String subjectCode;
  final String description;
  final List<String> assignedClasses;
  final DateTime createdAt;

  Subject({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.description,
    required this.assignedClasses,
    required this.createdAt,
  });
}

class SportGroup {
  final String id;
  final String groupName;
  final String sportType;
  final String coach;
  final int maxMembers;
  final List<String> members;
  final DateTime createdAt;

  SportGroup({
    required this.id,
    required this.groupName,
    required this.sportType,
    required this.coach,
    required this.maxMembers,
    required this.members,
    required this.createdAt,
  });
}

class HouseGroup {
  final String id;
  final String houseName;
  final String houseColor;
  final String captain;
  final String viceCaptain;
  final int points;
  final List<String> members;
  final DateTime createdAt;

  HouseGroup({
    required this.id,
    required this.houseName,
    required this.houseColor,
    required this.captain,
    required this.viceCaptain,
    required this.points,
    required this.members,
    required this.createdAt,
  });
}
