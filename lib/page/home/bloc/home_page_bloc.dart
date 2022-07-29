import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UserRepository userRepository;
  HomePageBloc({
    required this.userRepository,
  }) : super(HomePageInitial()) {
    on<FetchUser>((event, emit) async {
      final User? user = userRepository.load();
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(const HomePageFailed('User tidak ditemukan'));
      }
    });
  }
}
