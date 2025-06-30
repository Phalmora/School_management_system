import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';
import 'package:school/customWidgets/pagesMainHeading.dart';

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
      description: 'Due to heavy rainfall warnings issued by the meteorological department, the school may remain closed tomorrow. Please stay tuned for further updates.',
    ),
    NoticeItem(
      icon: Icons.people,
      title: 'Parent-Teacher Meeting scheduled for next week',
      time: '1 day ago',
      color: Colors.orange,
      priority: NoticePriority.medium,
      description: 'The Parent-Teacher meeting is scheduled for next week on Saturday. Please confirm your attendance by calling the school office.',
    ),
    NoticeItem(
      icon: Icons.payment,
      title: 'Fee Payment Reminder: Due date approaching',
      time: '3 days ago',
      color: Colors.green,
      priority: NoticePriority.low,
      description: 'This is a friendly reminder that the school fee payment due date is approaching. Please clear your dues to avoid late fees.',
    ),
    NoticeItem(
      icon: Icons.announcement,
      title: 'Annual Sports Day registration now open',
      time: '5 days ago',
      color: Colors.purple,
      priority: NoticePriority.medium,
      description: 'Registration for Annual Sports Day is now open. Students can register for various events through their class teachers.',
    ),
    NoticeItem(
      icon: Icons.book,
      title: 'New Library Books Available',
      time: '1 week ago',
      color: Colors.teal,
      priority: NoticePriority.low,
      description: 'New collection of books has arrived in the school library. Students are encouraged to explore and borrow books.',
    ),
    NoticeItem(
      icon: Icons.health_and_safety,
      title: 'Health Checkup Camp Next Month',
      time: '1 week ago',
      color: Colors.red,
      priority: NoticePriority.medium,
      description: 'A comprehensive health checkup camp will be organized next month for all students. More details will be shared soon.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              bottom: AppThemeResponsiveness.getDashboardVerticalPadding(context),
              left: AppThemeResponsiveness.getSmallSpacing(context),
              right: AppThemeResponsiveness.getSmallSpacing(context),
            ),
            child: Column(
              children: [
                HeaderSection(
                  title: 'Recent Notices',
                  icon: Icons.notifications_active,
                ),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: AppThemeResponsiveness.getMaxWidth(context),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppThemeColor.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildNoticesHeader(context),
                        Expanded(
                          child: _buildNoticesList(context),
                        ),
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildNoticesHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppThemeColor.primaryBlue.withOpacity(0.1),
            AppThemeColor.primaryIndigo.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          topRight: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppThemeResponsiveness.getQuickStatsIconPadding(context)),
            decoration: BoxDecoration(
              color: AppThemeColor.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.notifications_active,
              color: AppThemeColor.primaryBlue,
              size: AppThemeResponsiveness.getIconSize(context),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications Center',
                  style: AppThemeResponsiveness.getHeadingStyle(context),
                ),
                SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                Text(
                  'Stay updated with latest announcements',
                  style: AppThemeResponsiveness.getSubHeadingStyle(context),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppThemeResponsiveness.getMediumSpacing(context),
              vertical: AppThemeResponsiveness.getSmallSpacing(context),
            ),
            decoration: BoxDecoration(
              color: AppThemeColor.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppThemeColor.primaryBlue.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              '${notices.length} notices',
              style: TextStyle(
                color: AppThemeColor.primaryBlue,
                fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticesList(BuildContext context) {
    // Determine layout based on screen size
    if (AppThemeResponsiveness.isDesktop(context) || AppThemeResponsiveness.isTablet(context)) {
      return _buildNoticesGrid(context);
    } else {
      return _buildNoticesListView(context);
    }
  }

  Widget _buildNoticesGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppThemeResponsiveness.getGridCrossAxisCount(context),
        crossAxisSpacing: AppThemeResponsiveness.getDashboardGridCrossAxisSpacing(context),
        mainAxisSpacing: AppThemeResponsiveness.getDashboardGridMainAxisSpacing(context),
        childAspectRatio: AppThemeResponsiveness.isDesktop(context) ? 1.4 : 1.2,
      ),
      itemCount: notices.length,
      itemBuilder: (context, index) {
        return _buildNoticeGridCard(context, notices[index]);
      },
    );
  }

  Widget _buildNoticesListView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      itemCount: notices.length,
      separatorBuilder: (context, index) => SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
      itemBuilder: (context, index) {
        return _buildNoticeCard(context, notices[index]);
      },
    );
  }

  Widget _buildNoticeGridCard(BuildContext context, NoticeItem notice) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        border: Border.all(
          color: notice.priority == NoticePriority.high
              ? Colors.red.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: notice.priority == NoticePriority.high ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showNoticeDetails(context, notice),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getGridItemPadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildNoticeIcon(context, notice),
                  const Spacer(),
                  _buildPriorityIndicatorBadge(context, notice.priority),
                ],
              ),
              SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.title,
                      style: AppThemeResponsiveness.getGridItemTitleStyle(context).copyWith(
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 14),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: AppThemeResponsiveness.getIconSize(context) * 0.6,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                        Expanded(
                          child: Text(
                            notice.time,
                            style: AppThemeResponsiveness.getGridItemSubtitleStyle(context),
                            overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildNoticeCard(BuildContext context, NoticeItem notice) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
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
        onTap: () => _showNoticeDetails(context, notice),
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        child: Padding(
          padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
          child: Row(
            children: [
              _buildNoticeIcon(context, notice),
              SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
              Expanded(
                child: _buildNoticeContent(context, notice),
              ),
              SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
              _buildPriorityIndicator(context, notice.priority),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeIcon(BuildContext context, NoticeItem notice) {
    return Container(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDashboardCardIconPadding(context)),
      decoration: BoxDecoration(
        color: notice.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        notice.icon,
        color: notice.color,
        size: AppThemeResponsiveness.getDashboardCardIconSize(context),
      ),
    );
  }

  Widget _buildNoticeContent(BuildContext context, NoticeItem notice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notice.title,
          style: AppThemeResponsiveness.getDashboardCardTitleStyle(context).copyWith(
            fontSize: AppThemeResponsiveness.getResponsiveFontSize(
              context,
              AppThemeResponsiveness.getDashboardCardTitleStyle(context).fontSize!,
            ),
            height: 1.3,
          ),
          maxLines: AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context) ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: AppThemeResponsiveness.getIconSize(context) * 0.7,
              color: Colors.grey.shade500,
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context) / 2),
            Expanded(
              child: Text(
                notice.time,
                style: AppThemeResponsiveness.getDashboardCardSubtitleStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityIndicator(BuildContext context, NoticePriority priority) {
    Color color = _getPriorityColor(priority);

    return Container(
      width: AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context) ? 6 : 8,
      height: AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context) ? 35 : 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildPriorityIndicatorBadge(BuildContext context, NoticePriority priority) {
    Color color = _getPriorityColor(priority);
    String text = _getPriorityText(priority);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeResponsiveness.getSmallSpacing(context),
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppThemeColor.white,
          fontSize: AppThemeResponsiveness.getStatusBadgeFontSize(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
      child: AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context)
          ? Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton.icon(
              onPressed: () => _markAllAsRead(context),
              icon: Icon(
                Icons.done_all,
                color: AppThemeColor.white,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              label: Text('Mark All Read', style: AppThemeResponsiveness.getButtonTextStyle(context)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeColor.primaryBlue,
                elevation: AppThemeResponsiveness.getButtonElevation(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          SizedBox(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: OutlinedButton.icon(
              onPressed: () => _refreshNotices(context),
              icon: Icon(
                Icons.refresh,
                color: AppThemeColor.primaryBlue,
                size: AppThemeResponsiveness.getIconSize(context) * 0.8,
              ),
              label: Text(
                'Refresh',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  color: AppThemeColor.primaryBlue,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppThemeColor.primaryBlue,
                  width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
              ),
            ),
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: SizedBox(
              height: AppThemeResponsiveness.getButtonHeight(context),
              child: ElevatedButton.icon(
                onPressed: () => _markAllAsRead(context),
                icon: Icon(
                  Icons.done_all,
                  color: AppThemeColor.white,
                  size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                ),
                label: Text('Mark All Read', style: AppThemeResponsiveness.getButtonTextStyle(context)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeColor.primaryBlue,
                  elevation: AppThemeResponsiveness.getButtonElevation(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
          Expanded(
            child: SizedBox(
              height: AppThemeResponsiveness.getButtonHeight(context),
              child: OutlinedButton.icon(
                onPressed: () => _refreshNotices(context),
                icon: Icon(
                  Icons.refresh,
                  color: AppThemeColor.primaryBlue,
                  size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                ),
                label: Text(
                  'Refresh',
                  style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                    color: AppThemeColor.primaryBlue,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppThemeColor.primaryBlue,
                    width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoticeDetails(BuildContext context, NoticeItem notice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNoticeDetailsSheet(context, notice),
    );
  }

  Widget _buildNoticeDetailsSheet(BuildContext context, NoticeItem notice) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sheetHeight = AppThemeResponsiveness.isMobile(context) && AppThemeResponsiveness.isSmallPhone(context)
        ? screenHeight * 0.8
        : screenHeight * 0.7;

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          topRight: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: AppThemeResponsiveness.getSmallSpacing(context)),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppThemeResponsiveness.getDefaultSpacing(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      _buildNoticeIcon(context, notice),
                      SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice.title,
                              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                                fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 18),
                              ),
                            ),
                            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                            _buildPriorityIndicatorBadge(context, notice.priority),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

                  // Time info
                  Container(
                    padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
                    decoration: BoxDecoration(
                      color: AppThemeColor.blue50,
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppThemeColor.primaryBlue,
                          size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                        ),
                        SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
                        Text(
                          'Posted ${notice.time}',
                          style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                            color: AppThemeColor.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),

                  // Notice details
                  Text(
                    'Notice Details',
                    style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                      fontSize: AppThemeResponsiveness.getResponsiveFontSize(context, 16),
                    ),
                  ),

                  SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppThemeResponsiveness.getMediumSpacing(context)),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      notice.description,
                      style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                        height: 1.6,
                        fontSize: AppThemeResponsiveness.getResponsiveFontSize(
                          context,
                          AppThemeResponsiveness.getBodyTextStyle(context).fontSize!,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey.shade600,
                            size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                          ),
                          label: Text(
                            'Close',
                            style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: AppThemeResponsiveness.getFocusedBorderWidth(context),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _shareNotice(context, notice);
                          },
                          icon: Icon(
                            Icons.share,
                            color: AppThemeColor.white,
                            size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                          ),
                          label: Text('Share', style: AppThemeResponsiveness.getButtonTextStyle(context)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemeColor.primaryBlue,
                            elevation: AppThemeResponsiveness.getButtonElevation(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Methods
  Color _getPriorityColor(NoticePriority priority) {
    switch (priority) {
      case NoticePriority.high:
        return Colors.red;
      case NoticePriority.medium:
        return Colors.orange;
      case NoticePriority.low:
        return Colors.green;
    }
  }

  String _getPriorityText(NoticePriority priority) {
    switch (priority) {
      case NoticePriority.high:
        return 'High';
      case NoticePriority.medium:
        return 'Medium';
      case NoticePriority.low:
        return 'Low';
    }
  }

  void _markAllAsRead(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All notices marked as read'),
        backgroundColor: AppThemeColor.primaryBlue,
      ),
    );
  }

  void _refreshNotices(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Refreshing notices...'),
        backgroundColor: AppThemeColor.primaryBlue,
      ),
    );
  }

  void _shareNotice(BuildContext context, NoticeItem notice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing notice: ${notice.title}'),
        backgroundColor: AppThemeColor.primaryBlue,
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
  final String description;

  NoticeItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.color,
    required this.priority,
    required this.description,
  });
}

enum NoticePriority { high, medium, low }