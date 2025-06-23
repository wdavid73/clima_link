import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  void changeTemperatureUnit(TemperatureUnit unit) {
    emit(state.copyWith(temperatureUnit: unit));
  }

  void changeWindSpeedUnit(WindSpeedUnit unit) {
    emit(state.copyWith(windSpeedUnit: unit));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
