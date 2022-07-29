// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      tobaccoConsumption: fields[1] as int,
      averagePrice: fields[2] as int,
      cigarettesPerPack: fields[3] as int,
      startDateStopSmoking: fields[4] as DateTime,
      motivation: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tobaccoConsumption)
      ..writeByte(2)
      ..write(obj.averagePrice)
      ..writeByte(3)
      ..write(obj.cigarettesPerPack)
      ..writeByte(4)
      ..write(obj.startDateStopSmoking)
      ..writeByte(5)
      ..write(obj.motivation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
