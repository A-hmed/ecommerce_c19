class AddProductToCartRequest {
  AddProductToCartRequest({
      this.productId,});

  AddProductToCartRequest.fromJson(dynamic json) {
    productId = json['productId'];
  }
  String? productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    return map;
  }

}