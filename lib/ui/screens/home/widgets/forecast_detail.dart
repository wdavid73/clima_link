import 'package:clima_link/config/config.dart';
import 'package:clima_link/ui/cubits/cubits.dart';
import 'package:clima_link/ui/shared/styles/app_spacing.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapi/weatherapi.dart';

class ForecastDetail extends StatelessWidget {
  final CurrentWeatherData currentWeatherData;
  final DayData dayData;

  const ForecastDetail({
    super.key,
    required this.currentWeatherData,
    required this.dayData,
  });

  String _getWindSpeed(WindSpeedUnit unit, CurrentWeatherData data) {
    if (unit == WindSpeedUnit.kph) {
      return '${data.windKph} km/h';
    } else if (unit == WindSpeedUnit.mph) {
      return '${data.windMph} mph';
    }
    return '';
  }

  String _getTemperatureFeelLike(
      TemperatureUnit unit, CurrentWeatherData data) {
    if (unit == TemperatureUnit.celsius) {
      return '${data.feelslikeC} °C';
    } else if (unit == TemperatureUnit.fahrenheit) {
      return '${data.feelslikeF} °F';
    }
    return '';
  }

  String _getMinTemperature(TemperatureUnit unit, DayData data) {
    if (unit == TemperatureUnit.celsius) {
      return '${data.mintempC} °C';
    } else if (unit == TemperatureUnit.fahrenheit) {
      return '${data.mintempF} °F';
    }
    return '';
  }

  String _getMaxTemperature(TemperatureUnit unit, DayData data) {
    if (unit == TemperatureUnit.celsius) {
      return '${data.maxtempC} °C';
    } else if (unit == TemperatureUnit.fahrenheit) {
      return '${data.maxtempF} °F';
    }
    return '';
  }

  String _getLastUpdateDate(String date, BuildContext context) {
    final dateParse = DateTime.parse(date);
    final locale = context.currentLocale();
    return DateFormat('d MMM y, hh:mm a', locale)
        .format(dateParse)
        .replaceAll('AM', 'a.m.')
        .replaceAll('PM', 'p.m.');
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>().state;

    final List<_WeatherDetail> details = [
      _WeatherDetail(
        icon: FluentIcons.weather_squalls_24_filled,
        label: context.l10n.wind,
        value: _getWindSpeed(settingsCubit.windSpeedUnit, currentWeatherData),
      ),
      _WeatherDetail(
        icon: FluentIcons.weather_cloudy_24_filled,
        label: context.l10n.humidity,
        value: '${currentWeatherData.humidity}%',
      ),
      _WeatherDetail(
        icon: FluentIcons.temperature_24_filled,
        label: context.l10n.thermalSensation,
        value: _getTemperatureFeelLike(
            settingsCubit.temperatureUnit, currentWeatherData),
      ),
      _WeatherDetail(
        icon: FluentIcons.temperature_24_filled,
        label: context.l10n.minimumTemperature,
        value: _getMinTemperature(settingsCubit.temperatureUnit, dayData),
      ),
      _WeatherDetail(
        icon: FluentIcons.temperature_24_filled,
        label: context.l10n.maximumTemperature,
        value: _getMaxTemperature(settingsCubit.temperatureUnit, dayData),
      ),
      _WeatherDetail(
        icon: FluentIcons.weather_rain_showers_day_24_filled,
        label: context.l10n.precipitation,
        value: '${currentWeatherData.precipMm} mm',
      ),
      _WeatherDetail(
        icon: FluentIcons.data_sunburst_24_filled,
        label: context.l10n.uvIndex,
        value: '${dayData.uv}',
      ),
      _WeatherDetail(
        icon: FluentIcons.eye_tracking_24_filled,
        label: context.l10n.visibility,
        value: '${currentWeatherData.visKm} Km',
      ),
      _WeatherDetail(
        icon: FluentIcons.weather_rain_showers_day_24_filled,
        label: context.l10n.dailyChangeOfRain,
        value: '${dayData.dailyChanceOfRain}%',
      ),
      _WeatherDetail(
        icon: FluentIcons.calendar_24_filled,
        label: context.l10n.lastUpdate,
        value: _getLastUpdateDate(currentWeatherData.lastUpdated!, context),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(context.l10n.moreDetails, style: context.textTheme.titleMedium),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: details.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.55,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              final item = details[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              item.label,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          AppSpacing.sm,
                          Icon(
                            item.icon,
                            size: context.dp(3),
                          ),
                        ],
                      ),
                      Text(
                        item.value,
                        style: context.textTheme.bodyMedium,
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
