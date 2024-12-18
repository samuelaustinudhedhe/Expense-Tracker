import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_2/app/models/expanse_model.dart';
import 'package:intl/intl.dart';

/// A widget that provides a form for creating a new expense.
///
/// This widget allows users to input details about an expense, including
/// the title, amount, date, description, and category. It supports both
/// iOS and Android platforms, using platform-specific widgets where appropriate.
class ExpenseCreate extends StatefulWidget {
  const ExpenseCreate({super.key, required this.onAddExpense});

  /// Callback function to handle the addition of a new expense.
  final void Function(Expense expense) onAddExpense;

  @override
  _ExpenseCreateState createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    // Dispose controllers to free up resources when the widget is removed from the widget tree.
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  /// Displays a date picker for the user to select a date.
  ///
  /// Uses a CupertinoDatePicker for iOS and a Material date picker for other platforms.
  void _showDatePicker() async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => Container(
          height: 250,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime.now().subtract(const Duration(days: 365)),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            onDateTimeChanged: (pickedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
            },
          ),
        ),
      );
    } else {
      final pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 30)),
        initialDate: DateTime.now(),
      );
      if (pickDate != null) {
        setState(() {
          _selectedDate = pickDate;
        });
      }
    }
  }

  /// Displays an alert dialog with a given title and content.
  ///
  /// Uses a CupertinoAlertDialog for iOS and a Material AlertDialog for other platforms.
  void _showAlertDialog(String title, String content) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(ctx, null);
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(ctx, null);
              },
            ),
          ],
        ),
      );
    }
  }

  /// Validates the form inputs and submits the form if valid.
  ///
  /// Displays an alert dialog if any input is invalid.
  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsInvalid) {
      _showAlertDialog(
          'Price Error', 'Please enter a valid Price for the expense.');
      return;
    } else if (_titleController.text.isEmpty) {
      _showAlertDialog('Title Error', 'Please enter a title for the expense.');
      return;
    } else if (_selectedDate == null) {
      _showAlertDialog('Date Error', 'Please enter a date for the expense.');
      return;
    }

    // Create a new Expense object and pass it to the onAddExpense callback.
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
        description: _descriptionController.text,
      ),
    );

    // Close the modal after submitting the form.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
       return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a new expense',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Title input field
          TextField(
            controller: _titleController,
            maxLength: 60,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter the expense title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Amount input field
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '₦',
              labelText: 'Amount',
              hintText: 'Enter the expense amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Date picker
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'Select a date'
                      : DateFormat.yMMMd().format(_selectedDate!),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: _showDatePicker,
                icon: const Icon(Icons.date_range),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description input field
          TextField(
            controller: _descriptionController,
            maxLength: 260,
            minLines: 4,
            maxLines: 10,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter the expense description',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),

          // Category dropdown
          Row(
            children: [
              const Text('Category:', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              DropdownButton<Category>(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
