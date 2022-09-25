import 'package:berhentikok/model/finance.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/target_item_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'finance_event.dart';

class FinanceState extends Equatable {
  final Finance finance;
  final User user;
  final int moneySavedOnRelapse;

  const FinanceState({
    required this.finance,
    required this.user,
    required this.moneySavedOnRelapse,
  });

  @override
  List<Object> get props => [finance, user, moneySavedOnRelapse];
}

class FinanceBloc extends Bloc<FinanceEvent, Resource<FinanceState>> {
  FinanceBloc({
    required UserRepository userRepository,
    required TargetItemRepository targetItemRepository,
    required SmokingDetailRepository smokingDetailRepository,
  }) : super(Resource.idle()) {
    on<LoadFinance>((event, emit) async {
      try {
        final User? user = userRepository.load();
        if (user != null) {
          final Finance finance = Finance(
            moneySaved: user.moneySaved,
            targetItems: targetItemRepository.loadAll(),
          );
          final int moneySavedOnRelapse = finance.countMoneySaved(
            smokingDetails: await smokingDetailRepository.loadAll(),
            user: user,
          );
          emit(
            Resource.success(
              FinanceState(
                finance: finance,
                user: user,
                moneySavedOnRelapse: moneySavedOnRelapse,
              ),
            ),
          );
        } else {
          throw Exception('user not found');
        }
      } catch (e) {
        emit(Resource.error(e.toString()));
      }
    });
  }
}
