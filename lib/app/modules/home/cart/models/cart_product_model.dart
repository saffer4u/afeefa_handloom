import 'dart:convert';

CartProductModel cartProductModelFromJson(String str) => CartProductModel.fromJson(json.decode(str));

String cartProductModelToJson(CartProductModel data) => json.encode(data.toJson());

class CartProductModel {
  CartProductModel({
    this.itemAddTime,
    this.price,
    this.quantity,
    this.productId,
    this.imageUrl,
    this.title,
  });

  String? itemAddTime;
  String? price;
  int? quantity;
  String? productId;
  String? imageUrl;
  String? title;

  factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
        itemAddTime: json["item_add_time"],
        price: json["price"],
        quantity: json["quantity"],
        productId: json["product_id"],
        imageUrl: json["image_url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "item_add_time": itemAddTime,
        "price": price,
        "quantity": quantity,
        "product_id": productId,
        "image_url": imageUrl,
        "title":title,
      };
}
