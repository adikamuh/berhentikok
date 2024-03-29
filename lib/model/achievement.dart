import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'achievement.g.dart';

@CopyWith()
@HiveType(typeId: 3)
class Achievement extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String imageFile;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String dialogDescription;
  @HiveField(5)
  final Duration? duration;
  @HiveField(6)
  final int? smokeCount;
  @HiveField(7)
  final int? moneyCount;
  final bool isAchieved;
  final bool isRead;

  const Achievement({
    required this.id,
    required this.imageFile,
    required this.title,
    required this.description,
    required this.dialogDescription,
    this.duration,
    this.smokeCount,
    this.moneyCount,
    this.isAchieved = false,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [
        id,
        imageFile,
        title,
        description,
        dialogDescription,
        duration,
        isRead,
      ];
}
