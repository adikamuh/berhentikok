import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum StrategyWeeks { week1, week5, week9, complete }

class SmokingStrategyState extends Equatable {
  final StrategyWeeks strategyWeeks;
  final User user;
  final int smokingQuota;

  const SmokingStrategyState({
    required this.strategyWeeks,
    required this.user,
    required this.smokingQuota,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SmokingStrategyCubit extends Cubit<Resource<SmokingStrategyState>> {
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  SmokingStrategyCubit({
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(Resource.idle()) {
    init();
  }

  void init() async {
    emit(Resource.loading());
    try {
      final User? user = userRepository.load();
      if (user == null) {
        emit(Resource.error("User not found"));
        return;
      }
      final DateTime now = DateTime.now();
      final Duration freeSmokingDuration =
          now.difference(user.startDateStopSmoking);

      StrategyWeeks strategyWeeks = StrategyWeeks.complete;
      if (freeSmokingDuration.inDays >= 0 && freeSmokingDuration.inDays <= 28) {
        strategyWeeks = StrategyWeeks.week1;
      }
      if (freeSmokingDuration.inDays > 28 && freeSmokingDuration.inDays <= 56) {
        strategyWeeks = StrategyWeeks.week5;
      }
      if (freeSmokingDuration.inDays > 56 && freeSmokingDuration.inDays <= 84) {
        strategyWeeks = StrategyWeeks.week9;
      }

      final List<SmokingDetail> smokingDetails =
          await smokingDetailRepository.loadAll();
      final int totalSmokingToday = smokingDetails.totalSmokingOnDay(now);
      int totalSmokingQuota = 0;
      if (strategyWeeks == StrategyWeeks.week1) {
        totalSmokingQuota = (user.tobaccoConsumption ~/ 2) - totalSmokingToday;
      }
      if (strategyWeeks == StrategyWeeks.week5) {
        totalSmokingQuota = (user.tobaccoConsumption ~/ 4) - totalSmokingToday;
      }

      emit(
        Resource.success(
          SmokingStrategyState(
            strategyWeeks: strategyWeeks,
            user: user,
            smokingQuota: totalSmokingQuota,
          ),
        ),
      );
    } catch (e) {
      emit(Resource.error(e.toString()));
    }
  }
}
