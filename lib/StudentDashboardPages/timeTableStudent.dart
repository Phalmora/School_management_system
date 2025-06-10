import 'package:flutter/material.dart';
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/customWidgets/appBar.dart';

class TimeTableStudentScreen extends StatefulWidget {
  @override
  _TimeTableStudentScreenState createState() => _TimeTableStudentScreenState();
}

class _TimeTableStudentScreenState extends State<TimeTableStudentScreen> {
  String selectedDay = 'Monday';
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  // Sample time table data
  final Map<String, List<ClassSchedule>> timeTable = {
    'Monday': [
      ClassSchedule('Mathematics', '9:00 AM - 10:00 AM', 'Room 101'),
      ClassSchedule('Physics', '10:15 AM - 11:15 AM', 'Room 102'),
      ClassSchedule('Chemistry', '11:30 AM - 12:30 PM', 'Room 103'),
      ClassSchedule('English', '1:30 PM - 2:30 PM', 'Room 104'),
      ClassSchedule('History', '2:45 PM - 3:45 PM', 'Room 105'),
    ],
    'Tuesday': [
      ClassSchedule('Biology', '9:00 AM - 10:00 AM', 'Room 106'),
      ClassSchedule('Mathematics', '10:15 AM - 11:15 AM', 'Room 101'),
      ClassSchedule('Computer Science', '11:30 AM - 12:30 PM', 'Room 107'),
      ClassSchedule('Physical Education', '1:30 PM - 2:30 PM', 'Gym'),
      ClassSchedule('Art', '2:45 PM - 3:45 PM', 'Room 108'),
    ],
    'Wednesday': [
      ClassSchedule('Geography', '9:00 AM - 10:00 AM', 'Room 109'),
      ClassSchedule('Physics', '10:15 AM - 11:15 AM', 'Room 102'),
      ClassSchedule('Mathematics', '11:30 AM - 12:30 PM', 'Room 101'),
      ClassSchedule('Chemistry', '1:30 PM - 2:30 PM', 'Room 103'),
      ClassSchedule('Music', '2:45 PM - 3:45 PM', 'Room 110'),
    ],
    'Thursday': [
      ClassSchedule('English', '9:00 AM - 10:00 AM', 'Room 104'),
      ClassSchedule('Biology', '10:15 AM - 11:15 AM', 'Room 106'),
      ClassSchedule('History', '11:30 AM - 12:30 PM', 'Room 105'),
      ClassSchedule('Mathematics', '1:30 PM - 2:30 PM', 'Room 101'),
      ClassSchedule('Computer Science', '2:45 PM - 3:45 PM', 'Room 107'),
    ],
    'Friday': [
      ClassSchedule('Physics', '9:00 AM - 10:00 AM', 'Room 102'),
      ClassSchedule('Chemistry', '10:15 AM - 11:15 AM', 'Room 103'),
      ClassSchedule('English', '11:30 AM - 12:30 PM', 'Room 104'),
      ClassSchedule('Geography', '1:30 PM - 2:30 PM', 'Room 109'),
      ClassSchedule('Library Period', '2:45 PM - 3:45 PM', 'Library'),
    ],
    'Saturday': [
      ClassSchedule('Mathematics', '9:00 AM - 10:00 AM', 'Room 101'),
      ClassSchedule('Science Lab', '10:15 AM - 12:15 PM', 'Lab 1'),
      ClassSchedule('Sports', '1:30 PM - 3:30 PM', 'Playground'),
    ],
  };

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
              Padding(
                padding: const EdgeInsets.all(AppTheme.defaultSpacing),
                child: Row(
                  children: [
                    Icon(Icons.schedule, color: AppTheme.white, size: 30),
                    SizedBox(width: AppTheme.smallSpacing),
                    Text(
                      'Time Table',
                      style: AppTheme.FontStyle.copyWith(fontSize: 24),
                    ),
                  ],
                ),
              ),

              // Day Selection
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final isSelected = selectedDay == day;
                    return GestureDetector(
                      onTap: () => setState(() => selectedDay = day),
                      child: Container(
                        margin: EdgeInsets.only(right: AppTheme.smallSpacing),
                        padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.white : AppTheme.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                        ),
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              color: isSelected ? AppTheme.blue600 : AppTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: AppTheme.defaultSpacing),

              // Time Table Content
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                  padding: EdgeInsets.all(AppTheme.defaultSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$selectedDay Schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blue800,
                        ),
                      ),
                      SizedBox(height: AppTheme.mediumSpacing),
                      Expanded(
                        child: ListView.builder(
                          itemCount: timeTable[selectedDay]?.length ?? 0,
                          itemBuilder: (context, index) {
                            final classSchedule = timeTable[selectedDay]![index];
                            return ClassCard(classSchedule: classSchedule);
                          },
                        ),
                      ),
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

class ClassCard extends StatelessWidget {
  final ClassSchedule classSchedule;

  const ClassCard({Key? key, required this.classSchedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      padding: EdgeInsets.all(AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.blue50,
        borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        border: Border.all(color: AppTheme.blue200, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: AppTheme.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classSchedule.subject,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blue800,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: AppTheme.blue600),
                    SizedBox(width: 4),
                    Text(
                      classSchedule.time,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.blue600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: AppTheme.blue600),
                    SizedBox(width: 4),
                    Text(
                      classSchedule.room,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.blue600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClassSchedule {
  final String subject;
  final String time;
  final String room;

  ClassSchedule(this.subject, this.time, this.room);
}