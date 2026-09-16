import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/network/model/request/add_to_cart_request.dart';
import 'package:ecommerce_c19/features/network/model/request/login_request.dart';
import 'package:ecommerce_c19/features/network/model/request/register_request.dart';
import 'package:ecommerce_c19/features/network/model/request/update_cart_qty_request.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';
import 'package:ecommerce_c19/features/network/model/response/cart/cart_response.dart';
import 'package:ecommerce_c19/features/network/model/response/category/categories_response.dart';
import 'package:ecommerce_c19/features/network/model/response/product/products_response.dart';
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
    // @Query("category[in]") String? subCategory,
  });

  @GET('categories/{categoryId}/subcategories')
  Future<CategoriesResponse> getSubCategoriesByCategory(
    @Path() String categoryId,
  );

  @GET('cart')
  Future<CartResponse> getCart();

  @POST('cart')
  Future<CartResponse> addToCart(@Body() AddToCartRequest request);

  @PUT('cart/{productId}')
  Future<CartResponse> updateCartQty(
    @Path() String productId,
    @Body() UpdateCartQtyRequest request,
  );

  @DELETE('cart/{productId}')
  Future<CartResponse> removeFromCart( @Path() String productId,);
}
