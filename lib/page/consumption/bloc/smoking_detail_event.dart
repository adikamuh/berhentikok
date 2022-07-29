part of 'smoking_detail_bloc.dart';

abstract class SmokingDetailEvent extends Equatable {
  const SmokingDetailEvent();

  @override
  List<Object> get props => [];
}

class AddSmokingDetail extends SmokingDetailEvent {
  final SmokingDetail smokingDetail;

  const AddSmokingDetail(this.smokingDetail);
}

class LoadSmokingDetails extends SmokingDetailEvent {}
