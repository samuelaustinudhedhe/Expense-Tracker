import 'package:expense_tracker/app/models/expanse_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [
            Text(expense.title,style: const TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold,
              
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '₦${expense.amount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
