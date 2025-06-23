import 'package:weatherapi/weatherapi.dart';

abstract class WeatherDataSource {
  Future<RealtimeWeather> getCurrentByLocation(double lat, double lon);
  Future<ForecastWeather> getForecastByLocation(
    double lat,
    double lon,
    int days,
  );
}
