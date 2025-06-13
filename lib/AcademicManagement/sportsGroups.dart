import 'package:flutter/material.dart';

class AddSportGroupScreen extends StatefulWidget {
  @override
  _AddSportGroupScreenState createState() => _AddSportGroupScreenState();
}

class _AddSportGroupScreenState extends State<AddSportGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final _coachController = TextEditingController();
  final _maxMembersController = TextEditingController();
  String _selectedSportType = 'Football';
  List<String> _sportTypes = ['Football', 'Basketball', 'Cricket', 'Tennis', 'Swimming', 'Athletics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF42A5F5), Color(0xFF8E24AA)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader('Create Sport Group'),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _buildSportGroupForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 10),
          Icon(Icons.sports_soccer, color: Colors.white, size: 32),
          SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportGroupForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _buildInputField(
              controller: _groupNameController,
              label: 'Group Name',
              hint: 'e.g., Royal Eagles',
              icon: Icons.group,
              validator: (value) => value!.isEmpty ? 'Please enter group name' : null,
            ),
            SizedBox(height: 20),
            _buildSportTypeDropdown(),
            SizedBox(height: 20),
            _buildInputField(
              controller: _coachController,
              label: 'Coach Name',
              hint: 'Assigned coach',
              icon: Icons.person,
              validator: (value) => value!.isEmpty ? 'Please enter coach name' : null,
            ),
            SizedBox(height: 20),
            _buildInputField(
              controller: _maxMembersController,
              label: 'Maximum Members',
              hint: 'Team size limit',
              icon: Icons.people,
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Please enter max members' : null,
            ),
            SizedBox(height: 40),
            _buildSubmitButton('Create Sport Group'),
          ],
        ),
      ),
    );
  }

  Widget _buildSportTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sport Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedSportType,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.sports, color: Color(0xFF42A5F5)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          items: _sportTypes.map((String sport) {
            return DropdownMenuItem<String>(
              value: sport,
              child: Text(sport),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSportType = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Color(0xFF42A5F5)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(String text) {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: () => _submitForm(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF42A5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sport group created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}
