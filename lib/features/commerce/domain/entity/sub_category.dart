class SubCategory {
  final String id;
  final String name;
  final String slug;
  final String categoryId;
  final String image;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.categoryId,
    this.image = '',
  });
}
