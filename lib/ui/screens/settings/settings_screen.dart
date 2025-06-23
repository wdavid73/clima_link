import 'package:clima_link/app/dependency_injection.dart';
import 'package:clima_link/ui/cubits/cubits.dart';
import 'package:clima_link/ui/shared/shared.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:clima_link/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String systemLanguage(BuildContext context) {
    return context.l10n.language;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getIt.get<SettingsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              Text(
                  "Units ${cubit.state.temperatureUnit}, ${cubit.state.windSpeedUnit}"),
              Text(
                context.l10n.general,
                style: context.textTheme.titleMedium,
              ),
              _ItemSettings(
                title: context.l10n.currentLanguage,
                icon: FluentIcons.local_language_24_filled,
                trailing: Text(
                  systemLanguage(context),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                bloc: cubit,
                builder: (context, state) {
                  return _ItemSettings(
                    title: context.l10n.temperatureUnit,
                    subtitle: context.l10n.chooseTemperatureUnit,
                    icon: FluentIcons.temperature_24_filled,
                    trailing: DropdownButton<TemperatureUnit>(
                      value: state.temperatureUnit,
                      items: [
                        DropdownMenuItem(
                          value: TemperatureUnit.celsius,
                          child: Text("Celsius (°C)"),
                        ),
                        DropdownMenuItem(
                          value: TemperatureUnit.fahrenheit,
                          child: Text("Fahrenheit (°F)"),
                        ),
                      ],
                      onChanged: (value) {
                        getIt
                            .get<SettingsCubit>()
                            .changeTemperatureUnit(value!);
                      },
                    ),
                  );
                },
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                bloc: cubit,
                builder: (context, state) {
                  return _ItemSettings(
                    title: context.l10n.windSpeedUnit,
                    subtitle: context.l10n.chooseWindUnit,
                    icon: FluentIcons.weather_squalls_24_filled,
                    trailing: DropdownButton<WindSpeedUnit>(
                      value: state.windSpeedUnit,
                      items: [
                        DropdownMenuItem(
                          value: WindSpeedUnit.kph,
                          child: Text("km/h"),
                        ),
                        DropdownMenuItem(
                          value: WindSpeedUnit.mph,
                          child: Text("mph"),
                        ),
                      ],
                      onChanged: (value) {
                        getIt.get<SettingsCubit>().changeWindSpeedUnit(value!);
                      },
                    ),
                  );
                },
              ),
              AppSpacing.md,
              Text(
                context.l10n.about,
                style: context.textTheme.titleMedium,
              ),
              AppSpacing.md,
              _ItemAbout(
                leading: Text(context.l10n.version),
                trailing: Text("0.0.1"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemSettings extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final String? subtitle;
  final void Function()? onTap;
  const _ItemSettings({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            leading: Icon(
              icon,
              size: context.dp(2.5),
            ),
            title: Text(
              title,
              style: context.textTheme.bodyMedium,
            ),
            subtitle: subtitle != null
                ? Text(
                    "$subtitle",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: ColorTheme.textSecondary,
                    ),
                  )
                : null,
            trailing: trailing,
            contentPadding: EdgeInsets.zero,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _ItemAbout extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  const _ItemAbout({required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        leading,
        trailing,
      ],
    );
  }
}
