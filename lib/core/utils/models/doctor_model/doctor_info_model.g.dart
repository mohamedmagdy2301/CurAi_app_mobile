// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorInfoModelAdapter extends TypeAdapter<DoctorInfoModel> {
  @override
  final int typeId = 3;

  @override
  DoctorInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorInfoModel(
      id: fields[0] as int?,
      profilePicture: fields[1] as String?,
      username: fields[2] as String?,
      email: fields[3] as String?,
      specialization: fields[4] as String?,
      consultationPrice: fields[5] as String?,
      location: fields[6] as String?,
      reviews: (fields[7] as List?)?.cast<DoctorReviews>(),
      firstName: fields[8] as String?,
      lastName: fields[9] as String?,
      bio: fields[10] as String?,
      latitude: fields[11] as double?,
      longitude: fields[12] as double?,
      avgRating: fields[13] as double?,
      totalReviews: fields[14] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorInfoModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.profilePicture)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.specialization)
      ..writeByte(5)
      ..write(obj.consultationPrice)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.reviews)
      ..writeByte(8)
      ..write(obj.firstName)
      ..writeByte(9)
      ..write(obj.lastName)
      ..writeByte(10)
      ..write(obj.bio)
      ..writeByte(11)
      ..write(obj.latitude)
      ..writeByte(12)
      ..write(obj.longitude)
      ..writeByte(13)
      ..write(obj.avgRating)
      ..writeByte(14)
      ..write(obj.totalReviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorReviewsAdapter extends TypeAdapter<DoctorReviews> {
  @override
  final int typeId = 4;

  @override
  DoctorReviews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorReviews(
      id: fields[0] as int?,
      patientUsername: fields[1] as String?,
      rating: fields[2] as int?,
      comment: fields[3] as String?,
      createdAt: fields[4] as String?,
      profilePatientPicture: fields[5] as String?,
      firstName: fields[6] as String?,
      lastName: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorReviews obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.patientUsername)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.profilePatientPicture)
      ..writeByte(6)
      ..write(obj.firstName)
      ..writeByte(7)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorReviewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
