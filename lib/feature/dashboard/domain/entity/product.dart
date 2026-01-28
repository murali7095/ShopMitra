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
}

class ProductRating {
  final num rate;
  final int count;

  ProductRating({required this.rate, required this.count});
}
