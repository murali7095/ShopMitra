List<Product> listFromJson(List<dynamic> json) =>
    json.map((item) => Product.fromJson(item)).toList();

class Product {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final ProductRating productRating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.productRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      title: json["title"] ?? '--',
      price: json["price"] ?? 0,
      description: json["description"] ??'--',
      category: json["json"] ?? '--',
      image: json["image"] ?? '--',
      productRating: ProductRating.fromJson(json["rating"] ?? {}) ,
    );
  }
}

class ProductRating {
  final num rate;
  final int count;

  ProductRating({required this.rate, required this.count});

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(rate: json["rate"], count: json["count"]);
  }
}
