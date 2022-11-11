import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:collection/collection.dart';
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
    final Duration difference = smokingDetails.freeSmokingDuration(user);
    int percentage = 0;
    percentage = _countTimeDifferencePercentage(difference, endDuration);
    // if (startDuration.compareTo(endDuration) == 0) {
    //   percentage = _countTimeDifferencePercentage(difference, startDuration);
    // } else {
    //   // if (difference.inDays < startDuration.inDays) {
    //   //   percentage = 0;
    //   // } else {
    //   final int fullDuration = endDuration.inDays;

    //   percentage = _countPercentage(
    //     difference.inDays,
    //     fullDuration,
    //   );
    //   // }
    // }

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
    return _countPercentage(duration.inMinutes, fullDuration.inMinutes);
    // if (fullDuration.inDays > 0) {
    //   if (fullDuration.inHours == 24) {
    //     return _countPercentage(duration.inHours, fullDuration.inHours);
    //   }
    //   return _countPercentage(duration.inDays, fullDuration.inDays);
    // } else if (fullDuration.inHours > 0) {
    //   return _countPercentage(duration.inHours, fullDuration.inHours);
    // } else {
    //   return _countPercentage(duration.inMinutes, fullDuration.inMinutes);
    // }
  }
}

extension ListOfHealthProgressEx on List<HealthProgress> {
  HealthProgress? firstWhereOnProgress({
    required User user,
    required List<SmokingDetail> smokingDetails,
  }) {
    return firstWhereOrNull((healthProgress) =>
        healthProgress.value(user: user, smokingDetails: smokingDetails) < 100);
  }

  List<HealthProgress> firstTwoOnProgress({
    required User user,
    required List<SmokingDetail> smokingDetails,
  }) {
    final HealthProgress? first = firstWhereOnProgress(
      user: user,
      smokingDetails: smokingDetails,
    );
    if (first != null) {
      final int firstIndex = indexOf(first);
      if ((firstIndex + 1) <= (length - 1)) {
        return [this[firstIndex], this[firstIndex + 1]];
      } else {
        return [this[firstIndex]];
      }
    }
    return [];
  }
}
