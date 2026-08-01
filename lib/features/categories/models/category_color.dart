import 'package:flutter/material.dart';

class CategoryColor {
  final int argb;
  final String? name;

  const CategoryColor({required this.argb, this.name});

  Color get color => Color(argb);

  String get displayName => name ?? 'Unknown';
}
