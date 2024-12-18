import 'package:flutter/material.dart';

/// A widget that represents a bar in a chart, with a fill level indicating the data value.
/// 
/// The bar's color changes based on the current theme (dark or light mode).
class ChartBar extends StatelessWidget {
  /// The fill level of the bar, represented as a fraction of the total height.
  final double fill;

  const ChartBar({
    super.key,
    required this.fill,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the app is in dark mode.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          // Set the height of the bar based on the fill level.
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              // Change the color of the bar based on the theme.
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}