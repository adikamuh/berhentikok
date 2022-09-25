import 'package:berhentikok/base/double_extension.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@CopyWith()
@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int tobaccoConsumption;
  @HiveField(2)
  final int averagePrice;
  @HiveField(3)
  final int cigarettesPerPack;
  @HiveField(4)
  final DateTime startDateStopSmoking;
  @HiveField(5)
  final String motivation;
  @HiveField(6)
  final bool isFistTime;

  const User({
    required this.name,
    required this.tobaccoConsumption,
    required this.averagePrice,
    required this.cigarettesPerPack,
    required this.startDateStopSmoking,
    required this.motivation,
    this.isFistTime = false,
  });

  @override
  List<Object?> get props => [
        name,
        tobaccoConsumption,
        averagePrice,
        cigarettesPerPack,
        startDateStopSmoking,
        motivation,
      ];

  Stream<String?> sumFreeSmokingDuration(List<SmokingDetail> smokingDetails) {
    DateTime lastDayOfSmoke;
    if (smokingDetails.isEmpty) {
      lastDayOfSmoke = startDateStopSmoking;
    } else {
      lastDayOfSmoke = smokingDetails.lastDaySmoke() ?? startDateStopSmoking;
    }
    return Stream.periodic(const Duration(seconds: 1), (int count) {
      final now = DateTime.now();
      final duration = now.difference(lastDayOfSmoke);
      if (duration.inDays > 0) {
        final String inHours =
            duration.inHours % 24 != 0 ? "${duration.inHours % 24} jam" : "";
        return "${duration.inDays} hari\n$inHours";
      } else if (duration.inHours > 0) {
        final String inMinutes = duration.inMinutes % 60 != 0
            ? "${duration.inMinutes % 60} menit"
            : "";
        return "${duration.inHours} jam\n$inMinutes";
      } else if (duration.inMinutes > 0) {
        final String inSeconds = duration.inSeconds % 60 != 0
            ? "${duration.inSeconds % 60} detik"
            : "";
        return "${duration.inMinutes} menit\n$inSeconds";
      } else if (duration.inSeconds >= 0) {
        return "${duration.inSeconds} detik";
      } else {
        return null;
      }
    });
  }

  Duration get freeSmokingDuration =>
      DateTime.now().difference(startDateStopSmoking);

  // finance
  int get pricePerCigarette => (averagePrice ~/ cigarettesPerPack);

  int get moneySaved => totalFreeCigarette * pricePerCigarette;

  int get moneySavedEachDay => tobaccoConsumption * pricePerCigarette;

  // consumption
  double get hoursPerCigarette => (24 / tobaccoConsumption).toPrecision(1);

  int get totalFreeCigarette =>
      (freeSmokingDuration.inHours ~/ hoursPerCigarette);
}
