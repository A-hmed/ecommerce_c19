import 'package:ecommerce_c19/features/cart/domain/entity/cart.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';

class CartState {
  Resource<Cart> cartState;
  List<String> productIds = [];

  CartState({required this.cartState, this.productIds = const []});

  Product? getProductFromCart(String productId) {
    var cart = cartState.data;
    print("cart = $cart");
    if (cart == null) return null;
    return cart.products[productId];
  }

  CartState.initial() : cartState = Resource.initial();

  CartState copyWith({Resource<Cart>? cartState, List<String>? productIds}) {
    return CartState(
      cartState: cartState ?? this.cartState,
      productIds: productIds ?? this.productIds,
    );
  }
}
