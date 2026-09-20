import 'package:ecommerce_c19/features/cart/data/repository/data_source/cart_remote_data_source.dart';
import 'package:ecommerce_c19/features/network/api/api_services.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/request/cart/add_product_to_cart_request.dart';
import 'package:ecommerce_c19/features/network/model/request/cart/update_product_qty_request.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_response.dart';
import 'package:ecommerce_c19/features/network/utils/handle_dio_error.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final ApiServices _apiServices;

  CartRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<CartResponse>> addProductToCart(String productId) async {
    try {
      await _apiServices.addProductToCart(
        AddProductToCartRequest(productId: productId),
      );
      var response = await _apiServices.getCart();
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }

  @override
  Future<ApiResult<CartResponse>> getCart() async {
    try {
      var response = await _apiServices.getCart();
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }

  @override
  Future<ApiResult<CartResponse>> removeProductFromCart(
    String productId,
  ) async {
    try {
      var response = await _apiServices.deleteProductFromCart(productId);
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }

  @override
  Future<ApiResult<CartResponse>> updateCartQty(
    String productId,
    int count,
  ) async {
    try {
      var response = await _apiServices.updateProductQty(
        productId,
        UpdateProductQtyRequest(count: count.toString()),
      );
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }
}
