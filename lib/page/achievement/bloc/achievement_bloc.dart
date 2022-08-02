import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/repositories/achievement_repository.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final AchievementRepository achievementRepository;
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  AchievementBloc({
    required this.achievementRepository,
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(const AchievementState(
          achievements: [],
          isNewAchieved: false,
        )) {
    Future<bool> checkIsAchieved() async {
      final achievementsAchieved =
          achievementRepository.loadAchievementsAchieved();
      final DateTime now = DateTime.now();
      final DateTime lastDaySmoke =(await
          smokingDetailRepository.loadAll()).lastDaySmoke() ??
              userRepository.load()!.startDateStopSmoking;

      bool isNewAchieved = false;
      for (var i = 0; i < achievementsAchieved.length; i++) {
        final Achievement achievement = achievementsAchieved[i];
        if (!achievement.isAchieved) {
          final Duration freeSmokeDuration = now.difference(lastDaySmoke);
          if (freeSmokeDuration.compareTo(achievement.duration) >= 0) {
            achievementRepository.addAchievementAchieved(achievement, i);
            isNewAchieved = true;
          }
        }
      }

      return isNewAchieved;
    }

    on<LoadAchievement>((event, emit) async {
      try {
        final bool isNewAchieved = await checkIsAchieved();
        final List<Achievement> achievementsAchieved =
            achievementRepository.loadAchievementsAchieved();
        emit(AchievementState(
          achievements: achievementsAchieved,
          isNewAchieved: isNewAchieved,
        ));
      } catch (e) {
        emit(AchievementFailed(e.toString()));
      }
    });
  }
}
