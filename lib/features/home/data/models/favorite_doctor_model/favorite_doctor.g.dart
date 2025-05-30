// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_doctor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDoctorAdapter extends TypeAdapter<FavoriteDoctor> {
  @override
  final int typeId = 2;

  @override
  FavoriteDoctor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteDoctor(
      id: fields[0] as int,
      username: fields[1] as String?,
      specialization: fields[2] as String?,
      profilePicture: fields[3] as String?,
      consultationPrice: fields[4] as String?,
      firstName: fields[5] as String?,
      lastName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteDoctor obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.firstName)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.specialization)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.consultationPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDoctorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
