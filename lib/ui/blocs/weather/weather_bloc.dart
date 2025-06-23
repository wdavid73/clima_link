import 'dart:developer';

import 'package:clima_link/config/helpers/location_helper.dart';
import 'package:clima_link/domain/usecases/weather_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapi/weatherapi.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase useCase;
  WeatherBloc(this.useCase) : super(WeatherState.initial()) {
    on<LoadWeatherAuto>(handlerLoadWeather);
    on<ChangeForecastTypeEvent>(handlerChangeForecastType);
  }

  void loadWeather() {
    add(LoadWeatherAuto());
  }

  void changeForecastType(ForecastType type) {
    add(ChangeForecastTypeEvent(type: type));
  }

  Future<void> handlerLoadWeather(
    LoadWeatherAuto event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final pos = await LocationHelper.getCurrentPosition();
      final current =
          await useCase.getCurrentByLocation(pos.latitude, pos.longitude);
      final forecast = await useCase
          .getForecastByLocation(pos.latitude, pos.longitude, days: 3);
      emit(state.copyWith(
        isLoading: false,
        current: current,
        forecast: forecast,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> handlerChangeForecastType(
    ChangeForecastTypeEvent event,
    Emitter<WeatherState> emit,
  ) async {
    log("Forecast Type: ${event.type}");
  }
}
