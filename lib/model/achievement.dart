import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'achievement.g.dart';

@HiveType(typeId: 3)
// ignore: must_be_immutable
class Achievement extends Equatable {
  @HiveField(0)
  final String imageFile;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String dialogDescription;
  @HiveField(4)
  final Duration duration;
  bool isAchieved = false;

  Achievement({
    required this.imageFile,
    required this.title,
    required this.description,
    required this.dialogDescription,
    required this.duration,
  });

  @override
  List<Object?> get props => [
        imageFile,
        title,
        description,
        dialogDescription,
        duration,
      ];
}
