part of 'settings_cubit.dart';

enum TemperatureUnit { celsius, fahrenheit }

enum WindSpeedUnit { kph, mph }

class SettingsState extends Equatable {
  final TemperatureUnit temperatureUnit;
  final WindSpeedUnit windSpeedUnit;

  const SettingsState({
    this.temperatureUnit = TemperatureUnit.celsius,
    this.windSpeedUnit = WindSpeedUnit.kph,
  });

  @override
  List<Object> get props => [
        temperatureUnit,
        windSpeedUnit,
      ];

  SettingsState copyWith({
    TemperatureUnit? temperatureUnit,
    WindSpeedUnit? windSpeedUnit,
  }) {
    return SettingsState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      windSpeedUnit: windSpeedUnit ?? this.windSpeedUnit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperatureUnit': temperatureUnit.index,
      'windSpeedUnit': windSpeedUnit.index,
    };
  }

  static SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState(
      temperatureUnit: TemperatureUnit.values[json['temperatureUnit']],
      windSpeedUnit: WindSpeedUnit.values[json['windSpeedUnit']],
    );
  }
}
