import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';

class CategoriesState {
  final Resource<List<Category>> categoriesApi;
  final Resource<List<Category>> subCategoriesApi;
  final Category? selectedCategory;

  const CategoriesState({
    required this.categoriesApi,
    required this.subCategoriesApi,
    this.selectedCategory,
  });

  factory CategoriesState.initial() => CategoriesState(
        categoriesApi: Resource.initial(),
        subCategoriesApi: Resource.initial(),
        selectedCategory: null,
      );

  CategoriesState copyWith({
    Resource<List<Category>>? categoriesApi,
    Resource<List<Category>>? subCategoriesApi,
    Category? selectedCategory,
  }) {
    return CategoriesState(
      categoriesApi: categoriesApi ?? this.categoriesApi,
      subCategoriesApi: subCategoriesApi ?? this.subCategoriesApi,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
