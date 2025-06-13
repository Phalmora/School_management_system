// Add House Group Screen
import 'package:flutter/material.dart';

class AddHouseGroupScreen extends StatefulWidget {
  @override
  _AddHouseGroupScreenState createState() => _AddHouseGroupScreenState();
}

class _AddHouseGroupScreenState extends State<AddHouseGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _houseNameController = TextEditingController();
  final _captainController = TextEditingController();
  final _viceCaptainController = TextEditingController();
  String _selectedColor = 'Red';
  List<String> _houseColors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'];

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
              _buildHeader('Create House Group'),
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
                  child: _buildHouseGroupForm(),
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
          Icon(Icons.home, color: Colors.white, size: 32),
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

  Widget _buildHouseGroupForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _buildInputField(
              controller: _houseNameController,
              label: 'House Name',
              hint: 'e.g., Phoenix House',
              icon: Icons.home,
              validator: (value) => value!.isEmpty ? 'Please enter house name' : null,
            ),
            SizedBox(height: 20),
            _buildColorDropdown(),
            SizedBox(height: 20),
            _buildInputField(
              controller: _captainController,
              label: 'House Captain',
              hint: 'Captain name',
              icon: Icons.person,
              validator: (value) => value!.isEmpty ? 'Please enter captain name' : null,
            ),
            SizedBox(height: 20),
            _buildInputField(
              controller: _viceCaptainController,
              label: 'Vice Captain',
              hint: 'Vice captain name',
              icon: Icons.person_outline,
              validator: (value) => value!.isEmpty ? 'Please enter vice captain name' : null,
            ),
            SizedBox(height: 40),
            _buildSubmitButton('Create House Group'),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'House Color',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedColor,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.palette, color: Color(0xFF42A5F5)),
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
          items: _houseColors.map((String color) {
            return DropdownMenuItem<String>(
              value: color,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _getColorFromString(color),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(color),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedColor = newValue!;
            });
          },
        ),
      ],
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
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
          content: Text('House group created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}

