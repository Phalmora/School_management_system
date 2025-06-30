import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';
import 'package:school/modelTryConection.dart';


class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List<Student>> students;

  @override
  void initState() {
    super.initState();
    students = ApiService.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      body: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final studentList = snapshot.data!;
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                final student = studentList[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.email),
                  trailing: Icon(
                    student.enrolled ? Icons.check_circle : Icons.cancel,
                    color: student.enrolled ? Colors.green : Colors.red,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



