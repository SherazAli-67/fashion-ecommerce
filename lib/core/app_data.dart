import 'package:fashion_ecommerce/core/models/lookbook_grid_item.dart';
import 'package:fashion_ecommerce/core/models/lookbook_image.dart';

import 'app_icons.dart';

class AppData {
  static const lookbookImages = [
    LookbookImage(
      imagePath: AppIcons.lookupImage,
      title: 'Image Name dolor sit amet, consectetur',
      username: 'Username',
    ),
  ];

  static const categories = [
    'All',
    'Woman',
    'Men',
    'Boy',
    'Girl',
    'Beauty',
  ];

  static const homeGridLeft = [
    LookbookGridItem(imagePath: AppIcons.homeGridImg1, height: 100),
    LookbookGridItem(imagePath: AppIcons.homeGridImg2, height: 160),
    LookbookGridItem(imagePath: AppIcons.homeGridImg3, height: 100, borderRadius: 24),
    LookbookGridItem(imagePath: AppIcons.homeGridImg4, height: 160),
    LookbookGridItem(imagePath: AppIcons.homeGridImg5, height: 160),
    LookbookGridItem(imagePath: AppIcons.homeGridImg6, height: 100),
  ];

  static const homeGridRight = [
    LookbookGridItem(imagePath: AppIcons.homeGridImg7, height: 160, borderRadius: 24),
    LookbookGridItem(imagePath: AppIcons.homeGridImg8, height: 100, borderRadius: 24),
    LookbookGridItem(imagePath: AppIcons.homeGridImg9, height: 160),
    LookbookGridItem(imagePath: AppIcons.homeGridImg10, height: 100),
    LookbookGridItem(imagePath: AppIcons.homeGridImg11, height: 100, borderRadius: 24),
    LookbookGridItem(imagePath: AppIcons.homeGridImg12, height: 160, borderRadius: 24),
  ];

  static const welcomePageCount = 3;
  static const welcomeActivePageIndex = 1;
}
