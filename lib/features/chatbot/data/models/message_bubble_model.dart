// part 'message_bubble_model.g.dart'; // Generate Hive adapter

// @HiveType(typeId: 0)
import 'package:image_picker/image_picker.dart';

class MessageBubbleModel {
  MessageBubbleModel({
    required this.messageText,
    required this.date,
    required this.sender,
    this.image,
  });
  // @HiveField(0)
  final String messageText;

  // @HiveField(1)
  final DateTime date;

  // @HiveField(2)
  final SenderType sender;
  // @HiveField(3)
  final XFile? image;
}

// @HiveType(typeId: 1)
enum SenderType {
  // @HiveField(0)
  user,
  // @HiveField(1)
  bot,
}
