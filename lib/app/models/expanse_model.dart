import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

/// A globally accessible instance of the Uuid class for generating unique IDs.
const uuid = Uuid();

/// An enumeration representing different categories of expenses.
enum Category { income, bills, food, travel, work }

/// A map associating each [Category] with a corresponding [IconData].
/// This is used to display icons for each category in the UI.
const categoryIcons = {
  Category.income: Icons.money,
  Category.bills: Icons.money_off,
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

/// A date formatter for formatting dates in a 'yMd' format (e.g., 12/31/2023).
final dateFormatter = DateFormat.yMd();

/// A class representing an individual expense entry.
/// 
/// Each expense has a unique ID, title, amount, date, category, and an optional description.
class Expense {
  /// Creates an [Expense] with the given details.
  /// 
  /// The [id] is automatically generated using the [uuid] instance.
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.description = '',
  }) : id = uuid.v4();

  final String id; // Unique identifier for the expense
  final String title; // Title or name of the expense
  final double amount; // Amount of money spent
  final DateTime date; // Date of the expense
  final Category category; // Category of the expense
  final String description; // Optional description of the expense

  /// Returns the formatted date string for the expense.
  String get formattedDate {
    return dateFormatter.format(date);
  }
}

/// A class representing a collection of expenses grouped by category.
/// 
/// This class provides a way to calculate the total expenses for a specific category.
class ExpenseBucket {
  /// Creates an [ExpenseBucket] with the specified [category] and list of [expenses].
  const ExpenseBucket({required this.category, required this.expenses});

  /// Creates an [ExpenseBucket] for a specific [category] from a list of all expenses.
  /// 
  /// Filters the [allExpenses] list to include only those expenses that match the given [category].
  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category; // The category of expenses in this bucket
  final List<Expense> expenses; // List of expenses in this category

  /// Calculates and returns the total amount of expenses in this bucket.
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}