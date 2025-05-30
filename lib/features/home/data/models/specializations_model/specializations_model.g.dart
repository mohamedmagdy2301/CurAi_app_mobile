// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specializations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecializationsModelAdapter extends TypeAdapter<SpecializationsModel> {
  @override
  final int typeId = 5;

  @override
  SpecializationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpecializationsModel(
      id: fields[0] as int,
      image: fields[1] as String,
      name: fields[2] as String,
      doctorCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SpecializationsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.doctorCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecializationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
