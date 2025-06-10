import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart'; // Assuming this provides AppTheme.FontStyle and primaryGradient
import 'package:school/customWidgets/theme.dart'; // Assuming this provides AppTheme constants // Import the MessageService
import 'package:intl/intl.dart';
import 'package:school/model/messageModelTeacher.dart';
import 'package:school/model/messageServiceTeacher.dart'; // For formatting timestamps


/// A page to display and send messages to/from an admin or academic officer.
class MessagePageTeacher extends StatefulWidget {
  const MessagePageTeacher({Key? key}) : super(key: key);

  @override
  State<MessagePageTeacher> createState() => _MessagePageTeacherState();
}

class _MessagePageTeacherState extends State<MessagePageTeacher> {
  final MessageService _messageService = MessageService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];
  bool _isLoading = true;

  // Get current user and admin/officer IDs from the service.
  late String _currentUserId;
  late String _adminOfficerId;

  @override
  void initState() {
    super.initState();
    _currentUserId = _messageService.getCurrentUserId();
    _adminOfficerId = _messageService.getAdminOfficerId();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Loads messages from the MessageService.
  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    try {
      final fetchedMessages = await _messageService.getMessagesForCurrentUser();
      setState(() {
        _messages = fetchedMessages;
        _isLoading = false;
      });
      // Scroll to the bottom after messages are loaded.
      _scrollToBottom();
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error loading messages', isError: true);
    }
  }

  /// Sends a new message.
  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      _showSnackBar('Message cannot be empty.', isError: true);
      return;
    }

    // Simulate sending the message from the current user to the admin/officer.
    final success = await _messageService.sendMessage(
      text,
      _currentUserId,
      _adminOfficerId,
    );

    if (success) {
      _messageController.clear();
      _loadMessages(); // Reload messages to include the new one.
    } else {
      _showSnackBar('Failed to send message.', isError: true);
    }
  }

  /// Scrolls the message list to the bottom.
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Displays a SnackBar message to the user.
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.white))
                    : _messages.isEmpty
                    ? _buildNoMessagesPlaceholder()
                    : _buildMessageList(),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header section of the page.
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          const SizedBox(width: AppTheme.smallSpacing),
          const Icon(Icons.message, color: AppTheme.white, size: 30),
          const SizedBox(width: AppTheme.smallSpacing),
          const Text('Messages', style: AppTheme.FontStyle),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing, vertical: AppTheme.smallSpacing),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isSentByMe = message.senderId == _currentUserId;
        return _MessageBubble(
          message: message,
          isSentByMe: isSentByMe,
          adminOfficerId: _adminOfficerId,
        );
      },
    );
  }

  /// Builds a placeholder when there are no messages.
  Widget _buildNoMessagesPlaceholder() {
    return Card(
      elevation: AppTheme.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
      ),
      margin: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: const Padding(
        padding: EdgeInsets.all(AppTheme.largeSpacing),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chat_bubble_outline, size: 60, color: Colors.grey),
              SizedBox(height: AppTheme.mediumSpacing),
              Text(
                'No messages yet. Send your first message!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the message input field at the bottom.
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultSpacing),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                filled: true,
                fillColor: AppTheme.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.inputBorderRadius),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultSpacing, vertical: AppTheme.smallSpacing),
              ),
              maxLines: null, // Allows for multi-line input
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: AppTheme.smallSpacing),
          FloatingActionButton(
            onPressed: _sendMessage,
            mini: true,
            backgroundColor: AppTheme.white,
            foregroundColor: AppTheme.primaryBlue,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

/// A custom widget to display a single message bubble.
class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isSentByMe;
  final String adminOfficerId;

  const _MessageBubble({
    Key? key,
    required this.message,
    required this.isSentByMe,
    required this.adminOfficerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine alignment based on sender.
    final alignment = isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    // Determine bubble color based on sender.
    final color = isSentByMe ? AppTheme.primaryBlue.withOpacity(0.9) : Colors.grey.shade300;
    // Determine text color based on bubble color.
    final textColor = isSentByMe ? AppTheme.white : Colors.black;
    // Determine border radius based on sender for a chat bubble look.
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(AppTheme.inputBorderRadius),
      topRight: const Radius.circular(AppTheme.inputBorderRadius),
      bottomLeft: isSentByMe ? const Radius.circular(AppTheme.inputBorderRadius) : const Radius.circular(0),
      bottomRight: isSentByMe ? const Radius.circular(0) : const Radius.circular(AppTheme.inputBorderRadius),
    );

    // Get formatted timestamp.
    final timeFormatted = DateFormat('hh:mm a').format(message.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppTheme.defaultSpacing),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.mediumSpacing,
              vertical: AppTheme.smallSpacing,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75, // Max width for message bubble
            ),
            child: Text(
              message.content,
              style: TextStyle(color: textColor),
            ),
          ),
          const SizedBox(height: AppTheme.defaultSpacing),
          Text(
            timeFormatted,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
