class Product {
  String weight = '0';
  int version = 1;
  String id = '';
  String title = '';
  List<String> images = const [];
  List<String> sizes = const [];
  String description = '';
  double rate = 0;
  String fabric = '';
  List<String> colors = const [];
  Map<String, String> moreFields = const {};
  late DateTime productAddTime;

  Product({
    this.weight = '0',
    this.version = 1,
    this.id = '',
    this.title = '',
    this.images = const [],
    this.sizes = const [],
    this.description = '',
    this.rate = 0,
    this.fabric = '',
    this.colors = const [],
    this.moreFields = const {},
    required this.productAddTime,
  });

  Product.toObject(Map<String, dynamic> map) {
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
    moreFields = map['moreFields'];
  }

  Map<String, dynamic> toMap() {
    return {
      'weight':weight,
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
}
