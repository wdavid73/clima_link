import 'package:clima_link/domain/repositories/repositories.dart';
import 'package:weatherapi/weatherapi.dart';

class WeatherUsecase {
  final WeatherRepository repository;

  WeatherUsecase(this.repository);

  Future<RealtimeWeather> getCurrentByLocation(double lat, double lon) =>
      repository.getCurrentByLocation(lat, lon);

  Future<ForecastWeather> getForecastByLocation(double lat, double lon,
          {int days = 10}) =>
      repository.getForecastByLocation(lat, lon, days);
}
