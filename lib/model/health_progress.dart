import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:equatable/equatable.dart';

class HealthProgress extends Equatable {
  final String imageFile;
  final String caption;
  final Duration startDuration;
  final Duration endDuration;

  const HealthProgress({
    required this.imageFile,
    required this.caption,
    required this.startDuration,
    required this.endDuration,
  });

  @override
  List<Object?> get props => [
        imageFile,
        caption,
        startDuration,
        endDuration,
      ];

  int value({
    required User user,
    required List<SmokingDetail> smokingDetails,
  }) {
    DateTime lastDayOfSmoke;
    if (smokingDetails.isEmpty) {
      lastDayOfSmoke = user.startDateStopSmoking;
    } else {
      lastDayOfSmoke =
          smokingDetails.lastDaySmoke() ?? user.startDateStopSmoking;
    }
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(lastDayOfSmoke);
    int percentage = 0;
    if (startDuration.compareTo(endDuration) == 0) {
      percentage = _countTimeDifferencePercentage(difference, startDuration);
    } else {
      if (difference.inDays < startDuration.inDays) {
        percentage = 0;
      } else {
        final int fullDuration = endDuration.inDays - startDuration.inDays;

        percentage = _countPercentage(
          difference.inDays - startDuration.inDays,
          fullDuration,
        );
      }
    }

    if (percentage >= 100) {
      return 100;
    } else if (percentage <= 0) {
      return 0;
    } else {
      return percentage;
    }
  }

  int _countPercentage(int value, int fullValue) {
    return ((value / fullValue) * 100).toInt();
  }

  int _countTimeDifferencePercentage(Duration duration, Duration fullDuration) {
    if (fullDuration.inDays > 0) {
      return _countPercentage(duration.inDays, fullDuration.inDays);
    } else if (fullDuration.inHours > 0) {
      return _countPercentage(duration.inHours, fullDuration.inHours);
    } else {
      return _countPercentage(duration.inMinutes, fullDuration.inMinutes);
    }
  }
}
