class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final List<String> images;
  final String category;
  final bool inStock;
  final double? rating;
  final int? reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    required this.inStock,
    this.rating,
    this.reviewCount,
  });
}
