import 'package:ecommerce_c19/features/cart/domain/entity/cart.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_response.dart';

abstract class CartRepository {
  Future<ApiResult<Cart>> getCart();
  Future<ApiResult<Cart>> addProductToCart(String productId);
  Future<ApiResult<Cart>> removeProductFromCart(String productId);
  Future<ApiResult<Cart>> updateCartQty(String productId, int count);
}