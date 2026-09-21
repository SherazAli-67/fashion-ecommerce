import 'dart:ui';

import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:fashion_ecommerce/core/app_icons.dart';
import 'package:fashion_ecommerce/core/app_textstyles.dart';
import 'package:fashion_ecommerce/core/models/lookbook_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.item});

  final LookbookImage item;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> with SingleTickerProviderStateMixin {
  static const _enterDuration = Duration(milliseconds: 350);
  static const _backDelayMs = 200.0;
  static const _cardDelayMs = 250.0;
  static const _enterTotalMs = 600.0;
  static const _cardSlideOffset = 40.0;

  late final AnimationController _enterController;
  late final Animation<double> _backEnter;
  late final Animation<double> _cardEnter;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _enterTotalMs.round()),
    );
    _backEnter = CurvedAnimation(
      parent: _enterController,
      curve: Interval(
        _backDelayMs / _enterTotalMs,
        (_backDelayMs + _enterDuration.inMilliseconds) / _enterTotalMs,
        curve: Curves.easeOutCubic,
      ),
    );
    _cardEnter = CurvedAnimation(
      parent: _enterController,
      curve: Interval(
        _cardDelayMs / _enterTotalMs,
        (_cardDelayMs + _enterDuration.inMilliseconds) / _enterTotalMs,
        curve: Curves.easeOutCubic,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _enterController.value = 1;
        return;
      }
      _enterController.forward();
    });
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral1000,
      body: Stack(
        fit: .expand,
        children: [
          Hero(
            tag: widget.item.imagePath,
            child: Image.asset(widget.item.imagePath, fit: .cover),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.paddingOf(context).top + 12,
            child: FadeTransition(opacity: _backEnter, child: _buildBackButton()),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 35,
            child: _buildAnimatedInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedInfoCard() {
    return AnimatedBuilder(
      animation: _cardEnter,
      builder: (context, child) {
        return Opacity(
          opacity: _cardEnter.value,
          child: Transform.translate(
            offset: Offset(0, _cardSlideOffset * (1 - _cardEnter.value)),
            child: child,
          ),
        );
      },
      child: _buildInfoCard(),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => context.pop(),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.1, sigmaY: 5.1),
          child: Container(
            width: 26,
            height: 26,
            alignment: .center,
            decoration: BoxDecoration(
              color: AppColors.frostedBackFill,
              shape: .circle,
              border: .all(color: AppColors.frostedBackBorder, width: 0.5),
            ),
            child: SvgPicture.asset(AppIcons.icArrowLeft, width: 16, height: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: .symmetric(horizontal: 32, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .circular(30),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(widget.item.title, style: AppTextStyles.imageViewTitle),
          Text(widget.item.username, style: AppTextStyles.imageViewUsername),
        ],
      ),
    );
  }
}
