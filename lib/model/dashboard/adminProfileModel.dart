class AdminProfile {
  final String name;
  final String email;
  final String phone;
  final String employeeId;
  final String designation;
  final String department;
  final String experience;
  final String qualification;
  final String address;
  final String joinDate;
  final List<String> permissions;
  final int totalTeachers;
  final int totalStudents;
  final int totalClasses;
  final double schoolRating;
  final String profileImageUrl;

  AdminProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.employeeId,
    required this.designation,
    required this.department,
    required this.experience,
    required this.qualification,
    required this.address,
    required this.joinDate,
    required this.permissions,
    required this.totalTeachers,
    required this.totalStudents,
    required this.totalClasses,
    required this.schoolRating,
    required this.profileImageUrl,
  });

  // Factory constructor for creating AdminProfile from JSON
  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      employeeId: json['employeeId'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      experience: json['experience'] ?? '',
      qualification: json['qualification'] ?? '',
      address: json['address'] ?? '',
      joinDate: json['joinDate'] ?? '',
      permissions: List<String>.from(json['permissions'] ?? []),
      totalTeachers: json['totalTeachers'] ?? 0,
      totalStudents: json['totalStudents'] ?? 0,
      totalClasses: json['totalClasses'] ?? 0,
      schoolRating: (json['schoolRating'] ?? 0.0).toDouble(),
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }

  // Method to convert AdminProfile to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'employeeId': employeeId,
      'designation': designation,
      'department': department,
      'experience': experience,
      'qualification': qualification,
      'address': address,
      'joinDate': joinDate,
      'permissions': permissions,
      'totalTeachers': totalTeachers,
      'totalStudents': totalStudents,
      'totalClasses': totalClasses,
      'schoolRating': schoolRating,
      'profileImageUrl': profileImageUrl,
    };
  }

  // Method to create a copy with updated values
  AdminProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? employeeId,
    String? designation,
    String? department,
    String? experience,
    String? qualification,
    String? address,
    String? joinDate,
    List<String>? permissions,
    int? totalTeachers,
    int? totalStudents,
    int? totalClasses,
    double? schoolRating,
    String? profileImageUrl,
  }) {
    return AdminProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      employeeId: employeeId ?? this.employeeId,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      experience: experience ?? this.experience,
      qualification: qualification ?? this.qualification,
      address: address ?? this.address,
      joinDate: joinDate ?? this.joinDate,
      permissions: permissions ?? this.permissions,
      totalTeachers: totalTeachers ?? this.totalTeachers,
      totalStudents: totalStudents ?? this.totalStudents,
      totalClasses: totalClasses ?? this.totalClasses,
      schoolRating: schoolRating ?? this.schoolRating,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}