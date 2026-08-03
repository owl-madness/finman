import 'package:finman/core/database/app_database.dart';
import 'package:finman/core/validators/validators.dart';
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

  @override
  ConsumerState<CategoryFormScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isSaving = false;
  late final TextEditingController _nameController;
  late TransactionType _selectedType;
  CategoryIcon? _selectedIcon;
  CategoryColor? _selectedColor;
  String? _iconError;
  String? _colorError;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.category?.name ?? '');
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
        actions: widget.category == null
            ? null
            : [
                IconButton(
                  onPressed: () async {
                    final shouldDelete = await showAdaptiveDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog.adaptive(
                          title: const Text("Delete Category"),
                          content: const Text(
                            "Are you sure you want to delete this category?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                    if (shouldDelete == true) {
                      await ref
                          .read(categoriesProvider.notifier)
                          .deleteCategory(widget.category!);

                      if (!mounted) return;

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Category successfully deleted."),
                          ),
                        );

                        context.pop();
                      }
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) => Validators.required(
                    value,
                    fieldName: 'Category name',
                  ),
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
                        value: e,
                        label: Text(e.name.toUpperCase()),
                      ),
                    ),
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
                    final selectedIcon =
                        await showModalBottomSheet<CategoryIcon>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return SizedBox(
                          height: 420,
                          child:
                              CategoryIconPicker(selectedIcon: _selectedIcon),
                        );
                      },
                    );
                    if (selectedIcon != null) {
                      setState(() {
                        _selectedIcon = selectedIcon;

                        _iconError = null;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: _selectedIcon == null
                        ? const Text("Click to select Icon")
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_selectedIcon?.icon),
                              SizedBox(width: 10),
                              Text(_selectedIcon?.displayName ?? ""),
                            ],
                          ),
                  ),
                ),
                if (_iconError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _iconError!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
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
                              selectedColor: _selectedColor),
                        );
                      },
                    );
                    if (selectedColor != null) {
                      setState(() {
                        _selectedColor = selectedColor;
                        _colorError = null;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: _selectedColor == null
                        ? const Text("Click to select Color")
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
                                  shape: BoxShape.circle,
                                ),
                                // color: isSelected
                                //     ? colorScheme.onPrimaryContainer
                                //     : colorScheme.onSurface,
                              ),

                              SizedBox(width: 10),
                              Text(_selectedColor?.displayName ?? ""),
                            ],
                          ),
                  ),
                ),

                if (_colorError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _colorError!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSaving
                      ? null
                      : () async {
                          try {
                            FocusScope.of(context).unfocus();

                            final isFormValid =
                                _formKey.currentState!.validate();
                            final isIconSelected = _selectedIcon != null;
                            final isColorSelected = _selectedColor != null;

                            if (!isFormValid ||
                                !isIconSelected ||
                                !isColorSelected) {
                              setState(() {
                                _autovalidateMode =
                                    AutovalidateMode.onUserInteraction;
                                _iconError = isIconSelected
                                    ? null
                                    : 'Please select an icon';
                                _colorError = isColorSelected
                                    ? null
                                    : 'Please select a color';
                              });
                              return;
                            }

                            setState(() {
                              _isSaving = true;
                            });

                            final name = _nameController.text.trim();

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
                              await ref
                                  .read(categoriesProvider.notifier)
                                  .addCategory(
                                    name,
                                    _selectedType,
                                    _selectedIcon!.iconKey,
                                    _selectedColor!.argb,
                                  );
                            }
                            if (context.mounted) context.pop();
                          } catch (e) {
                            debugPrint(e.toString());
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isSaving = false;
                              });
                            }
                          }
                        },
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(widget.category != null ? 'Update' : 'Save'),
                ),
              ],
            ),
          ),
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
