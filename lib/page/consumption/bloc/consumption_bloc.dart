import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'consumption_event.dart';

class ConsumptionState extends Equatable {
  final User user;
  final List<SmokingDetail> smokingDetails;

  const ConsumptionState({
    required this.user,
    required this.smokingDetails,
  });

  @override
  List<Object> get props => [user, smokingDetails];
}

class ConsumptionBloc
    extends Bloc<ConsumptionEvent, Resource<ConsumptionState>> {
  final UserRepository userRepository;
  final SmokingDetailRepository smokingDetailRepository;
  ConsumptionBloc({
    required this.userRepository,
    required this.smokingDetailRepository,
  }) : super(Resource.idle()) {
    on<LoadConsumption>((event, emit) async {
      emit(Resource.loading());
      try {
        final user = userRepository.load();
        final List<SmokingDetail> smokingDetails =
            await smokingDetailRepository.loadAll();
        if (user != null) {
          emit(
            Resource.success(
              ConsumptionState(
                user: user,
                smokingDetails: smokingDetails,
              ),
            ),
          );
        } else {
          emit(Resource.error('User tidak ditemukan'));
        }
      } catch (e) {
        emit(Resource.error(e.toString()));
      }
    });
  }
}
