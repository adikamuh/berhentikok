part of 'achievement_bloc.dart';

class AchievementState extends Equatable {
  final List<Achievement> achievements;
  final bool isNewAchieved;
  const AchievementState({
    required this.achievements,
    required this.isNewAchieved,
  });

  @override
  List<Object> get props => [];
}

class AchievementFailed extends AchievementState {

  final String errorMessage;

  AchievementFailed(this.errorMessage)
      : super(
          achievements: [],
          isNewAchieved: false,
        );
}
