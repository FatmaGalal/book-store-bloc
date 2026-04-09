import 'package:flutter/material.dart';

double getScalingFactor(BuildContext context) {
  // Get MediaQuery or return default reference width if not available
  final mediaQuery = MediaQuery.maybeOf(context);
  if (mediaQuery == null) return 1.0;

  // Check if the device is a tablet or iPad
  // A common threshold for tablets is a shortest side of 600 logical pixels
  final shortestSide = mediaQuery.size.shortestSide;
  if (shortestSide >= 600) {
    return 1.5;
  }

  final screenWidth = mediaQuery.size.width;

  // Reference width (can adjust for different baselines)
  // This represents the baseline device width for scaling calculations
  final referenceWidth =
      DeviceRegistry.referenceWidth; // like iPhone 16 Pro Max

  // Calculate raw scaling factor
  double scale = screenWidth / referenceWidth;

  // Limit max scale for readability
  // Prevents extreme scaling that could make text too small or too large
  return scale.clamp(0.9, 1.1);
}

class DeviceRegistry {
  // Reference width for scaling (e.g., iPhone 16 Pro Max)
  static const double referenceWidth = 430.0;
}
