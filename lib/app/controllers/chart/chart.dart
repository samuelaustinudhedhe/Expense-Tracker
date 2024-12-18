import 'package:expense_tracker_2/app/models/expanse_model.dart';
import 'package:expense_tracker_2/app/controllers/chart/chart_bar.dart';
import 'package:flutter/material.dart';

/// A widget that displays a chart of expenses categorized by type.
/// 
/// The chart shows a bar for each category, with the height of the bar
/// representing the total expenses for that category.
class Chart extends StatelessWidget {
  /// The list of expenses to be displayed in the chart.
  final List<Expense> expenses;

  const Chart({super.key, required this.expenses});

  /// Computes the list of expense buckets, one for each category.
  /// 
  /// Each bucket contains the total expenses for its category.
  List<ExpenseBucket> get buckets {
    final List<ExpenseBucket> expenseBuckets = [];

    for (final category in Category.values) {
      expenseBuckets.add(ExpenseBucket.forCategory(expenses, category));
    }

    return expenseBuckets;
  }

  /// Computes the maximum total expense across all categories.
  /// 
  /// This value is used to determine the relative height of each bar in the chart.
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the app is in dark mode.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height < 300 ? 180 : 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // Iterate over each expense bucket
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}