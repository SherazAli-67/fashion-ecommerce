import 'package:fashion_ecommerce/core/models/lookbook_grid_item.dart';
import 'package:fashion_ecommerce/core/models/lookbook_image.dart';

class AppData {
  static const lookbookImages = [
    LookbookImage(
      imagePath: 'assets/images/lookbook_image_view.jpg',
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
    LookbookGridItem(imagePath: 'assets/images/home_grid_01.jpg', height: 100),
    LookbookGridItem(imagePath: 'assets/images/home_grid_02.jpg', height: 160),
    LookbookGridItem(imagePath: 'assets/images/home_grid_03.jpg', height: 100, borderRadius: 24),
    LookbookGridItem(imagePath: 'assets/images/home_grid_04.jpg', height: 160),
    LookbookGridItem(imagePath: 'assets/images/home_grid_05.jpg', height: 160),
    LookbookGridItem(imagePath: 'assets/images/home_grid_06.jpg', height: 100),
  ];

  static const homeGridRight = [
    LookbookGridItem(imagePath: 'assets/images/home_grid_07.jpg', height: 160, borderRadius: 24),
    LookbookGridItem(imagePath: 'assets/images/home_grid_08.jpg', height: 100, borderRadius: 24),
    LookbookGridItem(imagePath: 'assets/images/home_grid_09.jpg', height: 160),
    LookbookGridItem(imagePath: 'assets/images/home_grid_10.jpg', height: 100),
    LookbookGridItem(imagePath: 'assets/images/home_grid_11.jpg', height: 100, borderRadius: 24),
    LookbookGridItem(imagePath: 'assets/images/home_grid_12.jpg', height: 160, borderRadius: 24),
  ];
}
