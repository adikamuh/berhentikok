// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TargetItemAdapter extends TypeAdapter<TargetItem> {
  @override
  final int typeId = 2;

  @override
  TargetItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TargetItem(
      name: fields[0] as String,
      price: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TargetItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
