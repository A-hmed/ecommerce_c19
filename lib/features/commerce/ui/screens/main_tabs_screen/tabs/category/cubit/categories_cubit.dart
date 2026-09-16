import 'package:ecommerce_c19/features/commerce/domain/usecase/get_categories_usecase.dart';
import 'package:ecommerce_c19/features/commerce/domain/usecase/get_sub_categories_usecase.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/category/cubit/categories_state.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;

  CategoriesCubit(
    this._getCategoriesUseCase,
    this._getSubCategoriesUseCase,
  ) : super(CategoriesState.initial());

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesApi: Resource.loading()));
    var apiResult = await _getCategoriesUseCase.call();
    if (apiResult.isSuccess) {
      final categories = apiResult.getData() ?? [];
      emit(state.copyWith(
        categoriesApi: Resource.success(data: categories),
        selectedCategoryIndex: 0,
      ));
      if (categories.isNotEmpty) {
        getSubCategories(categories[0].id);
      }
    } else {
      emit(state.copyWith(
        categoriesApi: Resource.error(errorMessage: apiResult.errorMessage),
      ));
    }
  }

  void selectCategory(int index) {
    if (index == state.selectedCategoryIndex) return;

    final categories = state.categoriesApi.data;
    if (categories != null && index >= 0 && index < categories.length) {
      emit(state.copyWith(selectedCategoryIndex: index));
      getSubCategories(categories[index].id);
    }
  }

  Future<void> getSubCategories(String categoryId) async {
    emit(state.copyWith(subCategoriesApi: Resource.loading()));
    var apiResult = await _getSubCategoriesUseCase.call(categoryId);
    if (apiResult.isSuccess) {
      emit(state.copyWith(
        subCategoriesApi: Resource.success(data: apiResult.getData() ?? []),
      ));
    } else {
      emit(state.copyWith(
        subCategoriesApi: Resource.error(errorMessage: apiResult.errorMessage),
      ));
    }
  }
}
