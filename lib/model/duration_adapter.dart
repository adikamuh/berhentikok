import 'package:hive_flutter/hive_flutter.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 4;

  @override
  Duration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Duration(
      days: fields[0] as int,
      hours: fields[1] as int,
      minutes: fields[2] as int,
      seconds: fields[3] as int,
      milliseconds: fields[4] as int,
      microseconds: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.inDays)
      ..writeByte(1)
      ..write(obj.inHours)
      ..writeByte(2)
      ..write(obj.inMinutes)
      ..writeByte(3)
      ..write(obj.inSeconds)
      ..writeByte(4)
      ..write(obj.inMilliseconds)
      ..writeByte(5)
      ..write(obj.inMicroseconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
