import 'package:fashion_ecommerce/constants/string_const.dart';
import 'package:fashion_ecommerce/core/app_colors.dart';
import 'package:fashion_ecommerce/core/app_data.dart';
import 'package:fashion_ecommerce/core/app_icons.dart';
import 'package:fashion_ecommerce/core/app_textstyles.dart';
import 'package:fashion_ecommerce/core/models/lookbook_grid_item.dart';
import 'package:fashion_ecommerce/core/models/lookbook_image.dart';
import 'package:fashion_ecommerce/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .only(left: 20, right: 20, top: 12, bottom: 16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: .start,
            children: [
              _buildHeader(),
              _buildCollectionSection(),
              _buildCategorySection(),
              _buildMasonryGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              //homeGreeting, homeGreeting
              //homeGreetingTitle, homeGreetingTitle
            ],
          ),
        ),
      /*  ClipOval(
          child: Image.asset(
            AppIcons.homeProfileImage,
            width: 39,
            height: 39,
            fit: .cover,
          ),
        ),*/
      ],
    );
  }

  Widget _buildCollectionSection() {
    return Row(
      spacing: 12,
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              //homeCollectionTitle, homeCollectionTitle

              //homeCollectionSubtitle, homeCollectionSubtitle
            ],
          ),
        ),
        //collectionImage
      ],
    );
  }

  Widget _buildCollectionImage() {
    return GestureDetector(
      onTap: () => _openImageView(AppIcons.homeCollectionImage),
      child: SizedBox(
        width: 150,
        height: 130,
        child: Stack(
          clipBehavior: .none,
          children: [
            Positioned(
              left: 0,
              top: 6,
              child: ClipRRect(
                borderRadius: .circular(32),
                child: Image.asset(
                  AppIcons.homeCollectionImage,
                  width: 150,
                  height: 130,
                  fit: .cover,
                ),
              ),
            ),
            Positioned(
              left: -6,
              top: 0,
              child: SvgPicture.asset(AppIcons.icStar, width: 30, height: 30),
            ),
            Positioned(
              right: -6,
              bottom: -6,
              child: SvgPicture.asset(AppIcons.icStar, width: 30, height: 30),
            ),
          ],
        ),
      ),
    );
  }

  void _openImageView(String imagePath) {
    final base = AppData.lookbookImages.first;
    context.push(
      NamedRoutes.imageView.routeName,
      extra: LookbookImage(imagePath: imagePath, title: base.title, username: base.username),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        //homeCategoryTitle, homeSectionTitle,
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 12,
            children: List.generate(
              AppData.categories.length,
              (index) => _buildCategoryChip(
                label: AppData.categories[index],
                isSelected: _selectedCategoryIndex == index,
                onTap: () => setState(() => _selectedCategoryIndex = index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: .symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
     /*     color: isSelected ? AppColors.primaryColor : AppColors.neutral200,
          borderRadius: .circular(128),*/
        ),
        child:
        //label, isSelected ? selected : unSelected
        const SizedBox()
      ),
    );
  }

  Widget _buildMasonryGrid() {
    return Row(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            spacing: 16,
            children: [],
            // children: AppData.homeGridLeft.map(_buildGridItem).toList(),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 16,
            children: [],
            // children: AppData.homeGridRight.map(_buildGridItem).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(LookbookGridItem item) {
    return GestureDetector(
      onTap: () => _openImageView(item.imagePath),
      child: ClipRRect(
        borderRadius: .circular(item.borderRadius),
        child: Image.asset(
          item.imagePath,
          width: double.infinity,
          height: item.height,
          fit: .cover,
        ),
      ),
    );
  }
}
