part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class UserLoaded extends HomePageState {
  final User user;

  const UserLoaded(this.user);
}

class HomePageFailed extends HomePageState {
  final String errorMessage;

  const HomePageFailed(this.errorMessage);
}
