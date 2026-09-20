import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:fashion_ecommerce/core/app_icons.dart';
import 'package:fashion_ecommerce/core/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.unSelectedGreyColor,
        selectedLabelStyle: AppTextStyles.navigationTextStyle.copyWith(fontWeight: .w600, color: AppColors.primaryColor),
        unselectedLabelStyle: AppTextStyles.navigationTextStyle.copyWith(fontWeight: .w500, color: AppColors.unSelectedGreyColor),
        items: [
          buildBottomNavigationBarItem(icon: navigationShell.currentIndex == 0 ? AppIcons.icHomeSelected : AppIcons.icHome, label: 'Home'),
          buildBottomNavigationBarItem(icon: AppIcons.icSearch, label: 'Search'),
          buildBottomNavigationBarItem(icon: AppIcons.icMessage, label: 'Message'),
          buildBottomNavigationBarItem(icon: AppIcons.icProfile, label: 'Profile'),
        ],
      ),
      body: navigationShell,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({required String icon, required String label}) {
    return BottomNavigationBarItem(
          icon: SvgPicture.asset(icon),
          label: label,
        );
  }
}
