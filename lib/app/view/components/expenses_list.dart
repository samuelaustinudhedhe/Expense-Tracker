import 'package:expense_tracker/app/models/expanse_model.dart';
import 'package:expense_tracker/app/widgets/expanse_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismissed});

  final List<Expense> expenses;
  final Function(Expense expanse) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        onDismissed: (direction) {
          onDismissed(expenses[index]);
        },
        key: ValueKey(expenses[index].id),
        child: ExpenseItem(expenses[index]),
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),
          
        ),
      ),
    );
  }
}
