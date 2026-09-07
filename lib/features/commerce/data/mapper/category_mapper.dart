import 'package:ecommerce_c19/features/commerce/domain/entity/category.dart';
import 'package:ecommerce_c19/features/network/model/response/category/category_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryMapper {
  Category toEntity(CategoryDM? model) {
    return Category(
      id: model?.id ?? '',
      name: model?.name ?? '',
      image: model?.image ?? '',
    );
  }

  List<Category> toEntityList(List<CategoryDM>? models) {
    return models?.map((e) => toEntity(e)).toList() ?? [];
  }
}
