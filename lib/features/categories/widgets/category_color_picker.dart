import 'package:finman/features/categories/constants/category_colors.dart';
import 'package:finman/features/categories/models/category_color.dart';
import 'package:flutter/material.dart';

class CategoryColorPicker extends StatelessWidget {
  const CategoryColorPicker(
      {super.key, this.selectedColor, this.scrollController});
  final CategoryColor? selectedColor;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: categoryColors.length,
        controller: scrollController,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          final isSelected = selectedColor?.argb == categoryColors[index].argb;
          return InkWell(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? colorScheme.primaryContainer
                      : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(categoryColors[index].argb),
                        shape: BoxShape.circle),
                    // color: isSelected
                    //     ? colorScheme.onPrimaryContainer
                    //     : colorScheme.onSurface,
                  ),
                  // SizedBox(height: 5),
                  // Text(
                  //   categoryColors[index].displayName,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: isSelected
                  //         ? colorScheme.onPrimaryContainer
                  //         : colorScheme.onSurface,
                  //   ),
                  // ),
                ],
              ),
            ),
            onTap: () => Navigator.pop(context, categoryColors[index]),
          );
        },
      ),
    );
  }
}
