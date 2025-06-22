import 'package:flutter/material.dart';

/// A reusable temperature range bar widget, typically used to visualize
/// the daily minimum and maximum temperatures in a weather forecast UI.
///
/// Optionally, you can also show the current temperature as a white dot
/// positioned proportionally along the bar.
///
/// Example usage:
/// ```dart
/// TemperatureRangeBar(
///   minTemp: 22,
///   maxTemp: 34,
///   currentTemp: 28,
/// )
/// ```
class TemperatureRangeBar extends StatelessWidget {
  /// The minimum temperature value to represent.
  final double minTemp;

  /// The maximum temperature value to represent.
  final double maxTemp;

  /// (Optional) The current temperature to show as a dot on the bar.
  final double? currentTemp;

  /// The total width of the bar.
  final double width;

  /// The total height of the widget.
  final double height;

  /// The color used to fill the temperature range bar.
  final Color minRangeColor;

  /// The color used to fill the temperature range bar.
  final Color maxRangeColor;

  /// The color used for the background track.
  final Color trackColor;

  /// The color of the dot that represents the current temperature.
  final Color currentDotColor;

  /// Creates a temperature range bar with optional current temperature indicator.
  const TemperatureRangeBar({
    super.key,
    required this.minTemp,
    required this.maxTemp,
    this.currentTemp,
    this.width = 120,
    this.height = 12,
    this.minRangeColor = Colors.orange,
    this.maxRangeColor = Colors.red,
    this.trackColor = const Color(0xFF444444),
    this.currentDotColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final double barHeight = height * 0.33;
    final double centerY = (height - barHeight) / 2;

    double? currentPos;
    if (currentTemp != null) {
      currentPos = ((currentTemp! - minTemp) / (maxTemp - minTemp)) * width;
      currentPos = currentPos.clamp(0, width);
    }

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // Background track
          Positioned(
            top: centerY,
            left: 0,
            right: 0,
            child: Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(barHeight),
              ),
            ),
          ),
          // Temperature range fill
          Positioned(
            top: centerY,
            left: 0,
            width: width,
            child: Container(
              height: barHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [minRangeColor.withValues(alpha: 0.9), maxRangeColor],
                ),
                borderRadius: BorderRadius.circular(barHeight),
              ),
            ),
          ),
          // Current temperature dot
          if (currentPos != null)
            Positioned(
              left: currentPos - 2,
              top: 0,
              child: Container(
                width: 4,
                height: height,
                decoration: BoxDecoration(
                  color: currentDotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
