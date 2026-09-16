import 'package:ecommerce_c19/features/commerce/data/usecase/get_categories_usecase.dart';
import 'package:ecommerce_c19/features/commerce/data/usecase/get_sub_categories_usecase.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/ui/screens/main_tabs_screen/tabs/categories/cubit/categories_state.dart';
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

  Future<void> loadCategories() async {
    emit(state.copyWith(categoriesApi: Resource.loading()));
    var result = await _getCategoriesUseCase();

    if (result.isSuccess) {
      final categories = result.getData() ?? [];
      final firstCategory = categories.isNotEmpty ? categories.first : null;
      emit(state.copyWith(
        categoriesApi: Resource.success(data: categories),
        selectedCategory: firstCategory,
      ));
      if (firstCategory != null) {
        loadSubCategories(firstCategory.id);
      }
    } else {
      emit(state.copyWith(
        categoriesApi: Resource.error(errorMessage: result.errorMessage),
      ));
    }
  }

  void selectCategory(Category category) {
    if (state.selectedCategory?.id == category.id) return;
    emit(state.copyWith(selectedCategory: category));
    loadSubCategories(category.id);
  }

  Future<void> loadSubCategories(String categoryId) async {
    emit(state.copyWith(subCategoriesApi: Resource.loading()));
    var result = await _getSubCategoriesUseCase(categoryId);
    if (result.isSuccess) {
      emit(state.copyWith(
        subCategoriesApi: Resource.success(data: result.getData()),
      ));
    } else {
      emit(state.copyWith(
        subCategoriesApi: Resource.error(errorMessage: result.errorMessage),
      ));
    }
  }
}
