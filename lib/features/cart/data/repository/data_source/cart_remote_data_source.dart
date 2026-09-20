import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_response.dart';

abstract class CartRemoteDataSource {
  Future<ApiResult<CartResponse>> getCart();
  Future<ApiResult<CartResponse>> addProductToCart(String productId);
  Future<ApiResult<CartResponse>> removeProductFromCart(String productId);
  Future<ApiResult<CartResponse>> updateCartQty(String productId, int count);

}