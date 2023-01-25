import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/home/cubit/smoking_strategy_cubit.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final UserRepository userRepository;
  final SmokingStrategyCubit smokingStrategyCubit;
  OnBoardingCubit({
    required this.userRepository,
    required this.smokingStrategyCubit,
  }) : super(OnBoardingInitial());

  void submitForm(User user) {
    try {
      userRepository.save(user);
      smokingStrategyCubit.init();
      return emit(FormSubmitted());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
