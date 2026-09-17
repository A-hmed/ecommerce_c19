import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';

class Cart{
  num totalCartPrice;
  Map<String,Product> products;

  Cart({required this.totalCartPrice,
    required this.products});
}