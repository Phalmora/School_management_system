// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school/modelTryConection.dart';

class ApiService {

  // ✅ For Android Emulator
  static const String baseUrl = 'http://10.0.2.2:8000/api/students/';

// Get all students
  static Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((e) => Student.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }



  // Add a new student
  static Future<Student> createStudent(Student student) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 201) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create student');
    }
  }

  // Update a student
  static Future<void> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl${student.id}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }

  // Delete a student
  static Future<void> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id/'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete student');
    }
  }
}

