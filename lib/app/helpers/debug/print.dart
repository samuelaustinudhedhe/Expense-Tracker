import 'package:flutter/foundation.dart' as foundation;

/// This custom debugPrint function should be used instead of the regular print function.
/// It ensures that the output is only printed in debug mode, preventing unnecessary logs
/// in release builds.

void debugPrint(final print) {
  if (foundation.kDebugMode) {
    foundation.debugPrint(print);
  }
}