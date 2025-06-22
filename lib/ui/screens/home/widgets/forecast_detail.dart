import 'package:clima_link/config/config.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ForecastDetail extends StatelessWidget {
  const ForecastDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_WeatherDetail> details = [
      _WeatherDetail(
        icon: FluentIcons.weather_squalls_24_filled,
        label: 'Wind',
        value: '10 km/h',
      ),
      _WeatherDetail(
        icon: FluentIcons.weather_cloudy_24_filled,
        label: 'Humidity',
        value: '70%',
      ),
      _WeatherDetail(
        icon: FluentIcons.temperature_24_filled,
        label: 'Thermal sensation',
        value: '20°',
      ),
      _WeatherDetail(
        icon: FluentIcons.temperature_24_filled,
        label: 'Minimum temperature',
        value: '18°',
      ),
      _WeatherDetail(
        icon: FluentIcons.temperature_24_filled,
        label: 'Maximum temperature',
        value: '26°',
      ),
      _WeatherDetail(
        icon: FluentIcons.weather_rain_showers_day_24_filled,
        label: 'Precipitation',
        value: '10%',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text("More details", style: context.textTheme.titleMedium),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: details.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = details[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        item.icon,
                        size: context.dp(2),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.label,
                            style: context.textTheme.titleMedium,
                          ),
                          Text(
                            item.value,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WeatherDetail {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });
}
