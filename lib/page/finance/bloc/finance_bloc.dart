import 'package:berhentikok/model/finance.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/target_item_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc({
    required UserRepository userRepository,
    required TargetItemRepository targetItemRepository,
    required SmokingDetailRepository smokingDetailRepository,
  }) : super(FinanceInitial()) {
    on<LoadFinance>((event, emit) {
      try {
        final User? user = userRepository.load();
        if (user != null) {
          final Finance finance = Finance(
            moneySaved: user.moneySaved,
            targetItems: targetItemRepository.loadAll(),
          );
          final int moneySavedOnRelapse = finance.countMoneySaved(
            smokingDetails: smokingDetailRepository.loadAll(),
            user: user,
          );
          emit(FinanceLoaded(
            finance: finance,
            user: user,
            moneySavedOnRelapse: moneySavedOnRelapse,
          ));
        } else {
          throw Exception('user not found');
        }
      } catch (e) {
        emit(FinanceFailed(e.toString()));
      }
    });
  }
}
