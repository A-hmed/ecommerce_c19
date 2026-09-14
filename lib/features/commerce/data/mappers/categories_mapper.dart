import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/network/model/response/categories/category_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesMapper {
  Category toEntity(CategoryDM categoryDM) => Category(
    id: categoryDM.id ?? "",
    name: categoryDM.name ?? "",
    image: categoryDM.image,
  );

  List<Category> toEntities(List<CategoryDM> categories) =>
      categories.map(toEntity).toList();
}
