import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Achievement extends Equatable {
  final String title;
  final String description;
  final String dialogDescription;
  final IconData icon;

  const Achievement({
    required this.title,
    required this.description,
    required this.dialogDescription,
    required this.icon,
  });

  @override
  List<Object?> get props => [title, description, icon];
}
