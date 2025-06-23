import 'package:clima_link/domain/datasources/weather_datasource.dart';
import 'package:clima_link/domain/repositories/weather_repository.dart';
import 'package:weatherapi/src/domains/forecast_weather.dart';
import 'package:weatherapi/src/domains/realtime_weather.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<RealtimeWeather> getCurrentByLocation(double lat, double lon) =>
      dataSource.getCurrentByLocation(lat, lon);

  @override
  Future<ForecastWeather> getForecastByLocation(
          double lat, double lon, int days) =>
      dataSource.getForecastByLocation(lat, lon, days);
}
