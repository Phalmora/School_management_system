import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:school/Admission/privacyPolicy.dart';
import 'package:school/Admission/termsAndCondition.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class AdmissionDocumentsScreen extends StatefulWidget {
  @override
  _AdmissionDocumentsScreenState createState() => _AdmissionDocumentsScreenState();
}

class _AdmissionDocumentsScreenState extends State<AdmissionDocumentsScreen> {
  // Document upload status and file paths
  Map<String, bool> documentStatus = {
    'passportPhoto': false,
    'sign': false,
    'birthCertificate': false,
    'transferCertificate': false,
    'previousReportCard': false,
    'idProof': false,
    'casteCertificate': false,
    'medicalCertificate': false,
  };

  // Store selected files
  Map<String, PlatformFile?> selectedFiles = {
    'passportPhoto': null,
    'sign': null,
    'birthCertificate': null,
    'transferCertificate': null,
    'previousReportCard': null,
    'idProof': null,
    'casteCertificate': null,
    'medicalCertificate': null,
  };

  bool _acceptedTerms = false;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox( // Changed to ConstrainedBox for consistency
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                padding: AppTheme.getScreenPadding(context),
                child: Column(
                  children: [
                    _buildProgressIndicator(4, 4),
                    SizedBox(height: AppTheme.getDefaultSpacing(context)),
                    Text(
                      'Document Upload',
                      style: AppTheme.getFontStyle(context),
                    ),
                    SizedBox(height: AppTheme.getSmallSpacing(context)), // Consistent spacing
                    Text(
                      'Please upload all necessary documents for admission', // Added subtitle for consistency
                      style: AppTheme.getSplashSubtitleStyle(context),
                    ),
                    SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                    Card(
                      elevation: AppTheme.getCardElevation(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
                      ),
                      child: Padding( // Changed to Padding for consistency
                        padding: AppTheme.getCardPadding(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('Required Documents'),
                            SizedBox(height: AppTheme.getMediumSpacing(context)),
                            _buildDocumentTile(
                              title: 'Passport Size Photo',
                              subtitle: 'Recent photograph of the student',
                              isRequired: true,
                              documentKey: 'passportPhoto',
                              icon: Icons.photo_camera,
                              allowedTypes: ['jpg', 'jpeg', 'png'],
                            ),
                            _buildDocumentTile(
                              title: 'Sign',
                              subtitle: 'Present Sign of the student.',
                              isRequired: true,
                              documentKey: 'sign',
                              icon: Icons.pending_actions,
                              allowedTypes: ['jpg', 'jpeg', 'png'],
                            ),
                            _buildDocumentTile(
                              title: 'Birth Certificate',
                              subtitle: 'Official birth certificate',
                              isRequired: true,
                              documentKey: 'birthCertificate',
                              icon: Icons.article,
                              allowedTypes: ['pdf', 'jpg', 'jpeg', 'png'],
                            ),
                            _buildDocumentTile(
                              title: 'ID Proof (Aadhar etc.)',
                              subtitle: 'Government issued ID proof',
                              isRequired: true,
                              documentKey: 'idProof',
                              icon: Icons.badge,
                              allowedTypes: ['pdf', 'jpg', 'jpeg', 'png'],
                            ),
                            SizedBox(height: AppTheme.getExtraLargeSpacing(context)), // Consistent spacing
                            _buildSectionHeader('Optional Documents'),
                            SizedBox(height: AppTheme.getMediumSpacing(context)),
                            _buildDocumentTile(
                              title: 'Transfer Certificate',
                              subtitle: 'From previous school (if applicable)',
                              isRequired: false,
                              documentKey: 'transferCertificate',
                              icon: Icons.school,
                              allowedTypes: ['pdf', 'jpg', 'jpeg', 'png'],
                            ),
                            _buildDocumentTile(
                              title: 'Previous Report Card',
                              subtitle: 'Last academic year report',
                              isRequired: false,
                              documentKey: 'previousReportCard',
                              icon: Icons.assessment,
                              allowedTypes: ['pdf', 'jpg', 'jpeg', 'png'],
                            ),
                            _buildDocumentTile(
                              title: 'Caste Certificate',
                              subtitle: 'If applicable for reservations',
                              isRequired: false,
                              documentKey: 'casteCertificate',
                              icon: Icons.description,
                              allowedTypes: ['pdf', 'jpg', 'jpeg', 'png'],
                            ),
                            _buildDocumentTile(
                              title: 'Medical Certificate',
                              subtitle: 'Health certificate from doctor',
                              isRequired: false,
                              documentKey: 'medicalCertificate',
                              icon: Icons.medical_services,
                              allowedTypes: ['pdf', 'jpg', 'jpeg', 'png'],
                            ),
                            SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                            _buildInfoContainer(),
                            SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                            _buildTermsAndConditionsSection(),
                            SizedBox(height: AppTheme.getExtraLargeSpacing(context)),
                            _buildNavigationButtons(),
                            SizedBox(height: AppTheme.getDefaultSpacing(context)),
                            _buildSubmitButton(),
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
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep, int totalSteps) {
    return Container(
      padding: AppTheme.getVerticalPadding(context),
      child: Row(
        children: List.generate(totalSteps, (index) {
          bool isCompleted = index < currentStep;
          bool isCurrent = index == currentStep - 1;

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppTheme.getSmallSpacing(context) / 4, // Consistent margin
              ),
              height: AppTheme.isMobile(context) ? 4 : 6,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppTheme.blue600
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(AppTheme.isMobile(context) ? 2 : 3),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding( // Added Padding for consistency with contact screen
      padding: EdgeInsets.only(bottom: AppTheme.getSmallSpacing(context)),
      child: Text(
        title,
        style: AppTheme.getHeadingStyle(context).copyWith(
          color: AppTheme.blue600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDocumentTile({
    required String title,
    required String subtitle,
    required bool isRequired,
    required String documentKey,
    required IconData icon,
    required List<String> allowedTypes,
  }) {
    bool isUploaded = documentStatus[documentKey] ?? false;
    PlatformFile? selectedFile = selectedFiles[documentKey];

    return Card(
      margin: EdgeInsets.only(bottom: AppTheme.getMediumSpacing(context)),
      elevation: AppTheme.isMobile(context) ? 2 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppTheme.getDefaultSpacing(context), // Consistent padding
              vertical: AppTheme.getMediumSpacing(context), // Adjusted for better spacing
            ),
            leading: Container(
              padding: EdgeInsets.all(AppTheme.getSmallSpacing(context)),
              decoration: BoxDecoration(
                color: isUploaded
                    ? Colors.green[100]
                    : (isRequired ? Colors.red[100] : Colors.grey[100]),
                borderRadius: BorderRadius.circular(AppTheme.getSmallSpacing(context)),
              ),
              child: Icon(
                icon,
                size: AppTheme.getIconSize(context),
                color: isUploaded
                    ? Colors.green[600]
                    : (isRequired ? Colors.red[600] : Colors.grey[600]),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.getSubHeadingStyle(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                if (isRequired)
                  Container(
                    padding: AppTheme.getStatusBadgePadding(context),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    ),
                    child: Text(
                      'Required',
                      style: TextStyle(
                        fontSize: AppTheme.getStatusBadgeFontSize(context),
                        color: Colors.red[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppTheme.getSmallSpacing(context) / 2),
                  child: Text(
                    subtitle,
                    style: AppTheme.getCaptionTextStyle(context),
                  ),
                ),
                if (selectedFile != null)
                  Padding(
                    padding: EdgeInsets.only(top: AppTheme.getSmallSpacing(context) / 2),
                    child: Text(
                      'Selected: ${selectedFile.name}',
                      style: AppTheme.getCaptionTextStyle(context).copyWith(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedFile != null && !_isUploading)
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red[600],
                      size: AppTheme.getIconSize(context) * 0.9,
                    ),
                    onPressed: () => _removeDocument(documentKey),
                  ),
                Icon(
                  isUploaded ? Icons.check_circle :
                  (_isUploading && selectedFile != null) ? Icons.hourglass_empty : Icons.upload_file,
                  size: AppTheme.getIconSize(context),
                  color: isUploaded ? Colors.green[600] : Colors.grey[600],
                ),
              ],
            ),
            onTap: _isUploading ? null : () => _uploadDocument(documentKey, allowedTypes),
          ),
          if (selectedFile != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.getDefaultSpacing(context),
                vertical: AppTheme.getSmallSpacing(context),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.getInputBorderRadius(context)),
                  bottomRight: Radius.circular(AppTheme.getInputBorderRadius(context)),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getFileIcon(selectedFile.extension ?? ''),
                    size: AppTheme.getIconSize(context) * 0.8,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: AppTheme.getSmallSpacing(context)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedFile.name,
                          style: AppTheme.getCaptionTextStyle(context).copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${_formatFileSize(selectedFile.size)} • ${selectedFile.extension?.toUpperCase()}',
                          style: AppTheme.getCaptionTextStyle(context).copyWith(
                            fontSize: AppTheme.getCaptionTextStyle(context).fontSize! * 0.9,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer() {
    return Container(
      padding: AppTheme.getCardPadding(context),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info,
            color: Colors.blue[600],
            size: AppTheme.getIconSize(context),
          ),
          SizedBox(width: AppTheme.getMediumSpacing(context)),
          Expanded(
            child: Text(
              'Please ensure all documents are clear and readable. Supported formats: PDF, JPG, PNG (Max 5MB each)',
              style: AppTheme.getBodyTextStyle(context).copyWith(
                color: Colors.blue[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditionsSection() {
    return Container(
      padding: AppTheme.getCardPadding(context),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terms & Conditions',
            style: AppTheme.getHeadingStyle(context).copyWith(
              color: AppTheme.blue600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.getMediumSpacing(context)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Padding(
                  padding: EdgeInsets.only(top: AppTheme.getSmallSpacing(context)),
                  child: RichText(
                    text: TextSpan(
                      style: AppTheme.getBodyTextStyle(context).copyWith(
                        color: Colors.grey[700],
                      ),
                      children: [
                        TextSpan(text: 'I agree to the '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: _showTermsAndConditions,
                            child: Text(
                              'Terms and Conditions',
                              style: AppTheme.getBodyTextStyle(context).copyWith(
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
                              style: AppTheme.getBodyTextStyle(context).copyWith(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Back',
              onPressed: () => Navigator.pop(context),
              isSecondary: true,
            ),
          ),
        ),
        SizedBox(width: AppTheme.getMediumSpacing(context)),
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: _buildAnimatedButton(
              text: 'Pay Online',
              onPressed: _acceptedTerms && !_isUploading ? _payOnline : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: AppTheme.getButtonHeight(context),
      child: _buildAnimatedButton(
        text: _isUploading ? 'Processing...' : 'Submit Application',
        onPressed: _acceptedTerms && !_isUploading ? _submitApplication : null,
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback? onPressed,
    bool isSecondary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null
            ? Colors.grey[400]
            : (isSecondary ? Colors.grey[300] : AppTheme.blue600),
        foregroundColor: onPressed == null
            ? Colors.grey[600] // Consistent disabled text color
            : (isSecondary ? Colors.black87 : Colors.white), // Matched secondary button text color
        elevation: AppTheme.getButtonElevation(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
      ),
      child: _isUploading && !isSecondary && onPressed != null
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: AppTheme.getSmallSpacing(context)),
          Text(
            text,
            style: AppTheme.getButtonTextStyle(context).copyWith(
              color: Colors.white,
            ),
          ),
        ],
      )
          : Text(
        text,
        style: AppTheme.getButtonTextStyle(context).copyWith(
          color: onPressed == null
              ? Colors.grey[600]
              : (isSecondary ? Colors.black87 : Colors.white), // Matched secondary button text color
        ),
      ),
    );
  }

  Future<void> _uploadDocument(String documentKey, List<String> allowedTypes) async {
    try {
      setState(() {
        _isUploading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedTypes,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        // Check file size (5MB limit)
        if (file.size > 5 * 1024 * 1024) {
          _showSnackBar(
            'File size exceeds 5MB limit. Please choose a smaller file.',
            Colors.orange,
            Icons.warning,
          );
          return;
        }

        // Store the selected file
        setState(() {
          selectedFiles[documentKey] = file;
          documentStatus[documentKey] = true;
        });

        _showSnackBar(
          'Document selected successfully!',
          Colors.green,
          Icons.check_circle,
        );
      }
    } catch (e) {
      _showSnackBar(
        'Error selecting document: ${e.toString()}',
        Colors.red,
        Icons.error,
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _removeDocument(String documentKey) {
    setState(() {
      selectedFiles[documentKey] = null;
      documentStatus[documentKey] = false;
    });

    _showSnackBar(
      'Document removed successfully!',
      Colors.orange,
      Icons.info,
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.description;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  void _submitApplication() {
    // Check if all required documents are uploaded
    bool allRequiredUploaded = documentStatus['passportPhoto']! &&
        documentStatus['sign']! &&
        documentStatus['birthCertificate']! &&
        documentStatus['idProof']!;

    if (!allRequiredUploaded) {
      _showSnackBar(
        'Please upload all required documents!',
        Colors.orange,
        Icons.warning,
      );
      return;
    }

    if (!_acceptedTerms) {
      _showSnackBar(
        'Please accept Terms & Conditions to proceed!',
        Colors.orange,
        Icons.warning,
      );
      return;
    }

    // Here you would typically upload the files to your server
    // For now, we'll simulate the process
    _processApplicationSubmission();
  }

  Future<void> _processApplicationSubmission() async {
    setState(() {
      _isUploading = true;
    });

    try {
      // Simulate file upload process
      await Future.delayed(Duration(seconds: 2));

      // Generate student ID and show success popup
      String studentId = _generateStudentId();
      _showSuccessPopup(studentId);
    } catch (e) {
      _showSnackBar(
        'Error submitting application: ${e.toString()}',
        Colors.red,
        Icons.error,
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _payOnline() {
    if (!_acceptedTerms) {
      _showSnackBar(
        'Please accept Terms & Conditions to proceed!',
        Colors.orange,
        Icons.warning,
      );
      return;
    }
    Navigator.pushNamed(context, '/payment-page');
  }

  void _showSnackBar(String message, Color backgroundColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: AppTheme.getIconSize(context) * 0.8),
            SizedBox(width: AppTheme.getSmallSpacing(context)),
            Expanded(
              child: Text(
                message,
                style: AppTheme.getBodyTextStyle(context).copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
      ),
    );
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
            borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: AppTheme.getHeaderIconSize(context),
              ),
              SizedBox(width: AppTheme.getSmallSpacing(context)),
              Expanded(
                child: Text(
                  'Application Submitted!',
                  style: AppTheme.getHeadingStyle(context).copyWith(
                    color: AppTheme.blue600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Container(
            width: AppTheme.getDialogWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your admission application has been submitted successfully. You will receive a confirmation email shortly.',
                  style: AppTheme.getBodyTextStyle(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppTheme.getMediumSpacing(context)),
                Container(
                  padding: AppTheme.getCardPadding(context),
                  decoration: BoxDecoration(
                    color: AppTheme.blue600.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
                    border: Border.all(
                      color: AppTheme.blue600.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Application ID:',
                        style: AppTheme.getCaptionTextStyle(context),
                      ),
                      SizedBox(height: AppTheme.getSmallSpacing(context)),
                      Text(
                        studentId,
                        style: AppTheme.getStatValueStyle(context).copyWith(
                          color: AppTheme.blue600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.getSmallSpacing(context)),
                OutlinedButton(
                  onPressed: () => _copyToClipboard(studentId),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.blue600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.copy,
                        size: AppTheme.getIconSize(context) * 0.7,
                        color: AppTheme.blue600,
                      ),
                      SizedBox(width: AppTheme.getSmallSpacing(context) / 2),
                      Text(
                        'Copy ID',
                        style: AppTheme.getBodyTextStyle(context).copyWith(
                          color: AppTheme.blue600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.getSmallSpacing(context)),
                Text(
                  'Please save this ID for future reference and admission status tracking.',
                  style: AppTheme.getCaptionTextStyle(context).copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            Container(
              width: double.infinity,
              height: AppTheme.getButtonHeight(context),
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
                    borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                  ),
                ),
                child: Text(
                  'Continue to Dashboard',
                  style: AppTheme.getButtonTextStyle(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(
      'Application ID copied to clipboard!',
      Colors.green,
      Icons.check_circle,
    );
  }

  // Show Terms and Conditions dialog
  void _showTermsAndConditions() {
    TermsAndConditions.show(context);
  }

  // Show Privacy Policy dialog
  void _showPrivacyPolicy() {
    PrivacyPolicy.show(context);
  }
}