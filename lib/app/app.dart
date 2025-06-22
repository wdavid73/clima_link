import 'package:flutter/material.dart';
import 'package:clima_link/app/dependency_injection.dart';
import 'package:clima_link/config/config.dart';
import 'package:clima_link/ui/blocs/blocs.dart';
import 'package:go_router/go_router.dart';

/// The [GoRouter] instance used for navigation.
GoRouter? _router;

final _authBloc = getIt<AuthBloc>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    _router ??= createAppRouter(_authBloc);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: Environment.appName,
      theme: AppTheme.getLightTheme(context),
      darkTheme: AppTheme.getDarkTheme(context),
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
