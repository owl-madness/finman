import 'package:finman/features/categories/models/category_color.dart';

const categoryColors = [
  CategoryColor(
    argb: 0xFFF44336,
    name: 'Red',
  ),
  CategoryColor(
    argb: 0xFFE91E63,
    name: 'Pink',
  ),
  CategoryColor(
    argb: 0xFF9C27B0,
    name: 'Purple',
  ),
  CategoryColor(
    argb: 0xFF673AB7,
    name: 'Deep Purple',
  ),
  CategoryColor(
    argb: 0xFF3F51B5,
    name: 'Indigo',
  ),
  CategoryColor(
    argb: 0xFF2196F3,
    name: 'Blue',
  ),
  CategoryColor(
    argb: 0xFF009688,
    name: 'Teal',
  ),
  CategoryColor(
    argb: 0xFF4CAF50,
    name: 'Green',
  ),
  CategoryColor(
    argb: 0xFFFF9800,
    name: 'Orange',
  ),
  CategoryColor(
    argb: 0xFF795548,
    name: 'Brown',
  ),
  CategoryColor(
    argb: 0xFF607D8B,
    name: 'Blue Grey',
  ),
  CategoryColor(
    argb: 0xFF9E9E9E,
    name: 'Grey',
  ),
];

CategoryColor? getCategoryColor(int? value) {
  return categoryColors.where((e) => e.argb == value).firstOrNull;
}
