import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final UserRepository userRepository;
  OnBoardingCubit({required this.userRepository}) : super(OnBoardingInitial());

  void submitForm(User user) {
    try {
      userRepository.save(user);
      return emit(FormSubmitted());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
