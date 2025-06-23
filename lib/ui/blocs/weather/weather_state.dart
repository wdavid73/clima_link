part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final RealtimeWeather? current;
  final ForecastWeather? forecast;
  final String? errorMessage;
  final bool isLoading;

  const WeatherState({
    this.isLoading = false,
    this.current,
    this.forecast,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  WeatherState copyWith({
    bool? isLoading,
    RealtimeWeather? current,
    ForecastWeather? forecast,
    String? errorMessage,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory WeatherState.initial() => const WeatherState();
}
