import 'package:ecommerce_c19/features/commerce/domain/entity/product.dart';
import 'package:ecommerce_c19/features/network/model/response/products/product_dm.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsMapper {
  Product toEntity(ProductDM productDM) => Product(
        sold: productDM.sold ?? 0,
        images: productDM.images ?? [],
        ratingsQuantity: productDM.ratingsQuantity ?? 0,
        id: productDM.id ?? "",
        title: productDM.title ?? "",
        description: productDM.description ?? "",
        quantity: productDM.quantity ?? 0,
        price: productDM.price ?? 0,
        imageCover: productDM.imageCover ?? "",
        ratingsAverage: productDM.ratingsAverage ?? 0,
      );

  List<Product> toEntities(List<ProductDM> products) =>
      products.map(toEntity).toList();
}
