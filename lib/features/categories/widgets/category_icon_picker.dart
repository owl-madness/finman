import 'package:finman/features/categories/constants/category_icons.dart';
import 'package:finman/features/categories/models/category_icon.dart';
import 'package:flutter/material.dart';

class CategoryIconPicker extends StatelessWidget {
  const CategoryIconPicker({
    super.key,
    this.selectedIcon,
    this.scrollController,
  });
  final CategoryIcon? selectedIcon;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: categoryIcons.length,
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          final isSelected =
              selectedIcon?.iconKey == categoryIcons[index].iconKey;
          return InkWell(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: selectedIcon?.iconKey == categoryIcons[index].iconKey
                    ? colorScheme.primaryContainer
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    categoryIcons[index].icon,
                    color: isSelected
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                  ),
                  SizedBox(height: 5),
                  Text(
                    categoryIcons[index].displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.pop(context, categoryIcons[index]),
          );
        },
      ),
    );
  }
}
