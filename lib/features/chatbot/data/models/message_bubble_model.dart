import 'package:hive/hive.dart';

part 'message_bubble_model.g.dart';

@HiveType(typeId: 0)
class MessageBubbleModel extends HiveObject {
  MessageBubbleModel({
    required this.date,
    required this.sender,
    this.messageText,
    this.imagePath,
  });
  @HiveField(0)
  String? messageText;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final SenderType sender;

  @HiveField(3)
  final String? imagePath;
}

@HiveType(typeId: 1)
enum SenderType {
  @HiveField(0)
  user,

  @HiveField(1)
  bot,
}
