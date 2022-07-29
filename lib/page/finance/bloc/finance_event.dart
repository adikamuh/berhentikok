part of 'finance_bloc.dart';

abstract class FinanceEvent extends Equatable {
  const FinanceEvent();

  @override
  List<Object> get props => [];
}

class LoadFinance extends FinanceEvent {}
