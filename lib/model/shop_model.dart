class Shop {
  final String id;
  final String title;
  final String slug;
  final String thumbnailImage;
  final int quantity;
  final String price;
  final int discount;
  final dynamic promotional;
  final int totalReviews;
  final int averageReview;
  final Category category;
  final double priceWithTax;
  final double discountedPriceWithTax;

  Shop({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.promotional,
    required this.totalReviews,
    required this.averageReview,
    required this.category,
    required this.priceWithTax,
    required this.discountedPriceWithTax,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      thumbnailImage: json['thumbnail_image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? '0.0',
      discount: json['discount'] ?? 0,
      promotional: json['promotional'],
      totalReviews: json['total_reviews'] ?? 0,
      averageReview: json['average_review'] ?? 0,
      category: Category.fromJson(json['category'] ?? {}),
      priceWithTax: json['price_with_tax'] != null
          ? double.parse(json['price_with_tax'].toString())
          : 0.0,
      discountedPriceWithTax: json['discounted_price_with_tax'] != null
          ? double.parse(json['discounted_price_with_tax'].toString())
          : 0.0,
    );
  }
}

class Category {
  final String id;
  final String name;
  final String parent;
  final String thumbnailImage;

  Category({
    required this.id,
    required this.name,
    required this.parent,
    required this.thumbnailImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      parent: json['parent'] ?? '',
      thumbnailImage: json['thumbnail_image'] ?? '',
    );
  }
}
