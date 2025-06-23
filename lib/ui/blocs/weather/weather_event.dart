part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class LoadWeatherAuto extends WeatherEvent {}

class ChangeForecastTypeEvent extends WeatherEvent {
  ForecastType type;
  ChangeForecastTypeEvent({required this.type});
}
