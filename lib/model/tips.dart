import 'package:equatable/equatable.dart';

class Tips extends Equatable {
  final int id;
  final String description;

  const Tips({required this.id, required this.description});

  @override
  List<Object?> get props => [description];
}
