import 'package:clima_link/config/config.dart';
import 'package:clima_link/config/helpers/lottie_helper.dart';
import 'package:clima_link/ui/blocs/weather/weather_bloc.dart';
import 'package:clima_link/ui/cubits/cubits.dart';
import 'package:clima_link/ui/shared/styles/app_spacing.dart';
import 'package:clima_link/ui/widgets/custom_dropdown_form_field.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapi/weatherapi.dart';

import './temperature_range_bar.dart';

class WeatherForecast extends StatelessWidget {
  final List<ForecastDayData> forecast;
  const WeatherForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 10,
        children: [
          // _SelectTypeForecast(),
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
                      Icon(
                        FluentIcons.calendar_ltr_48_filled,
                        size: context.dp(2.5),
                      ),
                      Text(
                        context.l10n.daysForecast,
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  AppSpacing.md,
                  ...forecast.asMap().entries.map((entry) {
                    final index = entry.key;
                    final day = entry.value;

                    final date = DateTime.parse(day.date!);
                    final label = index == 0
                        ? context.l10n.today
                        : DateFormat.E(context.currentLocale()).format(date);
                    final condition = day.day.condition.text!.toLowerCase();

                    final double minTemp =
                        settingsCubit.temperatureUnit == TemperatureUnit.celsius
                            ? day.day.mintempC!
                            : day.day.mintempF!;

                    final double maxTemp =
                        settingsCubit.temperatureUnit == TemperatureUnit.celsius
                            ? day.day.maxtempC!
                            : day.day.maxtempF!;

                    final double avgTemp =
                        settingsCubit.temperatureUnit == TemperatureUnit.celsius
                            ? day.day.avgtempC!
                            : day.day.avgtempF!;

                    final String unit =
                        settingsCubit.temperatureUnit == TemperatureUnit.celsius
                            ? '°C'
                            : '°F';

                    return _ForecastItem(
                      day: label,
                      minTemp: minTemp,
                      maxTemp: maxTemp,
                      currentTemp: avgTemp,
                      weather: condition,
                      unit: unit,
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
  final String unit;
  const _ForecastItem({
    required this.day,
    required this.minTemp,
    required this.maxTemp,
    required this.currentTemp,
    required this.weather,
    this.unit = '°C',
  });

  @override
  Widget build(BuildContext context) {
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
            Lottie.asset(
              LottieHelper.getWeatherLottie(condition: weather, isDay: true),
              width: context.dp(2.5),
              height: context.dp(2.5),
            ),
            Text(
              "$minTemp$unit",
              style: context.textTheme.labelLarge?.copyWith(
                color: ColorTheme.textSecondary,
              ),
            ),
            TemperatureRangeBar(
              minTemp: minTemp,
              maxTemp: maxTemp,
              currentTemp: currentTemp,
              width: 100,
            ),
            Text(
              "$maxTemp$unit",
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
    final state = context.watch<WeatherBloc>().state;

    final Map<ForecastType, String> options = {
      ForecastType.hourly: context.l10n.hourlyForecast,
      ForecastType.daily: context.l10n.dailyForecast,
    };
    return SizedBox(
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 26),
        child: CustomDropdownFormField<ForecastType>(
          prefixIcon: Icon(
            FluentIcons.time_and_weather_24_filled,
            size: context.dp(2),
          ),
          value: state.forecastType,
          options: ForecastType.values,
          onChanged: (val) {
            context.read<WeatherBloc>().changeForecastType(val!);
          },
          itemBuilder: (ForecastType option) => DropdownMenuItem(
            value: option,
            child: Text("${options[option]}"),
          ),
        ),
      ),
    );
  }
}
