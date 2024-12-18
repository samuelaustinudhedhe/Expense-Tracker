import 'package:expense_tracker_2/app/components/expenses_list.dart'; // Importing the ExpensesList component.
import 'package:expense_tracker_2/app/models/mock/expanse_model_mock.dart';
import 'package:expense_tracker_2/app/view/add_expense.dart'; // Importing the AddExpensePage view.
import 'package:flutter/material.dart'; // Importing Flutter's material design library.
import 'package:expense_tracker_2/app/models/expanse_model.dart'; // Importing the Expense model.
import 'package:expense_tracker_2/app/controllers/chart/chart.dart'; // Importing the Chart controller.

/// A StatefulWidget that represents the main screen for tracking expenses.
class Expenses extends StatefulWidget {
  /// Creates an instance of [Expenses].
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState(); // Creates the mutable state for this widget.
}

/// The state for the [Expenses] widget.
class _ExpensesState extends State<Expenses> {
  /// A list of expenses to be displayed and managed.
  final List<Expense> _expenses = getMockExpenses();


  /// Navigates to the [AddExpensePage] to add a new expense.
  ///
  /// This function pushes a new route to the navigator stack, allowing the user
  /// to add a new expense. The new expense is added to the list when the user
  /// completes the action on the [AddExpensePage].
  void _navigateToAddExpensePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddExpensePage(
          onAddExpense: _addExpense, // Callback to add the expense.
        ),
      ),
    );
  }

  /// Adds a new expense to the list.
  ///
  /// This function takes an [expense] as a parameter and adds it to the list
  /// of expenses. It then calls [setState] to update the UI.
  ///
  /// [expense] is the new expense to be added.
  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense); // Adds the new expense to the list.
    });
  }

  /// Removes an expense from the list and shows a SnackBar with an undo option.
  ///
  /// This function removes the specified [expense] from the list of expenses.
  /// It also displays a SnackBar to notify the user of the removal and provides
  /// an option to undo the action, which will reinsert the expense at its original
  /// position in the list.
  ///
  /// If the user chooses to undo the removal, the expense is reinserted into the
  /// list at the same index from which it was removed.
  ///
  /// [expense] is the expense to be removed from the list.
  void _removeExpense(Expense expense) {
    final index = _expenses.indexOf(expense); // Finds the index of the expense.
    setState(() {
      _expenses.remove(expense); // Removes the expense from the list.
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // Clears any existing SnackBars.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense removed successfully!'), // Message displayed in the SnackBar.
        duration: const Duration(seconds: 3), // Duration for which the SnackBar is displayed.
        action: SnackBarAction(
          label: 'Undo', // Label for the undo action.
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense); // Reinserts the expense at its original position.
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // Gets the width of the screen.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'), // Title of the app bar.
        actions: [
          IconButton(
            onPressed: _navigateToAddExpensePage, // Navigates to the add expense page.
            icon: const Icon(Icons.add), // Icon for the add button.
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (_expenses.isEmpty) {
            return const Center(
              child: Text('No expenses found. Add some by tapping the + button.'), // Message when no expenses are found.
            );
          } else if (width < 800) {
            return Column(
              children: [
                Chart(expenses: _expenses), // Displays the chart for expenses.
                Expanded(
                  child: ExpensesList(
                    expenses: _expenses, // List of expenses.
                    onDismissed: _removeExpense, // Callback to remove an expense.
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: Chart(expenses: _expenses), // Displays the chart for expenses.
                ),
                Expanded(
                  child: ExpensesList(
                    expenses: _expenses, // List of expenses.
                    onDismissed: _removeExpense, // Callback to remove an expense.
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}