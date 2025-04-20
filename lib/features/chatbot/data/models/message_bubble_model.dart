// ignore_for_file: lines_longer_than_80_chars

enum SenderType { user, bot }

class MessageBubbleModel {
  const MessageBubbleModel({
    required this.messageText,
    required this.date,
    required this.sender,
  });

  final String messageText;
  final DateTime date;
  final SenderType sender;
}
