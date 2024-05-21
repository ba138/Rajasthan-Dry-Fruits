class ProductCategory {
  final String id;
  final String name;
  final String? parent;
  final String? thumbnailImage;

  ProductCategory({
    required this.id,
    required this.name,
    this.parent,
    this.thumbnailImage,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      parent: json['parent'] ?? '',
      thumbnailImage: json['thumbnail_image'] ?? '',
    );
  }
}

class Product {
  final String id;
  final String title;
  final String slug;
  final String thumbnailImage;
  final double price;
  final double discount;
  final ProductCategory category;
  final dynamic productWeight;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnailImage,
    required this.price,
    required this.discount,
    required this.category,
    required this.productWeight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      slug: json['slug'] ?? '', // Assuming slug can be empty
      thumbnailImage: json['thumbnail_image'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      discount: double.tryParse(json['discount'].toString()) ?? 0.0,
      category: ProductCategory.fromJson(json['category']),
      productWeight: json['product_weight'],
    );
  }
}

class CartItem {
  final int id;
  final Product product;
  final int quantity;
  final dynamic productWeight;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.productWeight,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      productWeight: json['product_weight'],
    );
  }
}
