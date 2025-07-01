import 'package:flutter/material.dart';
import 'package:school/CommonLogic/tabBar.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/model/dashboard/NotificationModelAcademicOfficer.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Math Quiz Results',
      message: 'Math Quiz results entered for Class 10-A',
      type: NotificationType.announcement,
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      sender: 'Academic Officer',
      recipients: ['Class 10-A'],
    ),
    NotificationModel(
      id: '2',
      title: 'Attendance Update',
      message: 'Attendance marked for today\'s classes',
      type: NotificationType.general,
      timestamp: DateTime.now().subtract(Duration(hours: 3)),
      sender: 'System',
      recipients: ['All Students'],
    ),
    NotificationModel(
      id: '3',
      title: 'Important Notice',
      message: 'New message from Academic Officer',
      type: NotificationType.urgent,
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
      sender: 'Academic Officer',
      recipients: ['All Students'],
    ),
  ];

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
  }

  List<NotificationModel> getUnreadNotifications() {
    return _notifications.where((n) => !n.isRead).toList();
  }
}


class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  final NotificationService _notificationService = NotificationService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              CustomTabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Inbox'),
                  Tab(text: 'Send'),
                ],
                getSpacing: AppThemeResponsiveness.getDefaultSpacing,
                getBorderRadius: AppThemeResponsiveness.getInputBorderRadius,
                getFontSize: AppThemeResponsiveness.getTabFontSize,
                backgroundColor: AppThemeColor.blue50,
                selectedColor: AppThemeColor.primaryBlue,
                unselectedColor: AppThemeColor.blue600,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildNotificationsList(),
                    _buildSendNotificationTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(AppThemeColor.defaultSpacing),
      child: Row(
        children: [
          SizedBox(width: AppThemeColor.smallSpacing),
          Icon(
            Icons.notifications,
            color: AppThemeColor.white,
            size: AppThemeColor.extraLargeSpacing,
          ),
          SizedBox(width: AppThemeColor.mediumSpacing),
          Text(
            'Notifications',
            style: AppThemeResponsiveness.FontStyle,
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '${_notificationService.getUnreadNotifications().length}',
              style: TextStyle(
                color: AppThemeColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return Container(
      margin: EdgeInsets.all(AppThemeColor.defaultSpacing),
      child: ListView.builder(
        itemCount: _notificationService.notifications.length,
        itemBuilder: (context, index) {
          final notification = _notificationService.notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return Container(
      margin: EdgeInsets.only(bottom: AppThemeColor.mediumSpacing),
      child: Card(
        elevation: AppThemeColor.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeColor.cardBorderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppThemeColor.cardBorderRadius),
          onTap: () {
            _notificationService.markAsRead(notification.id);
            setState(() {});
            _showNotificationDetails(notification);
          },
          child: Container(
            padding: EdgeInsets.all(AppThemeColor.mediumSpacing),
            child: Row(
              children: [
                _buildNotificationIcon(notification.type),
                SizedBox(width: AppThemeColor.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: notification.isRead
                                    ? Colors.grey.shade600
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppThemeColor.primaryBlue,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 4),
                          Text(
                            notification.sender,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationType type) {
    IconData iconData;
    Color backgroundColor;

    switch (type) {
      case NotificationType.announcement:
        iconData = Icons.campaign;
        backgroundColor = AppThemeColor.primaryIndigo;
        break;
      case NotificationType.testDate:
        iconData = Icons.quiz;
        backgroundColor = Colors.orange;
        break;
      case NotificationType.holiday:
        iconData = Icons.event;
        backgroundColor = Colors.green;
        break;
      case NotificationType.assignment:
        iconData = Icons.assignment;
        backgroundColor = AppThemeColor.blue600;
        break;
      case NotificationType.urgent:
        iconData = Icons.priority_high;
        backgroundColor = Colors.red;
        break;
      default:
        iconData = Icons.info;
        backgroundColor = AppThemeColor.primaryBlue;
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(
        iconData,
        color: AppThemeColor.white,
        size: 24,
      ),
    );
  }

  Widget _buildSendNotificationTab() {
    return Container(
      margin: EdgeInsets.all(AppThemeColor.defaultSpacing),
      child: SendNotificationForm(),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeColor.cardBorderRadius),
        ),
        title: Text(notification.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            SizedBox(height: AppThemeColor.mediumSpacing),
            Text(
              'From: ${notification.sender}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppThemeColor.primaryBlue,
              ),
            ),
            Text(
              'Time: ${_formatTimestamp(notification.timestamp)}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            if (notification.recipients.isNotEmpty) ...[
              SizedBox(height: AppThemeColor.smallSpacing),
              Text(
                'Recipients: ${notification.recipients.join(', ')}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

// send_notification_form.dart
class SendNotificationForm extends StatefulWidget {
  @override
  _SendNotificationFormState createState() => _SendNotificationFormState();
}

class _SendNotificationFormState extends State<SendNotificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  NotificationType _selectedType = NotificationType.general;
  String _selectedRecipient = 'All Students';

  final List<String> _recipientOptions = [
    'All Students',
    'All Teachers',
    'Class 10-A',
    'Class 10-B',
    'Class 9-A',
    'Class 9-B',
    'Parents',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppThemeColor.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeColor.cardBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeColor.defaultSpacing),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Send Notification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppThemeColor.primaryBlue,
                ),
              ),
              SizedBox(height: AppThemeColor.defaultSpacing),

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppThemeColor.inputBorderRadius),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppThemeColor.mediumSpacing),

              // Message Field
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Message',
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppThemeColor.inputBorderRadius),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppThemeColor.mediumSpacing),

              // Notification Type Dropdown
              DropdownButtonFormField<NotificationType>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: 'Type',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppThemeColor.inputBorderRadius),
                  ),
                ),
                items: NotificationType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getTypeDisplayName(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              SizedBox(height: AppThemeColor.mediumSpacing),

              // Recipients Dropdown
              DropdownButtonFormField<String>(
                value: _selectedRecipient,
                decoration: InputDecoration(
                  labelText: 'Recipients',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppThemeColor.inputBorderRadius),
                  ),
                ),
                items: _recipientOptions.map((recipient) {
                  return DropdownMenuItem(
                    value: recipient,
                    child: Text(recipient),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRecipient = value!;
                  });
                },
              ),
              SizedBox(height: AppThemeColor.defaultSpacing),

              // Send Button
              ElevatedButton(
                onPressed: _sendNotification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeColor.primaryBlue,
                  foregroundColor: AppThemeColor.white,
                  elevation: AppThemeColor.buttonElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeColor.buttonBorderRadius),
                  ),
                  minimumSize: Size(double.infinity, AppThemeColor.buttonHeight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: AppThemeColor.smallSpacing),
                    Text(
                      'Send Notification',
                      style: AppThemeResponsiveness.getButtonTextStyle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTypeDisplayName(NotificationType type) {
    switch (type) {
      case NotificationType.announcement:
        return 'Announcement';
      case NotificationType.testDate:
        return 'Test Date';
      case NotificationType.holiday:
        return 'Holiday';
      case NotificationType.assignment:
        return 'Assignment';
      case NotificationType.urgent:
        return 'Urgent';
      case NotificationType.general:
        return 'General';
    }
  }

  void _sendNotification() {
    if (_formKey.currentState!.validate()) {
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        message: _messageController.text,
        type: _selectedType,
        timestamp: DateTime.now(),
        sender: 'You', // In a real app, this would be the current user
        recipients: [_selectedRecipient],
      );

      NotificationService().addNotification(notification);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notification sent successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeColor.inputBorderRadius),
          ),
        ),
      );

      // Clear form
      _titleController.clear();
      _messageController.clear();
      setState(() {
        _selectedType = NotificationType.general;
        _selectedRecipient = 'All Students';
      });
    }
  }
}

// messages_card.dart (for the main dashboard)
class MessagesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unreadCount = NotificationService().getUnreadNotifications().length;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppThemeColor.white,
          borderRadius: BorderRadius.circular(AppThemeColor.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: AppThemeColor.cardElevation,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppThemeColor.defaultSpacing),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.message,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: TextStyle(
                            color: AppThemeColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: AppThemeColor.smallSpacing),
              Text(
                'Messages',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Announcements & messages',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}