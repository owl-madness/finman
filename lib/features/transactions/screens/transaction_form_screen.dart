import 'package:finman/core/database/app_database.dart';
import 'package:finman/core/formatters/amount_input_formatter.dart';
import 'package:finman/core/utils/date_utils.dart' as core;
import 'package:finman/core/validators/validators.dart';
import 'package:finman/core/widgets/finman_confirm_dialog.dart';
import 'package:finman/core/widgets/finman_loading_button.dart';
import 'package:finman/core/widgets/finman_snackbar.dart';
import 'package:finman/core/widgets/finman_text_form_field.dart';
import 'package:finman/features/categories/providers/category_provider.dart';
import 'package:finman/features/transactions/models/transaction_model.dart';
import 'package:finman/features/transactions/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  const TransactionFormScreen({this.transactionModel, super.key});
  final TransactionModel? transactionModel;

  @override
  ConsumerState<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState extends ConsumerState<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isSaving = false;
  late final TextEditingController _amountController;
  late final TextEditingController _titleController;
  late final TextEditingController _noteController;
  Category? _selectedCategory;
  late DateTime _transactionDate;

  @override
  void initState() {
    _transactionDate = widget.transactionModel != null
        ? widget.transactionModel!.transactionDate
        : DateTime.now();
    _selectedCategory = widget.transactionModel?.category;
    _amountController = TextEditingController(
      text: widget.transactionModel != null
          ? (widget.transactionModel!.amount / 100).toStringAsFixed(2)
          : "",
    );
    _titleController = TextEditingController(
      text: widget.transactionModel != null
          ? widget.transactionModel!.title.toString()
          : "",
    );
    _noteController = TextEditingController(
      text: widget.transactionModel != null
          ? widget.transactionModel!.note.toString()
          : "",
    );
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transactionModel != null
              ? 'Edit transaction'
              : 'Add Transaction',
        ),
        actions: widget.transactionModel == null
            ? null
            : [
                IconButton(
                  onPressed: () async {
                    final shouldDelete = await FinmanConfirmDialog.show(
                      context,
                      title: 'Delete Transaction',
                      content:
                          'Are you sure you want to delete this transaction?',
                      confirmText: 'Delete',
                      isDestructive: true,
                    );

                    if (shouldDelete == true) {
                      try {
                        await ref
                            .read(transactionProvider.notifier)
                            .deleteTransaction(widget.transactionModel!.id!);

                        if (!mounted) return;

                        if (context.mounted) {
                          FinmanSnackbar.showSuccess(
                            context,
                            message: "Transaction successfully deleted.",
                          );
                          context.pop();
                        }
                      } catch (e) {
                        debugPrint(e.toString());

                        if (context.mounted) {
                          FinmanSnackbar.showError(
                            context,
                            message: 'Failed to delete transaction.',
                          );
                        }
                      }
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
      ),
      body: categoryAsync.when(
        data: (categories) {
          final dropdownCategories = [...categories];
          if (_selectedCategory?.isSystem == true) {
            dropdownCategories.insert(0, _selectedCategory!);
          }
          return Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    FinmanTextFormField(
                      controller: _amountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: Validators.amount,
                      inputFormatters: [
                        AmountInputFormatter.decimal(),
                      ],
                      textInputAction: TextInputAction.next,
                      labelText: 'Amount',
                      hintText: '(in rupees) Eg. 100, 200',
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<Category>(
                      initialValue: _selectedCategory,
                      hint: const Text("Select category"),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      items: dropdownCategories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    FinmanTextFormField(
                      controller: _titleController,
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Title'),
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      labelText: 'Title',
                      hintText: 'Eg. Lunch from KFC',
                    ),
                    const SizedBox(height: 24),
                    FinmanTextFormField(
                      controller: _noteController,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      labelText: 'Note',
                      hintText: 'Description',
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Transaction Date'),
                      subtitle: Text(
                        core.DateUtils.formatDate(_transactionDate),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: _transactionDate,
                          firstDate: DateTime(DateTime.now().year - 2),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            _transactionDate = selectedDate;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    FinmanLoadingButton(
                      text: widget.transactionModel != null ? 'Update' : 'Save',
                      isLoading: _isSaving,
                      onPressed: () async {
                        try {
                          FocusScope.of(context).unfocus();
                          if (!_formKey.currentState!.validate()) {
                            setState(() {
                              _autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });
                            return;
                          }

                          setState(() {
                            _isSaving = true;
                          });

                          final amount =
                              double.parse(_amountController.text.trim());
                          final title = _titleController.text.trim();

                          final amountInPaisa = (amount * 100).round();
                          if (widget.transactionModel != null) {
                            final transaction =
                                widget.transactionModel!.copyWith(
                              amount: amountInPaisa,
                              title: title,
                              note: _noteController.text.trim(),
                              transactionDate: _transactionDate,
                              category: _selectedCategory,
                            );

                            await ref
                                .read(transactionProvider.notifier)
                                .updateTransaction(transaction);
                          } else {
                            final transaction = TransactionModel.create(
                              amount: amountInPaisa,
                              title: title,
                              note: _noteController.text.trim(),
                              transactionDate: _transactionDate,
                              category: _selectedCategory!,
                            );

                            await ref
                                .read(transactionProvider.notifier)
                                .addTransaction(transaction);
                          }

                          if (context.mounted) context.pop();
                        } catch (e) {
                          debugPrint(e.toString());
                          if (context.mounted) {
                            FinmanSnackbar.showError(
                              context,
                              message: 'Failed to save transaction.',
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isSaving = false;
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
