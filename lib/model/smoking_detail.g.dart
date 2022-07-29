// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smoking_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmokingDetailAdapter extends TypeAdapter<SmokingDetail> {
  @override
  final int typeId = 1;

  @override
  SmokingDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmokingDetail(
      date: fields[0] as DateTime,
      excuse: fields[1] as String,
      total: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SmokingDetail obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.excuse)
      ..writeByte(2)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmokingDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
