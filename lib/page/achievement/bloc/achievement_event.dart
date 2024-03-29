part of 'achievement_bloc.dart';

abstract class AchievementEvent extends Equatable {
  const AchievementEvent();

  @override
  List<Object> get props => [];
}

class LoadAchievement extends AchievementEvent {}

class ReadAchievment extends AchievementEvent {
  final Achievement achievement;

  const ReadAchievment(this.achievement);
}
