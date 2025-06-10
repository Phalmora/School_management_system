import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

class NoticesMessage extends StatefulWidget {
  const NoticesMessage({super.key});

  @override
  State<NoticesMessage> createState() => _NoticesMessageState();
}

class _NoticesMessageState extends State<NoticesMessage> {
  // Sample data - you can replace this with actual data from your backend
  final List<NoticeItem> notices = [
    NoticeItem(
      icon: Icons.water_drop,
      title: 'Holiday Notice: Possible closure tomorrow due to heavy rainfall',
      time: '2 hours ago',
      color: Colors.blue,
      priority: NoticePriority.high,
    ),
    NoticeItem(
      icon: Icons.people,
      title: 'Parent-Teacher Meeting scheduled for next week',
      time: '1 day ago',
      color: Colors.orange,
      priority: NoticePriority.medium,
    ),
    NoticeItem(
      icon: Icons.payment,
      title: 'Fee Payment Reminder: Due date approaching',
      time: '3 days ago',
      color: Colors.green,
      priority: NoticePriority.low,
    ),
    NoticeItem(
      icon: Icons.announcement,
      title: 'Annual Sports Day registration now open',
      time: '5 days ago',
      color: Colors.purple,
      priority: NoticePriority.medium,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildNoticesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(
            Icons.notifications_active,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'Recent Notices',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${notices.length} new',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticesList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notices.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return _buildNoticeCard(notices[index]);
        },
      ),
    );
  }

  Widget _buildNoticeCard(NoticeItem notice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notice.priority == NoticePriority.high
              ? Colors.red.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: notice.priority == NoticePriority.high ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showNoticeDetails(notice),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            _buildNoticeIcon(notice),
            const SizedBox(width: 16),
            Expanded(
              child: _buildNoticeContent(notice),
            ),
            _buildPriorityIndicator(notice.priority),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeIcon(NoticeItem notice) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: notice.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        notice.icon,
        color: notice.color,
        size: 24,
      ),
    );
  }

  Widget _buildNoticeContent(NoticeItem notice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notice.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 14,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 4),
            Text(
              notice.time,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityIndicator(NoticePriority priority) {
    Color color;
    switch (priority) {
      case NoticePriority.high:
        color = Colors.red;
        break;
      case NoticePriority.medium:
        color = Colors.orange;
        break;
      case NoticePriority.low:
        color = Colors.green;
        break;
    }

    return Container(
      width: 8,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _showNoticeDetails(NoticeItem notice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNoticeDetailsSheet(notice),
    );
  }

  Widget _buildNoticeDetailsSheet(NoticeItem notice) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildNoticeIcon(notice),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        notice.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Posted ${notice.time}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Notice Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This is where you can add more detailed information about the notice. You can include important dates, requirements, contact information, or any other relevant details.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Data models
class NoticeItem {
  final IconData icon;
  final String title;
  final String time;
  final Color color;
  final NoticePriority priority;

  NoticeItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.color,
    required this.priority,
  });
}

enum NoticePriority { high, medium, low }