// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'message_bubble_model.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class MessageBubbleModelAdapter extends TypeAdapter<MessageBubbleModel> {
//   @override
//   final int typeId = 0;

//   @override
//   MessageBubbleModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return MessageBubbleModel(
//       messageText: fields[0] as String,
//       date: fields[1] as DateTime,
//       sender: fields[2] as SenderType,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, MessageBubbleModel obj) {
//     writer
//       ..writeByte(3)
//       ..writeByte(0)
//       ..write(obj.messageText)
//       ..writeByte(1)
//       ..write(obj.date)
//       ..writeByte(2)
//       ..write(obj.sender);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is MessageBubbleModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }

// class SenderTypeAdapter extends TypeAdapter<SenderType> {
//   @override
//   final int typeId = 1;

//   @override
//   SenderType read(BinaryReader reader) {
//     switch (reader.readByte()) {
//       case 0:
//         return SenderType.user;
//       case 1:
//         return SenderType.bot;
//       default:
//         return SenderType.user;
//     }
//   }

//   @override
//   void write(BinaryWriter writer, SenderType obj) {
//     switch (obj) {
//       case SenderType.user:
//         writer.writeByte(0);
//         break;
//       case SenderType.bot:
//         writer.writeByte(1);
//         break;
//     }
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is SenderTypeAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
