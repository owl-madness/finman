import 'package:finman/features/categories/utils/category_utils.dart';
import 'package:flutter/material.dart';

class CategoryIcon {
  final String iconKey;
  final String? iconName;
  final IconData icon;

  const CategoryIcon({
    required this.iconKey,
    this.iconName,
    required this.icon,
  });

  String get displayName => iconName ?? formatCategoryIconName(iconKey);
}
