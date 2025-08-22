import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/repositories/target_item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final TargetItemRepository targetItemRepository;
  AddItemBloc({required this.targetItemRepository}) : super(AddItemInitial()) {
    on<SaveItem>((event, emit) {
      try {
        final isSuccess = targetItemRepository.add(event.targetItem);
        if (isSuccess) {
          emit(ItemSubmitted());
        } else {
          emit(const AddItemFailed('Target barang gagal disimpan'));
        }
      } catch (e) {
        emit(AddItemFailed(e.toString()));
      }
    });
    on<LoadItems>((event, emit) {
      try {
        final targetItems = targetItemRepository.loadAll();
        emit(ItemsLoaded(targetItems));
      } catch (e) {
        emit(AddItemFailed(e.toString()));
      }
    });
  }
}
