import 'package:expense_tracker/app/models/expanse_model.dart';
import 'package:expense_tracker/app/view/components/expense_create_form.dart';
import 'package:expense_tracker/app/view/components/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Groceries',
      amount: 120.50,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Rent',
      amount: 500.00,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: Category.expense,
    ),
    Expense(
        title: 'Gas',
        amount: 30.75,
        date: DateTime.now().subtract(Duration(days: 2)),
        category: Category.food),
    Expense(
      title: 'Phone bill',
      amount: 65.25,
      date: DateTime.now().subtract(Duration(days: 3)),
      category: Category.expense,
    ),
  ];

  void _openExpenseModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
        child: NewExpense(
          onAddExpense: _addExpense,
        ),
      ),
    );
  }

// Add new Expanse
  void _addExpense(Expense expanse) {
    setState(() {
      _expenses.add(expanse);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expanse removed successfully!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _expenses.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses Tracker'),
          actions: [
            IconButton(
              onPressed: _openExpenseModal,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: _expenses.isEmpty
            ? const Center(
                child: Text(
                    'No Expenses found. Add some by tapping the + button.'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ExpensesList(
                      expenses: _expenses,
                      onDismissed: _removeExpense,
                    ),
                  )
                ],
              ));
  }
}
