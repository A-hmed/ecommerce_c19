import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/commerce/domain/entity/sub_category.dart';
import 'package:ecommerce_c19/features/common/utils/resource.dart';

class CategoriesState {
  late Resource<List<Category>> categoriesApi;
  late int selectedCategoryIndex;
  late Resource<List<SubCategory>> subCategoriesApi;

  CategoriesState({
    required this.categoriesApi,
    required this.selectedCategoryIndex,
    required this.subCategoriesApi,
  });

  CategoriesState.initial() {
    categoriesApi = Resource.initial();
    selectedCategoryIndex = 0;
    subCategoriesApi = Resource.initial();
  }

  Category? get selectedCategory {
    final categories = categoriesApi.data;
    if (categories != null &&
        selectedCategoryIndex >= 0 &&
        selectedCategoryIndex < categories.length) {
      return categories[selectedCategoryIndex];
    }
    return null;
  }

  CategoriesState copyWith({
    Resource<List<Category>>? categoriesApi,
    int? selectedCategoryIndex,
    Resource<List<SubCategory>>? subCategoriesApi,
  }) {
    return CategoriesState(
      categoriesApi: categoriesApi ?? this.categoriesApi,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      subCategoriesApi: subCategoriesApi ?? this.subCategoriesApi,
    );
  }
}
