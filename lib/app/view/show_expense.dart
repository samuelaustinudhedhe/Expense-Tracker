import 'package:expense_tracker_2/app/components/expenses_details.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_2/app/models/expanse_model.dart';

/// A stateless widget that represents the page for displaying the details of a specific expense.
/// 
/// This page shows detailed information about an expense, such as its title, amount, date, and category.
class ShowExpensePage extends StatelessWidget {
  /// The [Expense] object whose details are to be displayed.
  final Expense expense;

  /// Creates a [ShowExpensePage] with the specified [expense].
  const ShowExpensePage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Details'), // Title of the app bar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding around the body content
        child: ExpenseDetails(expense: expense), // Displays the details of the expense
      ),
    );
  }
}