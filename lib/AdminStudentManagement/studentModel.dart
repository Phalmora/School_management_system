class Student {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String className;
  final String admissionStatus;
  final DateTime dateOfBirth;
  final String address;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
    required this.admissionStatus,
    required this.dateOfBirth,
    required this.address,
  });

  // Optional: Add copyWith method for easier updates
  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? className,
    String? admissionStatus,
    DateTime? dateOfBirth,
    String? address,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      className: className ?? this.className,
      admissionStatus: admissionStatus ?? this.admissionStatus,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
    );
  }

  // Optional: Add toJson and fromJson methods for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'className': className,
      'admissionStatus': admissionStatus,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'address': address,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      className: json['className'],
      admissionStatus: json['admissionStatus'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      address: json['address'],
    );
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, email: $email, phone: $phone, className: $className, admissionStatus: $admissionStatus, dateOfBirth: $dateOfBirth, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}