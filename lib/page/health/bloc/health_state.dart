part of 'health_bloc.dart';

abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object> get props => [];
}

class HealthInitial extends HealthState {}

class HealthLoaded extends HealthState {
  final List<HealthProgress> healthProgresses;
  final List<SmokingDetail> smokingDetails;
  final User user;

  const HealthLoaded({
    required this.healthProgresses,
    required this.smokingDetails,
    required this.user,
  });
}

class HealthFaield extends HealthState {
  final String errorMessage;

  const HealthFaield(this.errorMessage);
}
