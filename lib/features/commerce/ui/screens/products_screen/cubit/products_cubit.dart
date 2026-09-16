import 'package:ecommerce_c19/features/commerce/domain/usecase/get_products_usecase.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/products_screen/cubit/products_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsCubit(this._getProductsUseCase) : super(ProductsState.initial());

  Future<void> getProducts({
    String? category,
    String? subCategory,
  }) async {
    emit(state.copyWith(productsApi: Resource.loading()));
    var apiResult = await _getProductsUseCase.call(
      category: category,
      subCategory: subCategory,
    );
    if (apiResult.isSuccess) {
      emit(state.copyWith(
        productsApi: Resource.success(data: apiResult.getData() ?? []),
      ));
    } else {
      emit(state.copyWith(
        productsApi: Resource.error(errorMessage: apiResult.errorMessage),
      ));
    }
  }
}
