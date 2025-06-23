import 'package:clima_link/api/api.dart';
import 'package:clima_link/config/config.dart';
import 'package:clima_link/data/data.dart';
import 'package:clima_link/data/datasources/weather_api_datasource.dart';
import 'package:clima_link/data/repositories/weather_repository_impl.dart';
import 'package:clima_link/domain/repositories/repositories.dart';
import 'package:clima_link/domain/usecases/usecases.dart';
import 'package:clima_link/domain/usecases/weather_usecase.dart';
import 'package:clima_link/ui/blocs/blocs.dart';
import 'package:clima_link/ui/cubits/cubits.dart';
import 'package:clima_link/ui/shared/service/service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class AppDependencyInjection {
  static void init() {
    /// Repositories
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        ApiAuthDataSource(ApiClient.instance),
      ),
    );

    getIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        WeatherApiDataSource(Environment.weatherApiKey),
      ),
    );

    /// UseCases
    getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<WeatherUsecase>(
      () => WeatherUsecase(
        getIt.get<WeatherRepository>(),
      ),
    );

    /// Services
    getIt.registerLazySingleton<KeyValueStorageService>(
      () => KeyValueStorageServiceImpl(),
    );

    ///  Cubits and BLoCs

    // Singleton
    getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit());
    getIt.registerLazySingleton<ThemeModeCubit>(() => ThemeModeCubit());

    getIt.registerLazySingleton<IntroductionCubit>(
      () => IntroductionCubit(getIt.get<KeyValueStorageService>()),
    );

    getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getIt<AuthUseCase>(),
        getIt<KeyValueStorageService>(),
      ),
    );

    // Factory
    getIt.registerFactory<WeatherBloc>(
      () => WeatherBloc(
        getIt.get<WeatherUsecase>(),
      ),
    );

    getIt.registerFactory<SignInFormCubit>(
      () => SignInFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );

    getIt.registerFactory<RegisterFormCubit>(
      () => RegisterFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );
  }
}
