import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/health_progress_repository.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'health_event.dart';
part 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthProgressRepository healthProgressRepository;
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  HealthBloc({
    required this.healthProgressRepository,
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(HealthInitial()) {
    on<LoadHealth>((event, emit) async {
      try {
        final List<HealthProgress> healthProgresses =
            healthProgressRepository.load();
        final List<SmokingDetail> smokingDetails =
            await smokingDetailRepository.loadAll();
        final User? user = userRepository.load();
        emit(
          HealthLoaded(
            healthProgresses: healthProgresses,
            smokingDetails: smokingDetails,
            user: user!,
          ),
        );
      } catch (e) {
        emit(HealthFaield(e.toString()));
      }
    });
  }
}
