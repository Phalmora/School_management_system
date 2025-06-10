import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class Student {
  final String id;
  final String name;
  final String className;
  final String rollNumber;
  final int presentDays;
  final int totalDays;
  final String profileImage;
  final bool isPresent;

  Student({
    required this.id,
    required this.name,
    required this.className,
    required this.rollNumber,
    required this.presentDays,
    required this.totalDays,
    this.profileImage = '',
    this.isPresent = true,
  });

  double get attendancePercentage => (presentDays / totalDays) * 100;
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String selectedClass = "Class 10-A";
  List<String> classes = ["Class 10-A", "Class 10-B", "Class 9-A", "Class 9-B"];

  // Sample data
  List<Student> students = [
    Student(
      id: "1",
      name: "Aarav Sharma",
      className: "Class 10-A",
      rollNumber: "001",
      presentDays: 18,
      totalDays: 20,
      isPresent: true,
    ),
    Student(
      id: "2",
      name: "Priya Patel",
      className: "Class 10-A",
      rollNumber: "002",
      presentDays: 17,
      totalDays: 20,
      isPresent: false,
    ),
    Student(
      id: "3",
      name: "Rohan Kumar",
      className: "Class 10-A",
      rollNumber: "003",
      presentDays: 19,
      totalDays: 20,
      isPresent: true,
    ),
    Student(
      id: "4",
      name: "Ananya Singh",
      className: "Class 10-A",
      rollNumber: "004",
      presentDays: 16,
      totalDays: 20,
      isPresent: true,
    ),
    Student(
      id: "5",
      name: "Vikram Gupta",
      className: "Class 10-A",
      rollNumber: "005",
      presentDays: 15,
      totalDays: 20,
      isPresent: false,
    ),
  ];

  List<Student> get filteredStudents =>
      students.where((student) => student.className == selectedClass).toList();

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
              SizedBox(width: AppTheme.defaultSpacing,),
              _buildClassSelector(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: AppTheme.mediumSpacing),
                  decoration: const BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.cardBorderRadius),
                      topRight: Radius.circular(AppTheme.cardBorderRadius),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildHeader(),
                      Expanded(child: _buildStudentList()),
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

  Widget _buildClassSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
        decoration: BoxDecoration(
          color: AppTheme.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedClass,
            dropdownColor: AppTheme.white,
            icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.white),
            style: const TextStyle(
              color: AppTheme.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            items: classes.map((String className) {
              return DropdownMenuItem<String>(
                value: className,
                child: Text(
                  className,
                  style: TextStyle(
                    color: AppTheme.blue800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedClass = newValue;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          const Icon(
            Icons.people,
            color: AppTheme.primaryBlue,
            size: 28,
          ),
          const SizedBox(width: AppTheme.smallSpacing),
          Text(
            "Student List",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.blue800,
              fontFamily: 'Roboto',
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppTheme.blue50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${filteredStudents.length} Students",
              style: TextStyle(
                color: AppTheme.blue600,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        return _buildStudentCard(student);
      },
    );
  }

  Widget _buildStudentCard(Student student) {
    Color attendanceColor = _getAttendanceColor(student.attendancePercentage);

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.mediumSpacing),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.mediumSpacing),
        child: Row(
          children: [
            // Profile Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  student.name.split(' ').map((n) => n[0]).take(2).join(),
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.mediumSpacing),

            // Student Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          student.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.blue800,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: student.isPresent
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          student.isPresent ? "Present" : "Absent",
                          style: TextStyle(
                            color: student.isPresent
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Roll No: ${student.rollNumber}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Attendance Info
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: attendanceColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${student.presentDays}/${student.totalDays} days",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: AppTheme.smallSpacing),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: attendanceColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${student.attendancePercentage.toInt()}%",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: attendanceColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Button
            GestureDetector(
              onTap: () => _showStudentDetails(student),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.blue50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.blue600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return Colors.green.shade600;
    if (percentage >= 75) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  void _showStudentDetails(Student student) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(AppTheme.defaultSpacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppTheme.defaultSpacing),
            Text(
              student.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.blue800,
              ),
            ),
            const SizedBox(height: AppTheme.mediumSpacing),
            _buildDetailRow("Roll Number", student.rollNumber),
            _buildDetailRow("Class", student.className),
            _buildDetailRow("Present Days", "${student.presentDays}"),
            _buildDetailRow("Total Days", "${student.totalDays}"),
            _buildDetailRow("Attendance", "${student.attendancePercentage.toInt()}%"),
            _buildDetailRow("Today's Status", student.isPresent ? "Present" : "Absent"),
            const SizedBox(height: AppTheme.defaultSpacing),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.blue800,
            ),
          ),
        ],
      ),
    );
  }
}
