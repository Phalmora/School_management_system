import 'package:flutter/material.dart';
import 'package:school/AdminEmployeeManagement/editEmployee.dart';
import 'package:school/AdminEmployeeManagement/teacherDetails.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';
import 'package:school/model/employeeModel.dart';


// Main Teacher Management Page
class EmployeeManagementPage extends StatefulWidget {
  @override
  _EmployeeManagementPageState createState() => _EmployeeManagementPageState();
}

class _EmployeeManagementPageState extends State<EmployeeManagementPage> {
  List<Employee> employees = [
    Employee(
      id: 'TCH001',
      name: 'Sarah Johnson',
      role: 'Mathematics Teacher',
      department: 'Mathematics',
      phone: '+91 9876543210',
      email: 'sarah.johnson@school.edu',
    ),
    Employee(
      id: 'TCH002',
      name: 'Michael Davis',
      role: 'English Teacher',
      department: 'English',
      phone: '+91 9876543211',
      email: 'michael.davis@school.edu',
    ),
    Employee(
      id: 'TCH003',
      name: 'Emily Rodriguez',
      role: 'Science Teacher',
      department: 'Science',
      phone: '+91 9876543212',
      email: 'emily.rodriguez@school.edu',
    ),
    Employee(
      id: 'TCH004',
      name: 'David Wilson',
      role: 'Physical Education Teacher',
      department: 'Physical Education',
      phone: '+91 9876543213',
      email: 'david.wilson@school.edu',
    ),
    Employee(
      id: 'TCH005',
      name: 'Lisa Chen',
      role: 'Art Teacher',
      department: 'Arts',
      phone: '+91 9876543214',
      email: 'lisa.chen@school.edu',
    ),
  ];

  List<Employee> filteredEmployees = [];
  TextEditingController searchController = TextEditingController();
  String selectedDepartmentFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredEmployees = employees;
    searchController.addListener(_filterEmployees);
  }

  void _filterEmployees() {
    setState(() {
      filteredEmployees = employees.where((employee) {
        bool matchesSearch = employee.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
            employee.id.toLowerCase().contains(searchController.text.toLowerCase()) ||
            employee.email.toLowerCase().contains(searchController.text.toLowerCase()) ||
            employee.role.toLowerCase().contains(searchController.text.toLowerCase()) ||
            employee.department.toLowerCase().contains(searchController.text.toLowerCase());

        bool matchesDepartment = selectedDepartmentFilter == 'All' ||
            employee.department == selectedDepartmentFilter;

        return matchesSearch && matchesDepartment;
      }).toList();
    });
  }

  List<String> get availableDepartments {
    Set<String> departments = employees.map((e) => e.department).toSet();
    return ['All', ...departments.toList()..sort()];
  }

  String _generateEmployeeId() {
    int nextId = employees.length + 1;
    return 'TCH${nextId.toString().padLeft(3, '0')}';
  }

  void _addEmployee(Employee employee) {
    setState(() {
      employees.add(employee);
      _filterEmployees();
    });
  }

  void _updateEmployee(int index, Employee employee) {
    setState(() {
      int originalIndex = employees.indexWhere((e) => e.id == filteredEmployees[index].id);
      employees[originalIndex] = employee;
      _filterEmployees();
    });
  }

  void _deleteEmployee(int index) {
    setState(() {
      int originalIndex = employees.indexWhere((e) => e.id == filteredEmployees[index].id);
      employees.removeAt(originalIndex);
      _filterEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Search and Filter Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                    padding: EdgeInsets.all(AppTheme.mediumSpacing),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search by name, ID, email, subject, department',
                            hintStyle: TextStyle(fontSize: 12),
                            prefixIcon: Icon(Icons.search, color: AppTheme.primaryBlue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppTheme.blue50,
                          ),
                        ),
                        SizedBox(height: AppTheme.smallSpacing),
                        Row(
                          children: [
                            Text(
                              'Filter by subject: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.blue800,
                              ),
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedDepartmentFilter,
                                isExpanded: true,
                                underline: Container(),
                                items: availableDepartments.map((department) {
                                  return DropdownMenuItem(
                                    value: department,
                                    child: Text(department),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDepartmentFilter = value!;
                                    _filterEmployees();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppTheme.defaultSpacing),

                  // Teacher List
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppTheme.cardBorderRadius),
                          topRight: Radius.circular(AppTheme.cardBorderRadius),
                        ),
                      ),
                      child: Column(
                        children: [
                          // List Header
                          Container(
                            padding: EdgeInsets.all(AppTheme.mediumSpacing),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Teachers (${filteredEmployees.length})',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                Icon(Icons.school, color: AppTheme.primaryBlue),
                              ],
                            ),
                          ),

                          Expanded(
                            child: filteredEmployees.isEmpty
                                ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: AppTheme.smallSpacing),
                                  Text(
                                    'No teachers found',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: AppTheme.smallSpacing),
                                  Text(
                                    'Try adjusting your search or filter',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: AppTheme.mediumSpacing),
                              itemCount: filteredEmployees.length,
                              itemBuilder: (context, index) {
                                final employee = filteredEmployees[index];
                                return Card(
                                  elevation: 3,
                                  margin: EdgeInsets.only(bottom: AppTheme.smallSpacing),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TeacherDetailsPage(teacher: employee),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppTheme.blue50,
                                            AppTheme.white,
                                          ],
                                        ),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(AppTheme.mediumSpacing),
                                        leading: CircleAvatar(
                                          backgroundColor: AppTheme.primaryBlue,
                                          child: Text(
                                            employee.name.substring(0, 1).toUpperCase(),
                                            style: TextStyle(
                                              color: AppTheme.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          employee.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 4),
                                            Text('ID: ${employee.id}'),
                                            Text('${employee.role} • ${employee.department}'),
                                            Text('📞 ${employee.phone}'),
                                            Text('📧 ${employee.email}'),
                                          ],
                                        ),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'update',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit, color: AppTheme.primaryBlue),
                                                  SizedBox(width: 8),
                                                  Text('Update'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete, color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Delete'),
                                                ],
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 'update') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddEditEmployeePage(
                                                    employee: employee,
                                                    employeeIndex: index,
                                                    onSave: (updatedEmployee) => _updateEmployee(index, updatedEmployee),
                                                  ),
                                                ),
                                              );
                                            } else if (value == 'delete') {
                                              _showDeleteDialog(index);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
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

          // Floating Action Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditEmployeePage(
                      employeeId: _generateEmployeeId(),
                      onSave: _addEmployee,
                    ),
                  ),
                );
              },
              backgroundColor: AppTheme.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: Icon(Icons.person_add),
              label: Text(
                'Add Teacher',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Teacher'),
          content: Text('Are you sure you want to delete ${filteredEmployees[index].name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteEmployee(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Teacher deleted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: AppTheme.white,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}