class UpdateProductQtyRequest {
  UpdateProductQtyRequest({
      this.count,});

  UpdateProductQtyRequest.fromJson(dynamic json) {
    count = json['count'];
  }
  String? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    return map;
  }

}