class AdmissionData {
  // Basic Information
  String academicYear;
  String classToAdmit;
  DateTime admissionDate;
  String studentType;
  String fullName;
  String email;
  String phoneNumber;

  // Parent/Guardian Information
  String fatherName;
  String fatherOccupation;
  String motherName;
  String motherOccupation;
  String guardianName;
  String guardianRelationship;
  String guardianContact;

  // Contact & Address Information
  String fullAddress;
  String city;
  String state;
  String zipCode;
  String mobileNumber;
  String parentEmail;
  String alternateContact;

  // Documents (storing file paths/names)
  String passportPhoto;
  String birthCertificate;
  String transferCertificate;
  String previousReportCard;
  String idProof;
  String casteCertificate;
  String medicalCertificate;

  AdmissionData({
    this.academicYear = '2025-2026',
    this.classToAdmit = 'Nursery',
    DateTime? admissionDate,
    this.studentType = 'New',
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.fatherName = '',
    this.fatherOccupation = '',
    this.motherName = '',
    this.motherOccupation = '',
    this.guardianName = '',
    this.guardianRelationship = '',
    this.guardianContact = '',
    this.fullAddress = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.mobileNumber = '',
    this.parentEmail = '',
    this.alternateContact = '',
    this.passportPhoto = '',
    this.birthCertificate = '',
    this.transferCertificate = '',
    this.previousReportCard = '',
    this.idProof = '',
    this.casteCertificate = '',
    this.medicalCertificate = '',
  }) : admissionDate = admissionDate ?? DateTime.now();
}