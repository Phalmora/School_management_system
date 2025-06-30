import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school/services/api_services.dart';
import 'package:school/modelTryConnection.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List<Student>> students;

  // 🔥 CRITICAL: Replace with your actual computer's IP address
  // Run 'ipconfig' (Windows) or 'ifconfig' (Mac/Linux) to find your IP
  // Common patterns: 192.168.1.xxx, 192.168.0.xxx, 10.0.0.xxx
  final studentService = GenericApiService<Student>(
    fromJson: (json) => Student.fromJson(json),
    baseUrl: 'http://192.168.0.102:8000/api/students', // ⚠️ CHANGE THIS!
  );

  /*
  final studentService = GenericApiService<Student>(
    fromJson: (json) => Student.fromJson(json),
    baseUrl: 'http://10.0.2.2:8000/api/students', // 🔥 Use this for Android Emulator
  );

   */
  // Alternative IPs to try (uncomment one that works):
  // For Android Emulator: 'http://10.0.2.2:8000/api/students'
  // Common home networks: 'http://192.168.1.100:8000/api/students'
  // Common office networks: 'http://192.168.0.100:8000/api/students'

  @override
  void initState() {
    super.initState();
    _testMultipleConnections(); // Test different IPs
    students = studentService.fetchAll();
  }

  Future<void> _refreshStudents() async {
    setState(() {
      students = studentService.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshStudents,
          ),
          IconButton(
            icon: Icon(Icons.network_check),
            onPressed: _testMultipleConnections,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshStudents,
        child: FutureBuilder<List<Student>>(
          future: students,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Connecting to Django server...'),
                    SizedBox(height: 8),
                    Text(
                      'Make sure Django is running with:\npython manage.py runserver 0.0.0.0:8000',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Connection Failed',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: Text(
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red[800], fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '🔧 Fix Steps:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('1. Find your computer\'s IP:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('   • Windows: Run "ipconfig"'),
                            Text('   • Mac/Linux: Run "ifconfig"'),
                            SizedBox(height: 8),
                            Text('2. Update Flutter code:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('   • Replace YOUR_ACTUAL_IP with real IP'),
                            Text('   • Example: 192.168.1.100:8000'),
                            SizedBox(height: 8),
                            Text('3. Django server:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('   • Use: python manage.py runserver 0.0.0.0:8000'),
                            Text('   • Check ALLOWED_HOSTS in settings.py'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _testMultipleConnections,
                            icon: Icon(Icons.network_check),
                            label: Text('Test IPs'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _refreshStudents,
                            icon: Icon(Icons.refresh),
                            label: Text('Retry'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              final studentList = snapshot.data!;
              if (studentList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No students found'),
                      Text('Server connected successfully!', style: TextStyle(color: Colors.green)),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshStudents,
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  Container(
                    color: Colors.green[100],
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Connected to Django server ✅'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: studentList.length,
                      itemBuilder: (context, index) {
                        final student = studentList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(student.name[0].toUpperCase()),
                              backgroundColor: student.enrolled ? Colors.green : Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                            title: Text(student.name),
                            subtitle: Text(student.email),
                            trailing: Icon(
                              student.enrolled ? Icons.check_circle : Icons.cancel,
                              color: student.enrolled ? Colors.green : Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text('Something went wrong'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Add Student functionality - TODO')),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _testMultipleConnections() async {
    print('🔍 Testing multiple connection possibilities...');

    // List of common IP patterns to test
    final testIPs = [
      '10.0.2.2:8000',        // Android emulator
      '192.168.1.100:8000',   // Common home router IP
      '192.168.0.100:8000',   // Another common pattern
      '192.168.1.1:8000',     // Router IP
      '127.0.0.1:8000',       // Localhost (should fail for devices)
    ];

    print('📱 Testing from Flutter app to Django server...');

    for (String ip in testIPs) {
      try {
        final url = 'http://$ip/api/students/';
        print('🔄 Testing: $url');

        final response = await http.get(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
        ).timeout(Duration(seconds: 3));

        if (response.statusCode == 200) {
          print('✅ SUCCESS: $url');
          print('📄 Response: ${response.body.substring(0, 100)}...');

          // Show success message to user
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✅ Found working IP: $ip'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 5),
              ),
            );
          }
        } else {
          print('⚠️  HTTP ${response.statusCode}: $url');
        }

      } catch (e) {
        print('❌ FAILED: http://$ip - $e');
      }
    }

    print('🔍 Test completed. Check output above for working IPs.');
  }
}