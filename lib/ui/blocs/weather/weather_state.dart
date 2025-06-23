part of 'weather_bloc.dart';

enum ForecastType { hourly, daily }

class WeatherState extends Equatable {
  final RealtimeWeather? current;
  final ForecastWeather? forecast;
  final String? errorMessage;
  final bool isLoading;
  final ForecastType forecastType;

  const WeatherState({
    this.isLoading = false,
    this.current,
    this.forecast,
    this.errorMessage,
    this.forecastType = ForecastType.daily,
  });

  @override
  List<Object> get props => [
        isLoading,
        forecastType,
      ];

  WeatherState copyWith({
    bool? isLoading,
    RealtimeWeather? current,
    ForecastWeather? forecast,
    String? errorMessage,
    ForecastType? forecastType,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
      errorMessage: errorMessage ?? this.errorMessage,
      forecastType: forecastType ?? this.forecastType,
    );
  }

  factory WeatherState.initial() => const WeatherState();
}
