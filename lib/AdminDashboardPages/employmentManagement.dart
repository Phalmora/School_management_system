import 'package:flutter/material.dart';
import 'package:school/AdminEmployeeManagement/editEmployee.dart';
import 'package:school/AdminEmployeeManagement/teacherDetails.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/dashboard/employeeModel.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              bottom: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              left: AppThemeResponsiveness.getSmallSpacing(context),
              right: AppThemeResponsiveness.getSmallSpacing(context),
            ),
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: AppThemeResponsiveness.getMaxWidth(context),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppThemeColor.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Search and Filter Section
                        _buildSearchSection(context),

                        // Employees Header
                        _buildEmployeesHeader(context),

                        // Employees List/Grid
                        Expanded(
                          child: _buildEmployeesList(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: AppThemeResponsiveness.getMaxWidth(context),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
        ),
        padding: EdgeInsets.symmetric(
          vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.people,
              color: AppThemeColor.white,
              size: AppThemeResponsiveness.getHeaderIconSize(context),
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Flexible(
              child: Text(
                'Employee Management',
                style: AppThemeResponsiveness.getSectionTitleStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(
                    context,
                    AppThemeResponsiveness.getSectionTitleStyle(context).fontSize! + 4,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        color: AppThemeColor.blue50,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            style: AppThemeResponsiveness.getBodyTextStyle(context),
            decoration: InputDecoration(
              hintText: 'Name, ID, email, role, department',
              hintStyle: AppThemeResponsiveness.getInputHintStyle(context),
              prefixIcon: Icon(
                Icons.search,
                color: AppThemeColor.primaryBlue,
                size: AppThemeResponsiveness.getIconSize(context),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppThemeColor.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
                vertical: AppThemeResponsiveness.getMediumSpacing(context),
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Filter by subject: ',
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppThemeColor.blue800,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getSmallSpacing(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppThemeColor.white,
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                    border: Border.all(
                      color: AppThemeColor.blue200,
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: selectedDepartmentFilter,
                    isExpanded: true,
                    underline: Container(),
                    style: AppThemeResponsiveness.getBodyTextStyle(context),
                    items: availableDepartments.map((department) {
                      return DropdownMenuItem(
                        value: department,
                        child: Text(
                          department,
                          style: AppThemeResponsiveness.getBodyTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getDefaultSpacing(context),
        vertical: AppThemeResponsiveness.getMediumSpacing(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Teachers (${filteredEmployees.length})',
            style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
              color: AppThemeColor.primaryBlue,
              fontSize: AppThemeResponsiveness.getResponsiveFontSize(
                context,
                AppThemeResponsiveness.getHeadingStyle(context).fontSize! + 4,
              ),
            ),
          ),
          Icon(
            Icons.school,
            color: AppThemeColor.primaryBlue,
            size: AppThemeResponsiveness.getIconSize(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesList(BuildContext context) {
    if (filteredEmployees.isEmpty) {
      return _buildEmptyState(context);
    }

    return AppThemeResponsiveness.isDesktop(context) || AppThemeResponsiveness.isTablet(context)
        ? _buildEmployeesGrid(context)
        : _buildEmployeesListView(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: AppThemeResponsiveness.getEmptyStateIconSize(context),
            color: Colors.grey.shade400,
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          Text(
            'No teachers found',
            style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
          Text(
            'Try adjusting your search or filter',
            style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppThemeResponsiveness.getGridCrossAxisCount(context),
        crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: AppThemeResponsiveness.getGridChildAspectRatio(context) * 0.7,
      ),
      itemCount: filteredEmployees.length,
      itemBuilder: (context, index) {
        return _buildEmployeeGridCard(context, filteredEmployees[index], index);
      },
    );
  }

  Widget _buildEmployeesListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      itemCount: filteredEmployees.length,
      itemBuilder: (context, index) {
        return _buildEmployeeCard(context, filteredEmployees[index], index);
      },
    );
  }

  Widget _buildEmployeeGridCard(BuildContext context, Employee employee, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppThemeColor.blue50,
            AppThemeColor.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
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
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getGridItemPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppThemeColor.primaryBlue,
                    radius: AppThemeResponsiveness.getIconSize(context) * 0.8,
                    child: Text(
                      employee.name.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: AppThemeColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
                      ),
                    ),
                  ),
                  _buildEmployeePopupMenu(context, employee, index),
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                employee.name,
                style: AppThemeResponsiveness.getGridItemTitleStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
              Text(
                'ID: ${employee.id}',
                style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
              Text(
                '${employee.role}',
                style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
              Text(
                employee.department,
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 12),
                  color: AppThemeColor.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: AppThemeResponsiveness.getIconSize(context) * 0.6,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                  Expanded(
                    child: Text(
                      employee.phone,
                      style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 10),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: AppThemeResponsiveness.getIconSize(context) * 0.6,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                  Expanded(
                    child: Text(
                      employee.email,
                      style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 10),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(BuildContext context, Employee employee, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getMediumSpacing(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppThemeColor.blue50,
            AppThemeColor.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
        leading: CircleAvatar(
          backgroundColor: AppThemeColor.primaryBlue,
          radius: AppThemeResponsiveness.getDashboardCardIconSize(context) * 0.6,
          child: Text(
            employee.name.substring(0, 1).toUpperCase(),
            style: TextStyle(
              color: AppThemeColor.white,
              fontWeight: FontWeight.bold,
              fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
            ),
          ),
        ),
        title: Text(
          employee.name,
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'ID: ${employee.id}',
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
            Text(
              '${employee.role} • ${employee.department}',
              style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: AppThemeResponsiveness.getIconSize(context) * 0.7,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                Expanded(
                  child: Text(
                    employee.phone,
                    style: AppThemeResponsiveness.getBodyTextStyle(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
            Row(
              children: [
                Icon(
                  Icons.email,
                  size: AppThemeResponsiveness.getIconSize(context) * 0.7,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                Expanded(
                  child: Text(
                    employee.email,
                    style: AppThemeResponsiveness.getBodyTextStyle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: _buildEmployeePopupMenu(context, employee, index),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherDetailsPage(teacher: employee),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmployeePopupMenu(BuildContext context, Employee employee, int index) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: AppThemeColor.primaryBlue,
        size: AppThemeResponsiveness.getIconSize(context),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
      ),
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
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'update',
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: AppThemeColor.primaryBlue,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Update',
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              Text(
                'Delete',
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
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
      backgroundColor: AppThemeColor.primaryBlue,
      foregroundColor: AppThemeColor.white,
      elevation: AppThemeResponsiveness.getButtonElevation(context),
      icon: Icon(
        Icons.person_add,
        size: AppThemeResponsiveness.getIconSize(context),
      ),
      label: Text(
        'Add Teacher',
        style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          ),
          title: Text(
            'Delete Teacher',
            style: AppThemeResponsiveness.getHeadingStyle(context),
          ),
          content: Text(
            'Are you sure you want to delete ${filteredEmployees[index].name}?',
            style: AppThemeResponsiveness.getBodyTextStyle(context),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppThemeColor.primaryBlue,
                  fontSize: AppThemeResponsiveness.getButtonTextStyle(context).fontSize,
                ),
              ),
            ),
            SizedBox(
              height: AppThemeResponsiveness.getButtonHeight(context) * 0.8,
              child: ElevatedButton(
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: AppThemeResponsiveness.getButtonTextStyle(context),
                ),
              ),
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