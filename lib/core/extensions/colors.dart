import 'package:flutter/material.dart';

extension OpacityExtension on Color {
  Color withNewOpacity([double percent = 1]) {
    assert(percent >= 0.1 && percent <= 1, 'Opacity must not exceed 1');
    return withAlpha((255.0 * percent).round());
  }
}
