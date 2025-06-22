import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:clima_link/ui/widgets/widgets.dart';
import 'package:clima_link/config/config.dart';
import 'package:clima_link/ui/shared/shared.dart';
import 'package:lottie/lottie.dart';

import './widgets/forecast_detail.dart';
import './widgets/weather_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    return AdaptiveScaffold(
      child: CustomScrollView(
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

              return SliverAppBar(
                pinned: true,
                floating: true,
                snap: false,
                expandedHeight: expandedHeight,
                title: _buildAnimatedAppBarCollapsed(),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: _buildFlexibleAppBarBackground(),
                ),
              );
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16),
            sliver: _SliverContent(
              child: WeatherForecast(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16),
            sliver: _SliverContent(
              child: ForecastDetail(),
            ),
          ),
          _SliverContent(child: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildAnimatedAppBarCollapsed() {
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
                        'assets/lotties/sunny_rain.json',
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
                            "Atlántico, Barranquilla",
                            style: context.textTheme.titleMedium,
                          ),
                          Icon(FluentIcons.my_location_24_filled)
                        ],
                      ),
                      AppSpacing.lg,
                      Text(
                        "24°C",
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

  Widget _buildFlexibleAppBarBackground() {
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
                        "Atlántico, Barranquilla",
                        style: context.textTheme.titleMedium,
                      ),
                      Icon(FluentIcons.my_location_24_filled)
                    ],
                  ),
                  AppSpacing.lg,
                  Center(
                    child: Lottie.asset(
                      'assets/lotties/sunny_rain.json',
                      width: context.dp(30),
                      height: context.dp(30),
                    ),
                  ),
                  AppSpacing.lg,
                  Text(
                    "24°C",
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
