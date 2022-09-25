import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/health_progress_repository.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'health_event.dart';

class HealthState extends Equatable {
  final List<HealthProgress> healthProgresses;
  final List<SmokingDetail> smokingDetails;
  final User user;

  const HealthState({
    required this.healthProgresses,
    required this.smokingDetails,
    required this.user,
  });

  @override
  List<Object> get props => [healthProgresses, smokingDetails, user];
}

class HealthBloc extends Bloc<HealthEvent, Resource<HealthState>> {
  final HealthProgressRepository healthProgressRepository;
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  HealthBloc({
    required this.healthProgressRepository,
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(Resource.idle()) {
    on<LoadHealth>((event, emit) async {
      emit(Resource.loading());
      try {
        final List<HealthProgress> healthProgresses =
            healthProgressRepository.load();
        final List<SmokingDetail> smokingDetails =
            await smokingDetailRepository.loadAll();
        final User? user = userRepository.load();
        emit(Resource.success(
          HealthState(
            healthProgresses: healthProgresses,
            smokingDetails: smokingDetails,
            user: user!,
          ),
        ));
      } catch (e) {
        emit(Resource.error(e.toString()));
      }
    });
  }
}
