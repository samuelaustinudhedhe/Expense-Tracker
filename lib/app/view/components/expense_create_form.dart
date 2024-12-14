import 'package:flutter/material.dart';
import 'package:expense_tracker/app/models/expanse_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final pickDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: DateTime.now(),
    );
    // Set the selected date if the user picked a date
    if (pickDate != null) {
      setState(() {
        _selectedDate = pickDate;
      });
    }
  }

  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Price Error'),
          content: const Text('Please enter a valid Price for the expense.'),
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
      return;
    } else if (_titleController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Title Error'),
          content: const Text('Please enter a title for the expense.'),
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
      return;
    } else if (_selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Date Error'),
          content: const Text('Please enter a date for the expense.'),
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
      return;
    }

    // Create a new ExpenseModel instance
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    // Navigator.pop(context, _enteredTitle);

    print(_titleController.text);
    print(_amountController.text);
    print(_descriptionController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('hello Add new expense!'),
    
        // Title field
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: TextField(
            controller: _titleController,
            maxLength: 60,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
              hintText: 'Enter the expense title',
              border: OutlineInputBorder(),
            ),
          ),
        ),
    
        // Price field
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₦',
                    label: Text('Amount'),
                    hintText: 'Enter the expense amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'Select a date'
                        : dateFormatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.date_range)),
                  ],
                ),
              ),
            ],
          ),
        ),
    
        // Description field
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: TextField(
            controller: _descriptionController,
            maxLength: 260,
            minLines: 4,
            maxLines: 10,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Description'),
              hintText: 'Enter the expense description',
              border: OutlineInputBorder(),
              alignLabelWithHint: true, // Convert the text field to text area
            ),
          ),
        ),
        // Buttons to save and cancel the expense entry
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Text('Category:'),
                  const SizedBox(width: 8),
                  DropdownButton(
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
                      // Handle the selected category change
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
