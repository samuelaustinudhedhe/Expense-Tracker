import 'package:flutter/material.dart';
import 'package:expense_tracker_2/app/models/expanse_model.dart';
import 'package:intl/intl.dart';

/// A widget that displays detailed information about a specific expense.
/// 
/// This widget shows the title, amount, date, and description of the expense.
/// It uses a card layout to present the information in a visually appealing way.
class ExpenseDetails extends StatelessWidget {
  /// The expense to display details for.
  final Expense expense;

  const ExpenseDetails({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current theme and text theme for styling.
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Format the currency using the specified symbol.
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the title of the expense.
            Text(
              'Title: ${expense.title}',
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 16),

            // Display the formatted amount of the expense.
            Text(
              'Amount: ${currencyFormat.format(expense.amount)}',
              style: textTheme.titleSmall,
            ),
            SizedBox(height: 16),

            // Display the formatted date of the expense.
            Text(
              'Date: ${DateFormat.yMMMd().format(expense.date)}',
              style: textTheme.titleSmall,
            ),

            // Display the description of the expense.
            Text(
              expense.description,
              style: textTheme.bodyMedium,
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}