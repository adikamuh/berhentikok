import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/repositories/achievement_repository.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'achievement_event.dart';

class AchievementState extends Equatable {
  final List<Achievement> achievements;
  final bool isAllRead;
  const AchievementState({
    required this.achievements,
    required this.isAllRead,
  });

  @override
  List<Object> get props => [];
}

class AchievementBloc extends Bloc<AchievementEvent, Resource<AchievementState>> {
  final AchievementRepository achievementRepository;
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  AchievementBloc({
    required this.achievementRepository,
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(Resource.idle()) {
    // Future<bool> checkIsAchieved() async {
    //   final achievementsAchieved =
    //       achievementRepository.loadAchievementsAchieved();
    //   final DateTime now = DateTime.now();
    //   final DateTime lastDaySmoke =
    //       (await smokingDetailRepository.loadAll()).lastDaySmoke() ??
    //           userRepository.load()!.startDateStopSmoking;

    //   bool isNewAchieved = false;
    //   for (var i = 0; i < achievementsAchieved.length; i++) {
    //     final Achievement achievement = achievementsAchieved[i];
    //     if (!achievement.isAchieved) {
    //       final Duration freeSmokeDuration = now.difference(lastDaySmoke);
    //       if (freeSmokeDuration.compareTo(achievement.duration) >= 0) {
    //         achievementRepository.addAchievementAchieved(achievement, i);
    //         isNewAchieved = true;
    //       }
    //     }
    //   }

    //   return isNewAchieved;
    // }

    Future<List<Achievement>> showedAchievements() async {
      final List<Achievement> achievements =
          achievementRepository.loadAchievements();
      final List<Achievement> achievementsRead =
          achievementRepository.loadAchievementsRead();

      final DateTime now = DateTime.now();
      final DateTime lastDaySmoke =
          (await smokingDetailRepository.loadAll()).lastDaySmoke() ??
              userRepository.load()!.startDateStopSmoking;

      final List<Achievement> showedAchievements = achievements.where(
        (achievement) {
          final Duration freeSmokeDuration = now.difference(lastDaySmoke);
          if (freeSmokeDuration.compareTo(achievement.duration) >= 0) {
            return true;
          } else {
            return false;
          }
        },
      ).map((currentAchievement) {
        final Achievement? achievement = achievementsRead.firstWhereOrNull(
            (achievementRead) => currentAchievement.id == achievementRead.id);
        if (achievement != null) {
          return achievement.copyWith(isRead: true);
        } else {
          return currentAchievement;
        }
      }).toList();

      return showedAchievements;
    }

    on<LoadAchievement>((event, emit) async {
      try {
        final List<Achievement> achievementsAchieved =
            await showedAchievements();
        final bool isAllRead = achievementsAchieved.fold<bool>(
            true, (previousValue, element) => previousValue && element.isRead);

        emit(Resource.success(AchievementState(
          achievements: achievementsAchieved,
          isAllRead: isAllRead,
        )));
      } catch (e) {
        emit(Resource.error(e.toString()));
      }
    });

    on<ReadAchievment>((event, emit) {
      try {
        achievementRepository.addAchievementRead(event.achievement);
        add(LoadAchievement());
      } catch (e) {
        emit(Resource.error(e.toString()));
      }
    });
  }
}
