import 'package:clima_link/domain/datasources/weather_datasource.dart';
import 'package:weatherapi/src/domains/realtime_weather.dart';
import 'package:weatherapi/weatherapi.dart';

class WeatherApiDataSource extends WeatherDataSource {
  final WeatherRequest _weather;

  WeatherApiDataSource(String apiKey) : _weather = WeatherRequest(apiKey);

  @override
  Future<RealtimeWeather> getCurrentByLocation(double lat, double lon) async {
    return await _weather.getRealtimeWeatherByLocation(lat, lon);
  }

  @override
  Future<ForecastWeather> getForecastByLocation(
      double lat, double lon, int days) async {
    return await _weather.getForecastWeatherByLocation(
      lat,
      lon,
      forecastDays: days,
    );
  }
}
