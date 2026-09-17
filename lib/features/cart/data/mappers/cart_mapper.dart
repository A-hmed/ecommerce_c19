import 'package:ecommerce_c19/features/cart/domain/entity/cart.dart';
import 'package:ecommerce_c19/features/commerce/data/mappers/products_mapper.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartMapper {
  final ProductsMapper _productsMapper;
  
  CartMapper(this._productsMapper);
  Cart toCart(CartDM cart){
    Map<String, Product> products = {};

    cart.cartEntries?.forEach((cartEntry){
      var product = _productsMapper.toEntity(cartEntry.productDM!);
      product.cartQuantity = cartEntry.count!;
      product.totalCartPrice = cartEntry.price! * cartEntry.count!;

      products.addAll({
        cartEntry.productDM!.id!: product
      });
    });

    return Cart(
        totalCartPrice: cart.totalCartPrice ?? 0,
        products: products);
  }
}