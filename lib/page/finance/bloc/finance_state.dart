part of 'finance_bloc.dart';

abstract class FinanceState extends Equatable {
  const FinanceState();

  @override
  List<Object> get props => [];
}

class FinanceInitial extends FinanceState {}

class FinanceLoaded extends FinanceState {
  final Finance finance;
  final User user;
  final int moneySavedOnRelapse;

  const FinanceLoaded({
    required this.finance,
    required this.user,
    required this.moneySavedOnRelapse,
  });
}

class FinanceFailed extends FinanceState {
  final String errorMessage;

  const FinanceFailed(this.errorMessage);
}
