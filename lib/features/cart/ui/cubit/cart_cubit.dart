import 'package:ecommerce_c19/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce_c19/features/cart/ui/cubit/cart_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(CartState.initial());

  Future<void> getCart() async {
    emit(
      state.copyWith(cartState: Resource.loading(data: state.cartState.data)),
    );
    var apiResult = await _repository.getCart();
    if (apiResult.isSuccess) {
      emit(
        state.copyWith(cartState: Resource.success(data: apiResult.getData())),
      );
    } else {
      emit(
        state.copyWith(
          cartState: Resource.error(
            errorMessage: apiResult.errorMessage,
            data: state.cartState.data,
          ),
        ),
      );
    }
  }

  Future<void> addProductToCart(String productId) async {
    List<String> currentProducts = state.productIds;
    currentProducts.add(productId);
    emit(
      state.copyWith(
        cartState: Resource.loading(data: state.cartState.data),
        productIds: currentProducts,
      ),
    );
    var apiResult = await _repository.addProductToCart(productId);
    currentProducts.remove(productId);
    if (apiResult.isSuccess) {
      emit(
        state.copyWith(
          cartState: Resource.success(data: apiResult.getData()),
          productIds: currentProducts,
        ),
      );
    } else {
      emit(
        state.copyWith(
          cartState: Resource.error(
            errorMessage: apiResult.errorMessage,
            data: state.cartState.data,
          ),
          productIds: currentProducts,
        ),
      );
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    List<String> currentProducts = state.productIds;
    currentProducts.add(productId);

    emit(
      state.copyWith(
        cartState: Resource.loading(data: state.cartState.data),
        productIds: currentProducts,
      ),
    );
    var apiResult = await _repository.removeProductFromCart(productId);
    currentProducts.remove(productId);
    if (apiResult.isSuccess) {
      emit(
        state.copyWith(
          cartState: Resource.success(data: apiResult.getData()),
          productIds: currentProducts,
        ),
      );
    } else {
      emit(
        state.copyWith(
          cartState: Resource.error(
            errorMessage: apiResult.errorMessage,
            data: state.cartState.data,
          ),
          productIds: currentProducts,
        ),
      );
    }
  }

  Future<void> updateProductQty(String productId, int count) async {
    List<String> currentProducts = state.productIds;
    currentProducts.add(productId);
    print("emitting new list ${currentProducts}");
    emit(
      state.copyWith(
        cartState: Resource.loading(data: state.cartState.data),
        productIds: currentProducts,
      ),
    );
    print("after emit: ${state.productIds}");

    var apiResult = await _repository.updateCartQty(productId, count);
    currentProducts.remove(productId);
    if (apiResult.isSuccess) {
      emit(
        state.copyWith(
          cartState: Resource.success(data: apiResult.getData()),
          productIds: currentProducts,
        ),
      );
    } else {
      emit(
        state.copyWith(
          cartState: Resource.error(
            errorMessage: apiResult.errorMessage,
            data: state.cartState.data,
          ),
          productIds: currentProducts,
        ),
      );
    }
  }
}
