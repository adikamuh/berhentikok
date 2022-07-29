part of 'add_item_bloc.dart';

abstract class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object> get props => [];
}

class AddItemInitial extends AddItemState {}

class ItemSubmitted extends AddItemState {}

class AddItemFailed extends AddItemState {
  final String errorMessage;

  const AddItemFailed(this.errorMessage);
}

class ItemsLoaded extends AddItemState {
  final List<TargetItem> targetItems;

  const ItemsLoaded(this.targetItems);
}
