import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HealthProgress extends Equatable {
  final IconData icon;
  final String caption;
  final int value;

  const HealthProgress({
    required this.icon,
    required this.caption,
    required this.value,
  });

  @override
  List<Object?> get props => [icon, caption, value];
}
