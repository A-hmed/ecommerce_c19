
import 'package:ecommerce_c19/features/network/model/response/products/product_dm.dart';

class CartEntry {
  CartEntry({
      this.count, 
      this.id, 
      this.productDM,
      this.price,});

  CartEntry.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    productDM = json['product'] != null ? ProductDM.fromJson(json['product']) : null;
    price = json['price'];
  }
  num? count;
  String? id;
  ProductDM? productDM;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['_id'] = id;
    if (productDM != null) {
      map['product'] = productDM?.toJson();
    }
    map['price'] = price;
    return map;
  }

}