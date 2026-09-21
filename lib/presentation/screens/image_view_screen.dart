import 'dart:ui';

import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:fashion_ecommerce/core/app_icons.dart';
import 'package:fashion_ecommerce/core/app_textstyles.dart';
import 'package:fashion_ecommerce/core/models/lookbook_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.item});

  final LookbookImage item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral1000,
      body: Stack(
        fit: .expand,
        children: [
          Image.asset(item.imagePath, fit: .cover),
          Positioned(
            left: 20,
            top: MediaQuery.paddingOf(context).top + 12,
            child: _buildBackButton(context),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 35,
            child: _buildInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
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
          Text(item.title, style: AppTextStyles.imageViewTitle),
          Text(item.username, style: AppTextStyles.imageViewUsername),
        ],
      ),
    );
  }
}
