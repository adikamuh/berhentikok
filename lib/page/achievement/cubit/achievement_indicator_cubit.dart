import 'package:bloc/bloc.dart';

class AchievementIndicatorClickedCubit extends Cubit<bool> {
  AchievementIndicatorClickedCubit() : super(false);

  void click() => emit(true);
  void unClick() => emit(false);
}
