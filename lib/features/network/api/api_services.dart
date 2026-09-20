import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/network/model/request/cart/add_product_to_cart_request.dart';
import 'package:ecommerce_c19/features/network/model/request/cart/update_product_qty_request.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_response.dart';
import 'package:ecommerce_c19/features/network/model/response/categories/categories_response.dart';
import 'package:ecommerce_c19/features/network/model/response/products/products_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST('auth/signin')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('auth/signup')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @GET('categories')
  Future<CategoriesResponse> getCategories();

  @GET('products')
  Future<ProductsResponse> getProducts({
    @Query("category") String? category,
    // @Query("category") String? subCategory,
  });

  @GET('categories/{categoryId}/subcategories')
  Future<CategoriesResponse> getSubCategories(@Path() String categoryId);

  @GET('cart')
  Future<CartResponse> getCart();

  @POST('cart')
  Future<void> addProductToCart(
    @Body() AddProductToCartRequest request,
  );

  @PUT('cart/{productId}')
  Future<CartResponse> updateProductQty(
    @Path() String productId,
    @Body() UpdateProductQtyRequest request,
  );

  @DELETE('cart/{productId}')
  Future<CartResponse> deleteProductFromCart(@Path() String productId);
}
