import 'package:flutter/material.dart';
import 'package:school/StudentDashboardPages/subjectAndMarks.dart';
import 'package:school/customWidgets/appBar.dart';


class TeacherTimetablePage extends StatefulWidget {
  const TeacherTimetablePage({Key? key}) : super(key: key);

  @override
  State<TeacherTimetablePage> createState() => _TeacherTimetablePageState();
}

class _TeacherTimetablePageState extends State<TeacherTimetablePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample timetable data
  final Map<String, List<TimeSlot>> weeklySchedule = {
    'Monday': [
      TimeSlot('9:00 AM', '10:00 AM', 'Mathematics', 'Class 10A', 'Room 101'),
      TimeSlot('10:30 AM', '11:30 AM', 'Physics', 'Class 12B', 'Lab 203'),
      TimeSlot('12:00 PM', '1:00 PM', 'Mathematics', 'Class 11C', 'Room 105'),
      TimeSlot('2:00 PM', '3:00 PM', 'Study Hall', 'Class 10A', 'Room 101'),
    ],
    'Tuesday': [
      TimeSlot('8:30 AM', '9:30 AM', 'Physics', 'Class 11A', 'Lab 201'),
      TimeSlot('10:00 AM', '11:00 AM', 'Mathematics', 'Class 9B', 'Room 102'),
      TimeSlot('11:30 AM', '12:30 PM', 'Physics', 'Class 12A', 'Lab 203'),
      TimeSlot('1:30 PM', '2:30 PM', 'Mathematics', 'Class 10C', 'Room 104'),
    ],
    'Wednesday': [
      TimeSlot('9:00 AM', '10:00 AM', 'Mathematics', 'Class 11B', 'Room 103'),
      TimeSlot('10:30 AM', '11:30 AM', 'Physics', 'Class 10A', 'Lab 201'),
      TimeSlot('1:00 PM', '2:00 PM', 'Study Hall', 'Class 12C', 'Room 106'),
      TimeSlot('2:30 PM', '3:30 PM', 'Mathematics', 'Class 9A', 'Room 101'),
    ],
    'Thursday': [
      TimeSlot('8:30 AM', '9:30 AM', 'Physics', 'Class 12B', 'Lab 203'),
      TimeSlot('10:00 AM', '11:00 AM', 'Mathematics', 'Class 10B', 'Room 105'),
      TimeSlot('11:30 AM', '12:30 PM', 'Physics', 'Class 11C', 'Lab 201'),
      TimeSlot('2:00 PM', '3:00 PM', 'Mathematics', 'Class 12A', 'Room 102'),
    ],
    'Friday': [
      TimeSlot('9:00 AM', '10:00 AM', 'Mathematics', 'Class 9C', 'Room 101'),
      TimeSlot('10:30 AM', '11:30 AM', 'Physics', 'Class 10C', 'Lab 202'),
      TimeSlot('12:00 PM', '1:00 PM', 'Mathematics', 'Class 11A', 'Room 104'),
      TimeSlot('2:00 PM', '3:00 PM', 'Faculty Meeting', 'All Staff', 'Conference Room'),
    ],
  };

  final List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: weekDays.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              _buildTabBar(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: AppTheme.defaultSpacing,
                    left: AppTheme.mediumSpacing,
                    right: AppTheme.mediumSpacing,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: _buildTimetableContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          const SizedBox(width: AppTheme.mediumSpacing),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Timetable',
                  style: AppTheme.FontStyle,
                ),
                Text(
                  'View your weekly teaching schedule',
                  style: AppTheme.splashSubtitleStyle,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppTheme.smallSpacing),
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: AppTheme.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
        ),
        labelColor: AppTheme.primaryBlue,
        unselectedLabelColor: AppTheme.white,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        tabs: weekDays.map((day) => Tab(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(day.substring(0, 3).toUpperCase()),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildTimetableContent() {
    return TabBarView(
      controller: _tabController,
      children: weekDays.map((day) => _buildDaySchedule(day)).toList(),
    );
  }

  Widget _buildDaySchedule(String day) {
    final daySchedule = weeklySchedule[day] ?? [];

    if (daySchedule.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.free_breakfast,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: AppTheme.mediumSpacing),
            Text(
              'No classes scheduled',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      itemCount: daySchedule.length,
      itemBuilder: (context, index) {
        return _buildTimeSlotCard(daySchedule[index], index);
      },
    );
  }

  Widget _buildTimeSlotCard(TimeSlot timeSlot, int index) {
    return AnimatedContainer(
      duration: AppTheme.buttonAnimationDuration,
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      child: Card(
        elevation: AppTheme.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.blue50,
                AppTheme.blue100,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.mediumSpacing),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppTheme.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            timeSlot.subject,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.blue800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${timeSlot.startTime} - ${timeSlot.endTime}',
                              style: const TextStyle(
                                color: AppTheme.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.group,
                            size: 16,
                            color: AppTheme.blue600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timeSlot.className,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.blue600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: AppTheme.mediumSpacing),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppTheme.blue600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timeSlot.room,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.blue600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;
  final String subject;
  final String className;
  final String room;

  TimeSlot(this.startTime, this.endTime, this.subject, this.className, this.room);
}