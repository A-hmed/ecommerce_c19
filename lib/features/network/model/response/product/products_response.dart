import 'package:ecommerce_c19/features/network/model/response/common/metadata.dart';

import 'product_dm.dart';

class ProductsResponse {
  num? results;
  Metadata? metadata;
  List<ProductDM>? products;

  ProductsResponse({
    this.results,
    this.metadata,
    this.products,
  });

  ProductsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      products = [];
      json['data'].forEach((v) {
        products?.add(ProductDM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (products != null) {
      map['data'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
