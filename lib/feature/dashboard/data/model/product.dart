import 'package:shop_mitra/feature/dashboard/domain/entity/product.dart';

List<ProductModel> productsList(List<dynamic> json) =>
    json.map((item) => ProductModel.fromJson(item)).toList();

class ProductModel extends Product{
  ProductModel({required super.id, required super.title, required super.price, required super.description, required super.category, required super.image, required super.productRating});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? '--',
      price: json["price"] ?? 0,
      description: json["description"] ??'--',
      category: json["json"] ?? '--',
      image: json["image"] ?? '--',
      productRating: ProductRatingModel.fromJson(json["rating"] ?? {}) ,
    );
  }
}

class ProductRatingModel extends ProductRating {
  ProductRatingModel({required super.rate, required super.count});
  factory ProductRatingModel.fromJson(Map<String, dynamic> json) {
    return ProductRatingModel(rate: json["rate"] ?? 0, count: json["count"]?? 0);
  }


}
