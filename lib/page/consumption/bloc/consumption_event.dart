part of 'consumption_bloc.dart';

abstract class ConsumptionEvent extends Equatable {
  const ConsumptionEvent();

  @override
  List<Object> get props => [];
}

class LoadConsumption extends ConsumptionEvent {}
