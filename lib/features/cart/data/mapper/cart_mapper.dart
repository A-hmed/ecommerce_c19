import 'package:ecommerce_c19/features/cart/domain/entity/cart.dart';
import 'package:ecommerce_c19/features/commerce/data/mapper/product_mapper.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartMapper {
  ProductMapper productMapper;

  CartMapper(this.productMapper);

  Cart mapCart(CartDM cart) {
    Map<String, Product> products = {};

    cart.cartEntries?.forEach((entry) {
      var product = productMapper.toEntity(entry.product!);
      product.cartQty = entry.count ?? 0;
      product.totalCartPrice = product.cartQty * product.price;
      products.addAll({entry.product!.id!: product});
    });

    return Cart(totalCartPrice: cart.totalCartPrice ?? 0, products: products);
  }
}
