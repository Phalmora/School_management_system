import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionDocumentsScreen extends StatefulWidget {
  @override
  _AdmissionDocumentsScreenState createState() => _AdmissionDocumentsScreenState();
}

class _AdmissionDocumentsScreenState extends State<AdmissionDocumentsScreen> {
  // Document upload status
  Map<String, bool> documentStatus = {
    'passportPhoto': false,
    'sign':false,
    'birthCertificate': false,
    'transferCertificate': false,
    'previousReportCard': false,
    'idProof': false,
    'casteCertificate': false,
    'medicalCertificate': false,
  };

  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.defaultSpacing),
              child: Column(
                children: [
                  _buildProgressIndicator(4, 4),
                  SizedBox(height: AppTheme.defaultSpacing),
                  Text(
                    'Document Upload',
                    style: AppTheme.FontStyle,
                  ),
                  SizedBox(height: AppTheme.extraLargeSpacing),
                  Card(
                    elevation: AppTheme.cardElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.defaultSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Required Documents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.blue600,
                            ),
                          ),
                          SizedBox(height: AppTheme.mediumSpacing),
                          _buildDocumentTile(
                            title: 'Passport Size Photo',
                            subtitle: 'Recent photograph of the student',
                            isRequired: true,
                            documentKey: 'passportPhoto',
                            icon: Icons.photo_camera,
                          ),
                          _buildDocumentTile(
                            title: 'Sign',
                            subtitle: 'Present Sign of the student.',
                            isRequired: true,
                            documentKey: 'sign',
                            icon: Icons.pending_actions,
                          ),
                          _buildDocumentTile(
                            title: 'Birth Certificate',
                            subtitle: 'Official birth certificate',
                            isRequired: true,
                            documentKey: 'birthCertificate',
                            icon: Icons.article,
                          ),
                          _buildDocumentTile(
                            title: 'ID Proof (Aadhar etc.)',
                            subtitle: 'Government issued ID proof',
                            isRequired: true,
                            documentKey: 'idProof',
                            icon: Icons.badge,
                          ),
                          SizedBox(height: AppTheme.mediumSpacing),
                          Text(
                            'Optional Documents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.blue600,
                            ),
                          ),
                          SizedBox(height: AppTheme.mediumSpacing),
                          _buildDocumentTile(
                            title: 'Transfer Certificate',
                            subtitle: 'From previous school (if applicable)',
                            isRequired: false,
                            documentKey: 'transferCertificate',
                            icon: Icons.school,
                          ),
                          _buildDocumentTile(
                            title: 'Previous Report Card',
                            subtitle: 'Last academic year report',
                            isRequired: false,
                            documentKey: 'previousReportCard',
                            icon: Icons.assessment,
                          ),
                          _buildDocumentTile(
                            title: 'Caste Certificate',
                            subtitle: 'If applicable for reservations',
                            isRequired: false,
                            documentKey: 'casteCertificate',
                            icon: Icons.description,
                          ),
                          _buildDocumentTile(
                            title: 'Medical Certificate',
                            subtitle: 'Health certificate from doctor',
                            isRequired: false,
                            documentKey: 'medicalCertificate',
                            icon: Icons.medical_services,
                          ),
                          SizedBox(height: AppTheme.extraLargeSpacing),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info, color: Colors.blue[600]),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Please ensure all documents are clear and readable. Supported formats: PDF, JPG, PNG (Max 5MB each)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppTheme.extraLargeSpacing),

                          // Terms and Conditions Section
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.blue600,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _acceptedTerms,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _acceptedTerms = value ?? false;
                                        });
                                      },
                                      activeColor: AppTheme.blue600,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                          children: [
                                            TextSpan(text: 'I agree to the '),
                                            WidgetSpan(
                                              child: GestureDetector(
                                                onTap: _showTermsAndConditions,
                                                child: Text(
                                                  'Terms and Conditions',
                                                  style: TextStyle(
                                                    color: AppTheme.blue600,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextSpan(text: ' and '),
                                            WidgetSpan(
                                              child: GestureDetector(
                                                onTap: _showPrivacyPolicy,
                                                child: Text(
                                                  'Privacy Policy',
                                                  style: TextStyle(
                                                    color: AppTheme.blue600,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextSpan(text: ' of the school.'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AppTheme.extraLargeSpacing),
                          Row(
                            children: [
                              Expanded(
                                child: _buildAnimatedButton(
                                  text: 'Back',
                                  onPressed: () => Navigator.pop(context),
                                  isSecondary: true,
                                ),
                              ),
                              SizedBox(width: AppTheme.mediumSpacing),
                              Expanded(
                                child: _buildAnimatedButton(
                                  text: 'Pay Online',
                                  onPressed: _acceptedTerms ? _payOnline : null,
                                ),
                              ),
                            ],

                          ),
                          SizedBox(height: AppTheme.defaultSpacing,),
                          Center(
                            child: _buildAnimatedButton(
                              text: 'Submit Application',
                              onPressed: _acceptedTerms ? _submitApplication : null,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 4,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppTheme.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDocumentTile({
    required String title,
    required String subtitle,
    required bool isRequired,
    required String documentKey,
    required IconData icon,
  }) {
    bool isUploaded = documentStatus[documentKey] ?? false;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isUploaded
                ? Colors.green[100]
                : (isRequired ? Colors.red[100] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isUploaded
                ? Colors.green[600]
                : (isRequired ? Colors.red[600] : Colors.grey[600]),
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(title)),
            if (isRequired)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Required',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.red[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(subtitle),
        trailing: isUploaded
            ? Icon(Icons.check_circle, color: Colors.green[600])
            : Icon(Icons.upload_file, color: Colors.grey[600]),
        onTap: () => _uploadDocument(documentKey),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback? onPressed,
    bool isSecondary = false,
  }) {
    return Container(
      height: AppTheme.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null
              ? Colors.grey[400]
              : (isSecondary ? Colors.grey[300] : AppTheme.blue600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
          ),
          elevation: AppTheme.buttonElevation,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: onPressed == null
                ? Colors.grey[600]
                : (isSecondary ? Colors.grey[700] : Colors.white),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _uploadDocument(String documentKey) {
    // Simulate document upload
    setState(() {
      documentStatus[documentKey] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Document uploaded successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _submitApplication() {
    // Check if all required documents are uploaded
    bool allRequiredUploaded = documentStatus['passportPhoto']! &&
        documentStatus['birthCertificate']! &&
        documentStatus['idProof']!;

    if (!allRequiredUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Please upload all required documents!'),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Please accept Terms & Conditions to proceed!'),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    // Generate student ID and show success popup
    String studentId = _generateStudentId();
    _showSuccessPopup(studentId);
  }

  String _generateStudentId() {
    final now = DateTime.now();
    final year = now.year.toString().substring(2);
    final month = now.month.toString().padLeft(2, '0');
    final random = (1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000).floor();
    return 'STU$year$month$random';
  }

  void _showSuccessPopup(String studentId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Application Submitted!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blue600,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your admission application has been submitted successfully. You will receive a confirmation email shortly.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.blue600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.blue600.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Application ID:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      studentId,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blue600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => _copyToClipboard(studentId),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.blue600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.copy, size: 16, color: AppTheme.blue600),
                    SizedBox(width: 4),
                    Text('Copy ID', style: TextStyle(color: AppTheme.blue600)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please save this ID for future reference and admission status tracking.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

            ],
          ),
          actions: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/student-dashboard',
                          (route) => false
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.blue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Continue to Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _payOnline(){
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Please accept Terms & Conditions to proceed!'),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }
    Navigator.pushNamed(context, '/payment-page');
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Application ID copied to clipboard!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Row(
            children: [
              Icon(Icons.article, color: AppTheme.blue600, size: 24),
              SizedBox(width: 8),
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blue600,
                ),
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTermSection(
                    title: '1. Admission Policy',
                    content: 'Admission to the school is subject to availability of seats and fulfillment of eligibility criteria. The school reserves the right to accept or reject any application without assigning reasons.',
                  ),
                  _buildTermSection(
                    title: '2. Document Verification',
                    content: 'All submitted documents must be original and verified. Any false information or forged documents will lead to immediate cancellation of admission.',
                  ),
                  _buildTermSection(
                    title: '3. Fee Structure',
                    content: 'Fees once paid are non-refundable except in cases explicitly mentioned in the fee refund policy. Fee structure is subject to annual revision as per school policy.',
                  ),
                  _buildTermSection(
                    title: '4. Academic Standards',
                    content: 'Students are expected to maintain the academic and behavioral standards set by the school. Failure to meet these standards may result in disciplinary action.',
                  ),
                  _buildTermSection(
                    title: '5. Health & Safety',
                    content: 'Parents must inform the school about any medical conditions, allergies, or special needs of their child. The school will take necessary precautions but parents are primarily responsible for their child\'s health.',
                  ),
                  _buildTermSection(
                    title: '6. Code of Conduct',
                    content: 'All students and parents must adhere to the school\'s code of conduct. Any violation may result in suspension or expulsion from the school.',
                  ),
                  _buildTermSection(
                    title: '7. Communication',
                    content: 'The school will communicate important information through official channels. Parents are responsible for regularly checking school communications.',
                  ),
                  _buildTermSection(
                    title: '8. Withdrawal Policy',
                    content: 'Parents must provide at least 30 days written notice for withdrawal. Transfer certificates will be issued only after clearing all dues.',
                  ),
                  _buildTermSection(
                    title: '9. Liability',
                    content: 'The school shall not be liable for any loss, damage, or injury to students except in cases of proven negligence by the school staff.',
                  ),
                  _buildTermSection(
                    title: '10. Amendments',
                    content: 'The school reserves the right to modify these terms and conditions at any time. Updated terms will be communicated to all stakeholders.',
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Text(
                      'By accepting these terms, you acknowledge that you have read, understood, and agree to be bound by all the above conditions.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[800],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: AppTheme.blue600, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _acceptedTerms = true;
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                ),
              ),
              child: Text(
                'Accept',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          ),
          title: Row(
            children: [
              Icon(Icons.privacy_tip, color: AppTheme.blue600, size: 24),
              SizedBox(width: 8),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blue600,
                ),
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTermSection(
                    title: '1. Information Collection',
                    content: 'We collect personal information necessary for admission processing, including student and parent details, academic records, and contact information.',
                  ),
                  _buildTermSection(
                    title: '2. Use of Information',
                    content: 'Collected information is used solely for educational purposes, communication with parents, academic record maintenance, and regulatory compliance.',
                  ),
                  _buildTermSection(
                    title: '3. Data Security',
                    content: 'We implement appropriate security measures to protect personal information against unauthorized access, alteration, disclosure, or destruction.',
                  ),
                  _buildTermSection(
                    title: '4. Information Sharing',
                    content: 'Personal information is not shared with third parties except for educational purposes, legal compliance, or with explicit parental consent.',
                  ),
                  _buildTermSection(
                    title: '5. Data Retention',
                    content: 'Student records are retained as per educational regulations and school policy. Data is securely disposed of when no longer required.',
                  ),
                  _buildTermSection(
                    title: '6. Parent Rights',
                    content: 'Parents have the right to access, correct, or request deletion of their child\'s personal information, subject to legal and educational requirements.',
                  ),
                  _buildTermSection(
                    title: '7. Cookies and Tracking',
                    content: 'Our online platforms may use cookies for functionality and analytics. No personal data is shared with external analytics providers.',
                  ),
                  _buildTermSection(
                    title: '8. Updates to Policy',
                    content: 'This privacy policy may be updated periodically. Parents will be notified of significant changes affecting data handling practices.',
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: AppTheme.blue600, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTermSection({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.blue600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}