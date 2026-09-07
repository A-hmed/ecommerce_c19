import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/network/model/response/product/product_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductMapper {
  Product toEntity(ProductDM? model) {
    return Product(
      sold: model?.sold ?? 0,
      images: model?.images ?? [],
      ratingsQuantity: model?.ratingsQuantity ?? 0,
      id: model?.id ?? '',
      title: model?.title ?? '',
      description: model?.description ?? '',
      quantity: model?.quantity ?? 0,
      price: model?.price ?? 0,
      imageCover: model?.imageCover ?? '',
      ratingsAverage: model?.ratingsAverage ?? 0,
    );
  }

  List<Product> toEntityList(List<ProductDM>? models) {
    return models?.map((e) => toEntity(e)).toList() ?? [];
  }
}
