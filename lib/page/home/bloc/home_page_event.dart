part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends HomePageEvent {}

class UserDoneFirstTime extends HomePageEvent {}
