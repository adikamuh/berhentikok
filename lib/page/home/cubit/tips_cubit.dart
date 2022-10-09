import 'package:berhentikok/model/tips.dart';
import 'package:berhentikok/repositories/tips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class TipsState extends Equatable {
  const TipsState();

  @override
  List<Object> get props => [];
}

class TipsCubit extends Cubit<Tips> {
  final TipsRepository tipsRepository;

  TipsCubit(this.tipsRepository) : super(tipsRepository.load().first) {
    init();
  }

  void init() {
    final List<Tips> tips = tipsRepository.load();
    final int id = tipsRepository.loadLastState();
    emit(tips.firstWhere((element) => element.id == id));
  }

  Future<void> putLastState(int id) async {
    final List<Tips> tips = tipsRepository.load();
    await tipsRepository.putLastState(id);
    emit(tips.firstWhere((element) => element.id == id));
  }
}
