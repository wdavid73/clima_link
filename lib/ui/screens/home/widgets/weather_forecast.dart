import 'package:clima_link/config/config.dart';
import 'package:clima_link/ui/shared/styles/app_spacing.dart';
import 'package:clima_link/ui/widgets/custom_dropdown_form_field.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapi/weatherapi.dart';

import './temperature_range_bar.dart';

class WeatherForecast extends StatelessWidget {
  final List<ForecastDayData> forecast;
  const WeatherForecast({super.key, required this.forecast});

  String _mapConditionToKey(String condition) {
    if (condition.contains('thunder')) return 'thunderstorm';
    if (condition.contains('snow') || condition.contains('blizzard')) {
      return 'snow';
    }
    if (condition.contains('rain') ||
        condition.contains('drizzle') ||
        condition.contains('shower')) {
      return 'rain';
    }
    if (condition.contains('fog') ||
        condition.contains('mist') ||
        condition.contains('haze')) {
      return 'fog';
    }
    if (condition.contains('cloud') || condition.contains('overcast')) {
      return 'cloudy';
    }
    if (condition.contains('wind') || condition.contains('squall')) {
      return 'wind';
    }
    return 'clear_day';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 10,
        children: [
          _SelectTypeForecast(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Icon(FluentIcons.calendar_ltr_48_filled),
                      Text("10-Day Forecast"),
                    ],
                  ),
                  AppSpacing.md,
                  ...forecast.asMap().entries.map((entry) {
                    final index = entry.key;
                    final day = entry.value;

                    final date = DateTime.parse(day.date!);
                    final label =
                        index == 0 ? "Today" : DateFormat.E().format(date);
                    final condition = day.day.condition.text!.toLowerCase();
                    final mappedIcon = _mapConditionToKey(condition);

                    return _ForecastItem(
                      day: label,
                      minTemp: day.day.mintempC!,
                      maxTemp: day.day.maxtempC!,
                      currentTemp: day.day.avgtempC!,
                      weather: mappedIcon,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final String day;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final String weather;
  const _ForecastItem({
    required this.day,
    required this.minTemp,
    required this.maxTemp,
    required this.currentTemp,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> icons = {
      // Clear / sunny
      'clear_day': FluentIcons.weather_sunny_24_filled,
      'clear_night': FluentIcons.weather_moon_24_filled,
      // Partly cloudy
      'partly_cloudy_day': FluentIcons.weather_partly_cloudy_day_24_filled,
      'partly_cloudy_night': FluentIcons.weather_partly_cloudy_night_24_filled,
      // Cloudy
      'cloudy': FluentIcons.weather_cloudy_24_filled,
      // Rain
      'rain': FluentIcons.weather_rain_24_filled,
      'showers': FluentIcons.weather_rain_showers_day_24_filled,
      // Thunderstorm
      'thunderstorm': FluentIcons.weather_thunderstorm_24_filled,
      // Snow
      'snow': FluentIcons.weather_snow_24_filled,
      'snow_showers': FluentIcons.weather_snow_shower_day_24_filled,
      // Fog / mist
      'fog': FluentIcons.weather_fog_24_filled,
      // Additional: windy, drizzle, hail
      'wind': FluentIcons.weather_squalls_24_filled,
      'drizzle': FluentIcons.weather_drizzle_24_filled,
      'sleet': FluentIcons.weather_rain_snow_24_filled,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 2,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            SizedBox(
              width: context.wp(10),
              child: Text(
                day,
                style: context.textTheme.labelLarge,
              ),
            ),
            Icon(icons[weather]),
            Text(
              "$minTemp°",
              style: context.textTheme.labelLarge?.copyWith(
                color: ColorTheme.textSecondary,
              ),
            ),
            TemperatureRangeBar(
              minTemp: minTemp,
              maxTemp: maxTemp,
              currentTemp: currentTemp,
            ),
            Text(
              "$maxTemp°",
              style: context.textTheme.labelLarge,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}

class _SelectTypeForecast extends StatelessWidget {
  const _SelectTypeForecast();

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      "Hourly Forecast",
      "Daily Forecast",
      "Monthly Forecast",
    ];
    return SizedBox(
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 26),
        child: CustomDropdownFormField(
          prefixIcon: Icon(
            FluentIcons.time_and_weather_24_filled,
            size: context.dp(2),
          ),
          options: options,
          onChanged: (val) {},
          itemBuilder: (option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          ),
        ),
      ),
    );
  }
}
