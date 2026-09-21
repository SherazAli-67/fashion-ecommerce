import 'dart:ui';

import 'package:fashion_ecommerce/constants/string_const.dart';
import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:fashion_ecommerce/core/app_data.dart';
import 'package:fashion_ecommerce/core/app_textstyles.dart';
import 'package:fashion_ecommerce/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Image.asset(StringConst.welcomeBackgroundImage, fit: .cover),
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
                    child: _buildSkipButton(context),
                  ),
                  Spacer(),
                  _buildTitle(),
                  SizedBox(height: 16),
                  Text(StringConst.welcomeSubtitle, style: AppTextStyles.welcomeSubtitle, textAlign: .center),
                  SizedBox(height: 50),
                  _buildPageIndicator(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
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
        (index) => _buildIndicatorDot(isActive: index == AppData.welcomeActivePageIndex),
      ),
    );
  }

  Widget _buildIndicatorDot({required bool isActive}) {
    return Container(
      width: isActive ? 14 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.neutral700,
        borderRadius: .circular(100),
      ),
    );
  }
}
