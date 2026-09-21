import 'dart:ui';

import 'package:fashion_ecommerce/constants/string_const.dart';
import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:fashion_ecommerce/core/app_data.dart';
import 'package:fashion_ecommerce/core/app_icons.dart';
import 'package:fashion_ecommerce/core/app_textstyles.dart';
import 'package:fashion_ecommerce/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  static const _enterDuration = Duration(milliseconds: 350);
  static const _kenBurnsDuration = Duration(seconds: 8);
  static const _staggerDelay = Duration(milliseconds: 80);
  static const _pressDuration = Duration(milliseconds: 120);
  static const _slideOffset = 24.0;
  static const _enterTotalMs = 590.0;

  late final AnimationController _kenBurnsController;
  late final AnimationController _enterController;
  late final Animation<double> _kenBurnsScale;
  late final Animation<double> _skipEnter;
  late final Animation<double> _titleEnter;
  late final Animation<double> _subtitleEnter;
  late final Animation<double> _dotsEnter;

  bool _skipPressed = false;
  bool _showActiveIndicator = false;

  @override
  void initState() {
    super.initState();
    _kenBurnsController = AnimationController(vsync: this, duration: _kenBurnsDuration);
    _kenBurnsScale = Tween(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _kenBurnsController, curve: Curves.easeOut),
    );

    _enterController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _enterTotalMs.round()),
    );
    _skipEnter = _staggered(0);
    _titleEnter = _staggered(_staggerDelay.inMilliseconds.toDouble());
    _subtitleEnter = _staggered(_staggerDelay.inMilliseconds * 2);
    _dotsEnter = _staggered(_staggerDelay.inMilliseconds * 3);

    _enterController.addListener(_onEnterTick);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _enterController.value = 1;
        _kenBurnsController.value = 1;
        setState(() => _showActiveIndicator = true);
        return;
      }
      _enterController.forward();
      _kenBurnsController.forward();
    });
  }

  Animation<double> _staggered(double delayMs) {
    return CurvedAnimation(
      parent: _enterController,
      curve: Interval(
        delayMs / _enterTotalMs,
        (delayMs + _enterDuration.inMilliseconds) / _enterTotalMs,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _onEnterTick() {
    if (_showActiveIndicator) return;
    final dotsStart = (_staggerDelay.inMilliseconds * 3) / _enterTotalMs;
    if (_enterController.value >= dotsStart) {
      setState(() => _showActiveIndicator = true);
    }
  }

  Future<void> _onSkipPressed() async {
    if (_skipPressed) return;
    setState(() => _skipPressed = true);
    if (!MediaQuery.disableAnimationsOf(context)) {
      await Future<void>.delayed(_pressDuration);
    }
    if (!mounted) return;
    context.go(NamedRoutes.home.routeName);
  }

  @override
  void dispose() {
    _enterController.removeListener(_onEnterTick);
    _kenBurnsController.dispose();
    _enterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          _buildKenBurnsBackground(),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    AppColors.neutral1000.withValues(alpha: 0),
                    AppColors.gradientBlack30,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: .topRight,
                    child: _fadeSlideIn(animation: _skipEnter, child: _buildSkipButton()),
                  ),
                  Spacer(),
                  _fadeSlideIn(animation: _titleEnter, child: _buildTitle()),
                  SizedBox(height: 16),
                  _fadeSlideIn(
                    animation: _subtitleEnter,
                    child: Text(
                      StringConst.welcomeSubtitle,
                      style: AppTextStyles.welcomeSubtitle,
                      textAlign: .center,
                    ),
                  ),
                  SizedBox(height: 50),
                  _fadeSlideIn(animation: _dotsEnter, child: _buildPageIndicator()),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKenBurnsBackground() {
    return Positioned.fill(
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _kenBurnsScale,
          builder: (context, child) {
            return Transform.scale(scale: _kenBurnsScale.value, child: child);
          },
          child: Image.asset(AppIcons.welcomeBackgroundImage, fit: .cover),
        ),
      ),
    );
  }

  Widget _fadeSlideIn({required Animation<double> animation, required Widget child}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, _slideOffset * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: _onSkipPressed,
      child: AnimatedScale(
        scale: _skipPressed ? 0.96 : 1,
        duration: _pressDuration,
        curve: Curves.easeOutCubic,
        child: ClipRRect(
          borderRadius: .circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.7, sigmaY: 2.7),
            child: Container(
              padding: .symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.frostedSkipFill,
                borderRadius: .circular(24),
                border: .all(color: AppColors.frostedSkipBorder),
              ),
              child: Text(StringConst.welcomeSkip, style: AppTextStyles.welcomeSkip),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.welcomeTitle,
        children: [
          TextSpan(text: '${StringConst.welcomeTitleLine1}\n'),
          TextSpan(text: StringConst.welcomeTitleBrand),
          TextSpan(text: StringConst.welcomeTitleAccent, style: AppTextStyles.welcomeTitleAccent),
        ],
      ),
      textAlign: .center,
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      spacing: 6,
      mainAxisAlignment: .center,
      children: List.generate(
        AppData.welcomePageCount,
        (index) => _buildIndicatorDot(
          isActive: _showActiveIndicator && index == AppData.welcomeActivePageIndex,
        ),
      ),
    );
  }

  Widget _buildIndicatorDot({required bool isActive}) {
    return AnimatedContainer(
      duration: _enterDuration,
      curve: Curves.easeOutCubic,
      width: isActive ? 14 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.neutral700,
        borderRadius: .circular(100),
      ),
    );
  }
}
