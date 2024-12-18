import 'package:expense_tracker_2/app/models/expanse_model.dart';
import 'package:flutter/foundation.dart' as foundation;

/// Generates a list of mock expenses for development purposes.
List<Expense> getMockExpenses() {
  if (!foundation.kDebugMode) {
    return [];
  }

  final categories = Category.values;
  return List.generate(50, (index) {
    final category = categories[index % categories.length];
    return Expense(
      title: 'Expense ${category.name} $index',
      amount: (index + 1) * 1000.0, // Price in thousands
      date: DateTime.now().subtract(Duration(days: index)),
      category: category,
      description: 'Description for ${category.name} expense $index',
    );
  });
}