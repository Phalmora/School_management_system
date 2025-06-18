import 'package:flutter/material.dart';
import 'package:school/customWidgets/theme.dart';

class PrivacyPolicy {
  static void show(BuildContext context) {
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
                children: _getPolicySections(),
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

  static List<Widget> _getPolicySections() {
    final policies = [
      {
        'title': '1. Information Collection',
        'content': 'We collect personal information necessary for admission processing, including student and parent details, academic records, and contact information.',
      },
      {
        'title': '2. Use of Information',
        'content': 'Collected information is used solely for educational purposes, communication with parents, academic record maintenance, and regulatory compliance.',
      },
      {
        'title': '3. Data Security',
        'content': 'We implement appropriate security measures to protect personal information against unauthorized access, alteration, disclosure, or destruction.',
      },
      {
        'title': '4. Information Sharing',
        'content': 'Personal information is not shared with third parties except for educational purposes, legal compliance, or with explicit parental consent.',
      },
      {
        'title': '5. Data Retention',
        'content': 'Student records are retained as per educational regulations and school policy. Data is securely disposed of when no longer required.',
      },
      {
        'title': '6. Parent Rights',
        'content': 'Parents have the right to access, correct, or request deletion of their child\'s personal information, subject to legal and educational requirements.',
      },
      {
        'title': '7. Cookies and Tracking',
        'content': 'Our online platforms may use cookies for functionality and analytics. No personal data is shared with external analytics providers.',
      },
      {
        'title': '8. Updates to Policy',
        'content': 'This privacy policy may be updated periodically. Parents will be notified of significant changes affecting data handling practices.',
      },
      {
        'title': '9. Contact Information',
        'content': 'For any privacy-related questions or concerns, please contact our Data Protection Officer at privacy@school.edu or visit the school administration office.',
      },
      {
        'title': '10. Children\'s Privacy',
        'content': 'We are committed to protecting children\'s privacy and comply with applicable laws regarding the collection and use of information from minors.',
      },
    ];

    return policies.map((policy) => _buildPolicySection(
      title: policy['title']!,
      content: policy['content']!,
    )).toList();
  }

  static Widget _buildPolicySection({required String title, required String content}) {
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

  // Method to get privacy policy as a list for other uses
  static List<Map<String, String>> getPolicyList() {
    return [
      {
        'title': '1. Information Collection',
        'content': 'We collect personal information necessary for admission processing, including student and parent details, academic records, and contact information.',
      },
      {
        'title': '2. Use of Information',
        'content': 'Collected information is used solely for educational purposes, communication with parents, academic record maintenance, and regulatory compliance.',
      },
      {
        'title': '3. Data Security',
        'content': 'We implement appropriate security measures to protect personal information against unauthorized access, alteration, disclosure, or destruction.',
      },
      {
        'title': '4. Information Sharing',
        'content': 'Personal information is not shared with third parties except for educational purposes, legal compliance, or with explicit parental consent.',
      },
      {
        'title': '5. Data Retention',
        'content': 'Student records are retained as per educational regulations and school policy. Data is securely disposed of when no longer required.',
      },
      {
        'title': '6. Parent Rights',
        'content': 'Parents have the right to access, correct, or request deletion of their child\'s personal information, subject to legal and educational requirements.',
      },
      {
        'title': '7. Cookies and Tracking',
        'content': 'Our online platforms may use cookies for functionality and analytics. No personal data is shared with external analytics providers.',
      },
      {
        'title': '8. Updates to Policy',
        'content': 'This privacy policy may be updated periodically. Parents will be notified of significant changes affecting data handling practices.',
      },
      {
        'title': '9. Contact Information',
        'content': 'For any privacy-related questions or concerns, please contact our Data Protection Officer at privacy@school.edu or visit the school administration office.',
      },
      {
        'title': '10. Children\'s Privacy',
        'content': 'We are committed to protecting children\'s privacy and comply with applicable laws regarding the collection and use of information from minors.',
      },
    ];
  }

  // Method to get privacy policy as plain text
  static String getPolicyAsText() {
    final policies = getPolicyList();
    return policies.map((policy) => '${policy['title']}\n${policy['content']}').join('\n\n');
  }
}