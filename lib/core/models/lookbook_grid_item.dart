class LookbookGridItem {
  const LookbookGridItem({
    required this.imagePath,
    required this.height,
    this.borderRadius = 20,
  });

  final String imagePath;
  final double height;
  final double borderRadius;
}
