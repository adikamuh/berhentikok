part of 'consumption_bloc.dart';

abstract class ConsumptionState extends Equatable {
  const ConsumptionState();

  @override
  List<Object> get props => [];
}

class ConsumptionInitial extends ConsumptionState {}

class ConsumptionLoaded extends ConsumptionState {
  final User user;
  final List<SmokingDetail> smokingDetails;

  const ConsumptionLoaded({
    required this.user,
    required this.smokingDetails,
  });
}

class ConsumptionFailed extends ConsumptionState {
  final String errorMessage;

  const ConsumptionFailed(this.errorMessage);
}
