import 'package:finman/core/database/app_database.dart';
import 'package:finman/features/categories/constants/category_colors.dart';
import 'package:finman/features/categories/constants/category_icons.dart';
import 'package:finman/features/categories/models/category_color.dart';
import 'package:finman/features/categories/models/category_icon.dart';
import 'package:finman/features/categories/providers/category_provider.dart';
import 'package:finman/features/categories/widgets/category_color_picker.dart';
import 'package:finman/features/categories/widgets/category_icon_picker.dart';
import 'package:finman/features/transactions/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryFormScreen extends ConsumerStatefulWidget {
  const CategoryFormScreen({this.category, super.key});
  final Category? category;

  static const String routePath = '/categories/add';

  @override
  ConsumerState<CategoryFormScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<CategoryFormScreen> {
  late final TextEditingController _nameController;
  late TransactionType _selectedType;
  CategoryIcon? _selectedIcon;
  CategoryColor? _selectedColor;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.category?.name ?? '',
    );
    _selectedType = widget.category?.type ?? TransactionType.expense;
    _selectedIcon = getCategoryIcon(widget.category?.icon ?? "");
    _selectedColor = getCategoryColor(widget.category?.color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category != null ? 'Edit Category' : 'Add Category'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: 'e.g. Food',
              ),
            ),
            const SizedBox(height: 24),
            SegmentedButton<TransactionType>(
              segments: [
                ...TransactionType.values.map(
                  (e) => ButtonSegment(
                      value: e, label: Text(e.name.toUpperCase())),
                )
              ],
              selected: {_selectedType},
              onSelectionChanged: (selection) {
                setState(() {
                  _selectedType = selection.first;
                });
              },
            ),
            const SizedBox(height: 24),

            // icon picker
            OutlinedButton(
                onPressed: () async {
                  final selectedIcon = await showModalBottomSheet<CategoryIcon>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return SizedBox(
                        height: 420,
                        child: CategoryIconPicker(
                          selectedIcon: _selectedIcon,
                        ),
                      );
                    },
                  );
                  if (selectedIcon != null) {
                    setState(() {
                      _selectedIcon = selectedIcon;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: _selectedIcon == null
                      ? Text("Click to select Icon")
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_selectedIcon?.icon),
                            SizedBox(
                              width: 10,
                            ),
                            Text(_selectedIcon?.displayName ?? "")
                          ],
                        ),
                )),
            const SizedBox(height: 24),

            // color picker
            OutlinedButton(
                onPressed: () async {
                  final selectedColor =
                      await showModalBottomSheet<CategoryColor>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return SizedBox(
                        height: 420,
                        child: CategoryColorPicker(
                          selectedColor: _selectedColor,
                        ),
                      );
                    },
                  );
                  if (selectedColor != null) {
                    setState(() {
                      _selectedColor = selectedColor;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: _selectedColor == null
                      ? Text("Click to select Color")
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Container(color: Color(_selectedColor!.argb)),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(_selectedColor!.argb),
                                  shape: BoxShape.circle),
                              // color: isSelected
                              //     ? colorScheme.onPrimaryContainer
                              //     : colorScheme.onSurface,
                            ),

                            SizedBox(
                              width: 10,
                            ),
                            Text(_selectedColor?.displayName ?? "")
                          ],
                        ),
                )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                try {
                  debugPrint(_nameController.text);
                  final name = _nameController.text.trim();

                  if (name.isEmpty ||
                      _selectedIcon == null ||
                      _selectedColor == null) {
                    return;
                  }
                  if (widget.category != null) {
                    final updatedCategory = widget.category!.copyWith(
                      name: name,
                      type: _selectedType,
                      icon: _selectedIcon!.iconKey,
                      color: _selectedColor!.argb,
                    );

                    await ref
                        .read(categoriesProvider.notifier)
                        .updateCategory(updatedCategory);
                  } else {
                    await ref.read(categoriesProvider.notifier).addCategory(
                        name,
                        _selectedType,
                        _selectedIcon!.iconKey,
                        _selectedColor!.argb);
                  }
                  if (context.mounted) context.pop();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: Text(widget.category != null ? 'Update' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
