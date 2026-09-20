import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static final navigationTextStyle = TextStyle(fontSize: 12);

  static final imageViewTitle = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: .w600,
    color: AppColors.neutral900,
    letterSpacing: 0.2,
    height: 1.4,
  );

  static final imageViewUsername = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 10,
    fontWeight: .w400,
    color: AppColors.unSelectedGreyColor,
    letterSpacing: 0.2,
  );
}
