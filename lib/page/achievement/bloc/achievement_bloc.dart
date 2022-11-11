import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
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

class AchievementBloc
    extends Bloc<AchievementEvent, Resource<AchievementState>> {
  final AchievementRepository achievementRepository;
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  final FinanceBloc financeBloc;
  AchievementBloc({
    required this.achievementRepository,
    required this.userRepository,
    required this.smokingDetailRepository,
    required this.financeBloc,
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

      final List<SmokingDetail> smokingDetails =
          await smokingDetailRepository.loadAll();
      final User user = userRepository.load()!;
      final DateTime now = DateTime.now();
      final DateTime lastDaySmoke =
          smokingDetails.lastDaySmoke() ?? user.startDateStopSmoking;

      final Duration freeSmokeDuration = now.difference(lastDaySmoke);
      final int moneySaved =
          financeBloc.state.inferredData?.moneySavedOnRelapse ?? 0;
      final int smokeTotal = smokingDetails.totalFreeCigaretteOnRelapse(user);

      final List<Achievement> showedAchievements = achievements.map(
        (achievement) {
          if (achievement.duration != null) {
            if (freeSmokeDuration.compareTo(achievement.duration!) >= 0) {
              return achievement.copyWith(isAchieved: true);
            }
          } else if (achievement.moneyCount != null) {
            if (moneySaved >= achievement.moneyCount!) {
              return achievement.copyWith(isAchieved: true);
            }
          } else if (achievement.smokeCount != null) {
            if (smokeTotal >= achievement.smokeCount!) {
              return achievement.copyWith(isAchieved: true);
            }
          }
          return achievement;
        },
      ).map((currentAchievement) {
        final Achievement? achievement = achievementsRead.firstWhereOrNull(
            (achievementRead) => currentAchievement.id == achievementRead.id);
        if (achievement != null) {
          return achievement.copyWith(isRead: true, isAchieved: true);
        } else {
          return currentAchievement;
        }
      }).sorted((a, b) {
        if (b.isAchieved) return 1;
        return -1;
      }).toList();

      return showedAchievements;
    }

    on<LoadAchievement>((event, emit) async {
      emit(Resource.loading(data: state.inferredData));
      try {
        final List<Achievement> achievementsAchieved =
            await showedAchievements();
        final bool isAllRead = achievementsAchieved
            .where((achievement) => achievement.isAchieved)
            .fold<bool>(true,
                (previousValue, element) => previousValue && element.isRead);

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
