import 'package:expense_tracker_2/app/models/expanse_model.dart';
import 'package:expense_tracker_2/app/view/show_expense.dart';
import 'package:expense_tracker_2/app/widgets/expanse_item.dart';
import 'package:flutter/material.dart';

/// A widget that displays a list of expenses.
/// 
/// Each expense can be dismissed with a swipe gesture, and tapping on an expense
/// navigates to a detailed view of that expense.
class ExpensesList extends StatelessWidget {
  /// The list of expenses to display.
  final List<Expense> expenses;

  /// Callback function to handle the dismissal of an expense.
  final Function(Expense expanse) onDismissed;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        // Handle the dismissal of an expense item.
        onDismissed: (direction) {
          onDismissed(expenses[index]);
        },
        key: ValueKey(expenses[index].id),
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),
        ),
        child: InkWell(
          // Navigate to the detailed view of the expense when tapped.
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowExpensePage(expense: expenses[index]),
              ),
            );
          },
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}