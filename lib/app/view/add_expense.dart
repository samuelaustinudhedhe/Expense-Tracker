import 'package:expense_tracker_2/app/components/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_2/app/models/expanse_model.dart';

/// A stateless widget that represents the page for adding a new expense.
/// 
/// This page provides a form for the user to input details about a new expense
/// and submit it. The submitted expense is then passed to a callback function.
class AddExpensePage extends StatelessWidget {
  /// A callback function that is called when a new expense is added.
  /// 
  /// The function takes an [Expense] object as a parameter.
  final void Function(Expense expense) onAddExpense;

  /// Creates an [AddExpensePage] with the specified [onAddExpense] callback.
  const AddExpensePage({super.key, required this.onAddExpense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Expense'), // Title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body content
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Padding inside the scroll view
          child: ExpenseCreate(
            onAddExpense: onAddExpense, // Passes the callback to the form widget
          ),
        ),
      ),
    );
  }
}