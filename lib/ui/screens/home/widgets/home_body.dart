import 'package:clima_link/config/helpers/lottie_helper.dart';
import 'package:clima_link/ui/blocs/blocs.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:clima_link/config/config.dart';
import 'package:clima_link/ui/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import './forecast_detail.dart';
import './weather_forecast.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _backgroundAnimationController;
  late final AnimationController _titleAnimationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final totalHeight = 600.0; // o context.hp(95)
    final collapsedTrigger = totalHeight * 0.66; // 1/3 restante visible
    final backgroundTrigger = totalHeight * 0.05; // apenas comienza

    if (offset > collapsedTrigger &&
        _titleAnimationController.status != AnimationStatus.forward) {
      _titleAnimationController.forward();
    } else if (offset <= collapsedTrigger &&
        _titleAnimationController.status != AnimationStatus.reverse) {
      _titleAnimationController.reverse();
    }

    if (offset > backgroundTrigger &&
        _backgroundAnimationController.status != AnimationStatus.forward) {
      _backgroundAnimationController.forward();
    } else if (offset <= backgroundTrigger &&
        _backgroundAnimationController.status != AnimationStatus.reverse) {
      _backgroundAnimationController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _backgroundAnimationController.dispose();
    _titleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text(state.errorMessage!),
          );
        }

        final currentWeather = state.current;
        final forecastWeather = state.forecast;

        if (currentWeather == null || forecastWeather == null) {
          return Center(
            child: Icon(Icons.warning),
          );
        }

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final expandedHeight = context.hp(95);
                final offset =
                    constraints.scrollOffset.clamp(0.0, expandedHeight);
                final availableHeight = expandedHeight - offset;

                final backgroundProgress =
                    (1.0 - (availableHeight / expandedHeight)).clamp(0.0, 1.0);
                _backgroundAnimationController.value = backgroundProgress;

                final collapsedThreshold = 0.45;
                final titleProgress =
                    ((1.0 - (availableHeight / expandedHeight)) -
                            collapsedThreshold) /
                        (1.0 - collapsedThreshold);
                _titleAnimationController.value = titleProgress.clamp(0.0, 1.0);

                String location =
                    "${currentWeather.location.region}, ${currentWeather.location.name!}";
                double? temp = currentWeather.current.tempC;
                bool isDay = currentWeather.current.isDay == 1;
                String lottie = LottieHelper.getWeatherLottie(
                  condition: currentWeather.current.condition.text!,
                  isDay: isDay,
                );

                return SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: false,
                  expandedHeight: expandedHeight,
                  title: _buildAnimatedAppBarCollapsed(
                    location: location,
                    temp: temp,
                    lottie: lottie,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: _buildFlexibleAppBarBackground(
                      location: location,
                      temp: temp,
                      lottie: lottie,
                    ),
                  ),
                );
              },
            ),
            _SliverContent(
              child: WeatherForecast(
                forecast: forecastWeather.forecast,
              ),
            ),
            _SliverContent(
              child: ForecastDetail(
                currentWeatherData: currentWeather.current,
                dayData: forecastWeather.forecast.first.day,
              ),
            ),
            _SliverContent(child: AppSpacing.md),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedAppBarCollapsed({
    required String location,
    double? temp,
    String lottie = 'assets/lotties/sunny.json',
  }) {
    return AnimatedBuilder(
      animation: _titleAnimationController,
      builder: (context, child) {
        final t = _titleAnimationController;
        final curved = CurvedAnimation(parent: t, curve: Curves.easeIn);
        return Opacity(
          opacity: 0 + curved.value,
          child: Transform.translate(
            offset: Offset(
              -40 * (1 - curved.value),
              0,
            ),
            child: t.value > 0.5
                ? Row(
                    children: [
                      Lottie.asset(
                        lottie,
                        width: context.dp(4),
                        height: context.dp(4),
                      ),
                      AppSpacing.lg,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Text(
                            location,
                            style: context.textTheme.titleMedium,
                          ),
                          Icon(FluentIcons.my_location_24_filled)
                        ],
                      ),
                      AppSpacing.lg,
                      Text(
                        "$temp°C",
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _buildFlexibleAppBarBackground({
    required String location,
    double? temp,
    String lottie = 'assets/lotties/sunny.json',
  }) {
    final curved = CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeOut,
    );

    return AnimatedBuilder(
      animation: _backgroundAnimationController,
      builder: (context, child) {
        final value = curved.value;
        final isVisible = value < 1.0;

        return Visibility(
          visible: isVisible,
          maintainState: true,
          maintainAnimation: true,
          child: Opacity(
            opacity: 1.0 - value,
            child: Transform.scale(
              scale: 1.0 - 0.2 * value,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        location,
                        style: context.textTheme.titleMedium,
                      ),
                      Icon(FluentIcons.my_location_24_filled)
                    ],
                  ),
                  AppSpacing.lg,
                  Center(
                    child: Lottie.asset(
                      lottie,
                      width: context.dp(30),
                      height: context.dp(30),
                    ),
                  ),
                  AppSpacing.lg,
                  Text(
                    "$temp°C",
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SliverContent extends StatelessWidget {
  final Widget child;
  const _SliverContent({required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: child);
  }
}
