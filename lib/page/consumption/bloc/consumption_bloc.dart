import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'consumption_event.dart';
part 'consumption_state.dart';

class ConsumptionBloc extends Bloc<ConsumptionEvent, ConsumptionState> {
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  ConsumptionBloc({
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(ConsumptionInitial()) {
    on<LoadConsumption>((event, emit) {
      try {
        final user = userRepository.load();
        final List<SmokingDetail> smokingDetails =
            smokingDetailRepository.loadAll();
        if (user != null) {
          emit(ConsumptionLoaded(
            user: user,
            smokingDetails: smokingDetails,
          ));
        } else {
          emit(const ConsumptionFailed('User tidak ditemukan'));
        }
      } catch (e) {
        emit(ConsumptionFailed(e.toString()));
      }
    });
  }
}
