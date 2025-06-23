class LottieHelper {
  static String getWeatherLottie(
      {required String condition, required bool isDay}) {
    final c = condition.toLowerCase();

    if (c.contains('thunder')) return 'assets/lotties/thunder.json';
    if (c.contains('snow') || c.contains('blizzard')) {
      return isDay ? 'assets/lotties/snowy.json' : 'assets/lotties/snowy.json';
    }
    if (c.contains('rain') || c.contains('drizzle') || c.contains('showers')) {
      return isDay
          ? 'assets/lotties/sunny_rain.json'
          : 'assets/lotties/night_rain.json';
    }
    if (c.contains('cloud') || c.contains('overcast')) {
      return isDay
          ? 'assets/lotties/cloudy.json'
          : 'assets/lotties/night_cloudy.json';
    }
    if (c.contains('fog') || c.contains('mist') || c.contains('haze')) {
      return 'assets/lotties/misty.json';
    }

    return isDay ? 'assets/lotties/sunny.json' : 'assets/lotties/night.json';
  }
}
