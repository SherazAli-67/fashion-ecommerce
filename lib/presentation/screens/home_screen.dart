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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  static const _enterDuration = Duration(milliseconds: 350);
  static const _pressDuration = Duration(milliseconds: 120);
  static const _sectionDelayMs = 80.0;
  static const _gridDelayMs = 40.0;
  static const _maxGridDelayMs = 480.0;
  static const _enterTotalMs = 830.0;
  static const _slideOffset = 16.0;

  late final AnimationController _enterController;
  late final Animation<double> _headerEnter;
  late final Animation<double> _collectionEnter;
  late final Animation<double> _categoryEnter;
  late final List<Animation<double>> _gridEnters;

  int _selectedCategoryIndex = 0;
  int? _pressedChipIndex;
  String? _pressedImagePath;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _enterTotalMs.round()),
    );
    _headerEnter = _staggered(0);
    _collectionEnter = _staggered(_sectionDelayMs);
    _categoryEnter = _staggered(_sectionDelayMs * 2);
    _gridEnters = List.generate(
      AppData.homeGridLeft.length + AppData.homeGridRight.length,
      (index) => _staggered(_gridStartMs(index)),
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

  double _gridStartMs(int visualIndex) {
    return (_sectionDelayMs * 3 + visualIndex * _gridDelayMs).clamp(0, _maxGridDelayMs);
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

  Future<void> _onImageTap(String imagePath) async {
    if (_pressedImagePath != null) return;
    setState(() => _pressedImagePath = imagePath);
    if (!MediaQuery.disableAnimationsOf(context)) {
      await Future<void>.delayed(_pressDuration);
    }
    if (!mounted) return;
    _openImageView(imagePath);
    setState(() => _pressedImagePath = null);
  }

  void _openImageView(String imagePath) {
    final base = AppData.lookbookImages.first;
    context.push(
      NamedRoutes.imageView.routeName,
      extra: LookbookImage(imagePath: imagePath, title: base.title, username: base.username),
    );
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }

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
              _fadeSlideIn(animation: _headerEnter, child: _buildHeader()),
              _fadeSlideIn(animation: _collectionEnter, child: _buildCollectionSection()),
              _fadeSlideIn(animation: _categoryEnter, child: _buildCategorySection()),
              _buildMasonryGrid(),
            ],
          ),
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

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              Text(StringConst.homeGreeting, style: AppTextStyles.homeGreeting),
              Text(StringConst.homeGreetingTitle, style: AppTextStyles.homeGreetingTitle),
            ],
          ),
        ),
        ClipOval(
          child: Image.asset(
            AppIcons.homeProfileImage,
            width: 39,
            height: 39,
            fit: .cover,
          ),
        ),
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
              Text(StringConst.homeCollectionTitle, style: AppTextStyles.homeCollectionTitle),
              Text(StringConst.homeCollectionSubtitle, style: AppTextStyles.homeCollectionSubtitle),
            ],
          ),
        ),
        _buildCollectionImage(),
      ],
    );
  }

  Widget _buildCollectionImage() {
    return GestureDetector(
      onTap: () => _onImageTap(AppIcons.homeCollectionImage),
      child: AnimatedScale(
        scale: _pressedImagePath == AppIcons.homeCollectionImage ? 0.98 : 1,
        duration: _pressDuration,
        curve: Curves.easeOutCubic,
        child: SizedBox(
          width: 150,
          height: 130,
          child: Stack(
            clipBehavior: .none,
            children: [
              Positioned(
                left: 0,
                top: 6,
                child: Hero(
                  tag: AppIcons.homeCollectionImage,
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
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        Text(StringConst.homeCollectionTitle, style: AppTextStyles.homeSectionTitle),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 12,
            children: List.generate(
              AppData.categories.length,
              (index) => _buildCategoryChip(
                label: AppData.categories[index],
                isSelected: _selectedCategoryIndex == index,
                isPressed: _pressedChipIndex == index,
                onTap: () => setState(() => _selectedCategoryIndex = index),
                onTapDown: () => setState(() => _pressedChipIndex = index),
                onTapEnd: () => setState(() => _pressedChipIndex = null),
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
    required bool isPressed,
    required VoidCallback onTap,
    required VoidCallback onTapDown,
    required VoidCallback onTapEnd,
  }) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTapEnd(),
      onTapCancel: onTapEnd,
      child: AnimatedScale(
        scale: isPressed ? 0.97 : 1,
        duration: _pressDuration,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: _enterDuration,
          curve: Curves.easeOutCubic,
          padding: .symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.neutral200,
            borderRadius: .circular(128),
          ),
          child: AnimatedDefaultTextStyle(
            duration: _enterDuration,
            curve: Curves.easeOutCubic,
            style: isSelected ? AppTextStyles.homeCategorySelected : AppTextStyles.homeCategoryUnselected,
            child: Text(label),
          ),
        ),
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
            children: [
              for (var i = 0; i < AppData.homeGridLeft.length; i++)
                _fadeSlideIn(
                  animation: _gridEnters[i * 2],
                  child: _buildGridItem(AppData.homeGridLeft[i]),
                ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            spacing: 16,
            children: [
              for (var i = 0; i < AppData.homeGridRight.length; i++)
                _fadeSlideIn(
                  animation: _gridEnters[i * 2 + 1],
                  child: _buildGridItem(AppData.homeGridRight[i]),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(LookbookGridItem item) {
    return GestureDetector(
      onTap: () => _onImageTap(item.imagePath),
      child: AnimatedScale(
        scale: _pressedImagePath == item.imagePath ? 0.98 : 1,
        duration: _pressDuration,
        curve: Curves.easeOutCubic,
        child: Hero(
          tag: item.imagePath,
          child: ClipRRect(
            borderRadius: .circular(item.borderRadius),
            child: Image.asset(
              item.imagePath,
              width: double.infinity,
              height: item.height,
              fit: .cover,
            ),
          ),
        ),
      ),
    );
  }
}
