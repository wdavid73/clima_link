import 'package:clima_link/app/dependency_injection.dart';
import 'package:clima_link/ui/blocs/blocs.dart';
import 'package:clima_link/ui/cubits/cubits.dart';
import 'package:clima_link/ui/screens/home/widgets/home_body.dart';
import 'package:clima_link/ui/widgets/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt.get<WeatherBloc>()
              ..add(
                LoadWeatherAuto(),
              ),
          ),
          BlocProvider(create: (_) => getIt.get<SettingsCubit>()),
        ],
        child: HomeBody(),
      ),
    );
  }
}
