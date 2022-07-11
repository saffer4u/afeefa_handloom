// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

import '../../cart/models/cart_product_model.dart';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

Map<String, dynamic> ordersModelToJson(OrdersModel data) => data.toJson();

class OrdersModel {
  OrdersModel({
    this.gst,
    this.cartProductModel,
    this.total,
    this.netAmount,
    this.orderId,
  });

  double? gst;
  List<CartProductModel>? cartProductModel;
  double? total;
  double? netAmount;
  String? orderId;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        gst: json["gst"].toDouble(),
        cartProductModel: List<CartProductModel>.from(json["cart_product_model"].map((x) => CartProductModel.fromJson(x))),
        total: json["total"].toDouble(),
        netAmount: json["net_amount"].toDouble(),
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "gst": gst,
        "cart_product_model": List<dynamic>.from(cartProductModel!.map((x) => x.toJson())),
        "total": total,
        "net_amount": netAmount,
        "order_id":orderId,
      };
}

// class CartProductModel {
//   CartProductModel({
//     this.imageUrl,
//     this.itemAddTime,
//     this.price,
//     this.quantity,
//     this.productId,
//     this.title,
//   });

//   String imageUrl;
//   String itemAddTime;
//   String price;
//   int quantity;
//   String productId;
//   String title;

//   factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
//         imageUrl: json["image_url"],
//         itemAddTime: json["item_add_time"],
//         price: json["price"],
//         quantity: json["quantity"],
//         productId: json["product_id"],
//         title: json["title"],
//       );

//   Map<String, dynamic> toJson() => {
//         "image_url": imageUrl,
//         "item_add_time": itemAddTime,
//         "price": price,
//         "quantity": quantity,
//         "product_id": productId,
//         "title": title,
//       };
// }
