part of 'smoking_detail_bloc.dart';

abstract class SmokingDetailState extends Equatable {
  const SmokingDetailState();

  @override
  List<Object> get props => [];
}

class SmokingDetailInitial extends SmokingDetailState {}

class SmokingDetailSubmitted extends SmokingDetailState {}

class SmokingDetailsLoaded extends SmokingDetailState {
  final LinkedHashMap<DateTime, List<SmokingDetail>> smokingDetails;

  const SmokingDetailsLoaded(this.smokingDetails);
}

class SmokingDetailFailed extends SmokingDetailState {
  final String errorMessage;

  const SmokingDetailFailed(this.errorMessage);
}
