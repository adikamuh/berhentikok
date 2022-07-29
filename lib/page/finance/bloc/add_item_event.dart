part of 'add_item_bloc.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}

class SaveItem extends AddItemEvent {
  final TargetItem targetItem;
  const SaveItem(this.targetItem);
}

class LoadItems extends AddItemEvent {}
