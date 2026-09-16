import 'package:ecommerce_c19/features/commerce/domain/entity/sub_category.dart';
import 'package:ecommerce_c19/features/network/model/response/category/category_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubCategoryMapper {
  SubCategory toEntity(CategoryDM? model) {
    return SubCategory(
      id: model?.id ?? '',
      name: model?.name ?? '',
      slug: model?.slug ?? '',
      categoryId: model?.category ?? '',
      image: model?.image ?? '',
    );
  }

  List<SubCategory> toEntityList(List<CategoryDM>? models) {
    return models?.map((e) => toEntity(e)).toList() ?? [];
  }
}
