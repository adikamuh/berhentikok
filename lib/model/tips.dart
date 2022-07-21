import 'package:equatable/equatable.dart';

class Tips extends Equatable {
  final String description;

  const Tips(this.description);

  @override
  List<Object?> get props => [description];
}
