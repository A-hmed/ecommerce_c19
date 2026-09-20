import 'package:ecommerce_c19/features/cart/data/mappers/cart_mapper.dart';
import 'package:ecommerce_c19/features/cart/data/repository/data_source/cart_remote_data_source.dart';
import 'package:ecommerce_c19/features/cart/domain/entity/cart.dart';
import 'package:ecommerce_c19/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  final CartMapper _mapper;

  CartRepositoryImpl(this._cartRemoteDataSource, this._mapper);

  @override
  Future<ApiResult<Cart>> addProductToCart(String productId) async {
    try {
      var apiResult = await _cartRemoteDataSource.addProductToCart(productId);
      return SuccessApiResult(data: _mapper.toCart(apiResult.getData()!.cart!));
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<Cart>> getCart() async {
    try {
      var apiResult = await _cartRemoteDataSource.getCart();
      return SuccessApiResult(data: _mapper.toCart(apiResult.getData()!.cart!));
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<Cart>> removeProductFromCart(String productId) async {
    try {
      var apiResult = await _cartRemoteDataSource.removeProductFromCart(productId);
      return SuccessApiResult(data: _mapper.toCart(apiResult.getData()!.cart!));
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<Cart>> updateCartQty(String productId, int count) async {
    try {
      var apiResult = await _cartRemoteDataSource.updateCartQty(productId, count);
      return SuccessApiResult(data: _mapper.toCart(apiResult.getData()!.cart!));
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
