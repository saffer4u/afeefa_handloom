import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String weight = '';
  int version = 1;
  String id = '';
  String title = '';
  List<String> images = const [];
  String sizes = '';
  String description = '';
  String rate = '';
  String fabric = '';
  List<String> colors = const [];
  // Map<String, String> moreFields = const {};
  late DateTime productAddTime;
  int stock = 0;

  Product({
    this.stock = 0,
    this.weight = '',
    this.version = 1,
    this.id = '',
    this.title = '',
    this.images = const [],
    this.sizes = '',
    this.description = '',
    this.rate = '',
    this.fabric = '',
    this.colors = const [],
    // this.moreFields = const {},
    required this.productAddTime,
  });

  Product.toObject(Map<String, dynamic> map) {
    stock = map['stock'];
    weight = map['weight'];
    version = map['version'];
    productAddTime = map['productAddTime'];
    id = map['id'];
    title = map['title'];
    images = map['images'];
    sizes = map['sizes'];
    description = map['description'];
    rate = map['rate'];
    fabric = map['fabric'];
    colors = map['colors'];
    // moreFields = map['moreFields'];
  }

  Map<String, dynamic> toMap() {
    return {
      'stock':stock,
      'weight': weight,
      'version': version,
      'id': id,
      'title': title,
      'images': images,
      'sizes': sizes,
      'description': description,
      'rate': rate,
      'fabric': fabric,
      'colors': colors,
      'productAddTime': productAddTime,
    };
  }

  static Product fromJson(Map<String, dynamic> map) {
    List<String> colors = [];
    List<String> images = [];
    for (var item in map['colors']) {
      colors.add(item);
    }
    for (var item in map['images']) {
      images.add(item);
    }
    Product product = Product(
      stock:map['stock'],
      productAddTime: (map['productAddTime'] as Timestamp).toDate(),
      weight: map['weight'],
      version: map['version'],
      id: map['id'],
      title: map['title'],
      images: images,
      sizes: map['sizes'],
      description: map['description'],
      rate: map['rate'],
      fabric: map['fabric'],
      colors: colors,
    );
    print(product.toMap());
    return product;
  }
}
