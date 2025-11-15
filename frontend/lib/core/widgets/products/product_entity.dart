class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final List<String> images;
  final String category;
  final bool inStock;
  final double? rating;
  final int? reviewCount;
  final int? discount;

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
    this.discount,
  });
}
