class Order {
  final int order;
  final ReviewProduct product;
  final ProductWeight? productWeight;
  final int qty;

  Order({
    required this.order,
    required this.product,
    this.productWeight,
    required this.qty,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      order: json['order'],
      product: ReviewProduct.fromJson(json['product']),
      productWeight: json['product_weight'] != null
          ? ProductWeight.fromJson(json['product_weight'])
          : null,
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'product': product.toJson(),
      'product_weight': productWeight?.toJson(),
      'qty': qty,
    };
  }
}

class ReviewProduct {
  final String id;
  final String sku;
  final String title;
  final String slug;
  final String description;
  final String thumbnailImage;
  final String price;
  final int discount;
  final String? promotional;
  final int totalReviews;
  final double averageReview;

  ReviewProduct({
    required this.id,
    required this.sku,
    required this.title,
    required this.slug,
    required this.description,
    required this.thumbnailImage,
    required this.price,
    required this.discount,
    this.promotional,
    required this.totalReviews,
    required this.averageReview,
  });

  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      id: json['id'],
      sku: json['sku'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      thumbnailImage: json['thumbnail_image'],
      price: json['price'],
      discount: json['discount'],
      promotional: json['promotional'],
      totalReviews: json['total_reviews'],
      averageReview: json['average_review'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'title': title,
      'slug': slug,
      'description': description,
      'thumbnail_image': thumbnailImage,
      'price': price,
      'discount': discount,
      'promotional': promotional,
      'total_reviews': totalReviews,
      'average_review': averageReview,
    };
  }
}

class ProductWeight {
  final int id;
  final String price;
  final Weight weight;

  ProductWeight({
    required this.id,
    required this.price,
    required this.weight,
  });

  factory ProductWeight.fromJson(Map<String, dynamic> json) {
    return ProductWeight(
      id: json['id'],
      price: json['price'],
      weight: Weight.fromJson(json['weight']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'weight': weight.toJson(),
    };
  }
}

class Weight {
  final int id;
  final String name;

  Weight({
    required this.id,
    required this.name,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
