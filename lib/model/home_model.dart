class Product {
  final String id;
  final String title;
  final String slug;
  final String thumbnailImage;
  final double price;
  final int discount;
  final Category category;
  final double averageReview;
  final int totalReviews;
  final double priceWithTax;
  final double discountedPriceWithTax;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.price,
    required this.discount,
    required this.category,
    required this.averageReview,
    required this.totalReviews,
    required this.priceWithTax,
    required this.discountedPriceWithTax,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      thumbnailImage: json['thumbnail_image'],
      price: double.parse(json['price'].toString()),
      discount: json['discount'],
      category: Category.fromJson(json['category']),
      averageReview: json['average_review'].toDouble(),
      totalReviews: json['total_reviews'],
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
  final String? parent;
  final String? thumbnailImage;

  Category({
    required this.id,
    required this.name,
    this.parent,
    this.thumbnailImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      parent: json['parent'],
      thumbnailImage: json['thumbnail_image'],
    );
  }
}

class ApiResponse {
  final List<Product> topDiscountedProducts;
  final List<Product> newProducts;
  final List<Product> mostSales;
  final List<Category> categories;

  ApiResponse({
    required this.topDiscountedProducts,
    required this.newProducts,
    required this.mostSales,
    required this.categories,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      topDiscountedProducts: (json['top_discounted_products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      newProducts: (json['new_products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      mostSales: (json['most_sales'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      categories: (json['categories'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
    );
  }
}
