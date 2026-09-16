class Product {
  final num sold;
  final List<String> images;
  final num ratingsQuantity;
  final String id;
  final String title;
  final String description;
  final num quantity;
  final num price;
  final String imageCover;
  final num ratingsAverage;
  num? totalCartPrice;
  num cartQty;

  Product({
    required this.sold,
    required this.images,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.ratingsAverage,
    this.totalCartPrice,
    this.cartQty = 0,
  });
}
