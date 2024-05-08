class ProductDetail {
  final String id;
  final String sku;
  final String title;
  final String slug;
  final String manufacturerBrand;
  final Category category;
  final List<String> images;
  final String description;
  final String thumbnailImage;
  final String? videoLink;
  final int quantity;
  final String price;
  final int discount;
  final String? promotional;
  final int totalReviews;
  final List<ProductWeight> productWeight;

  ProductDetail({
    required this.id,
    required this.sku,
    required this.title,
    required this.slug,
    required this.manufacturerBrand,
    required this.category,
    required this.images,
    required this.description,
    required this.thumbnailImage,
    required this.videoLink,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.promotional,
    required this.totalReviews,
    required this.productWeight,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      sku: json['sku'],
      title: json['title'],
      slug: json['slug'],
      manufacturerBrand: json['manufacturer_brand'],
      category: Category.fromJson(json['category']),
      images: List<String>.from(json['images']),
      description: json['description'],
      thumbnailImage: json['thumbnail_image'],
      videoLink: json['video_link'],
      quantity: json['quantity'],
      price: json['price'],
      discount: json['discount'],
      promotional: json['promotional'],
      totalReviews: json['total_reviews'],
      productWeight: List<ProductWeight>.from(
          json['product_weight'].map((x) => ProductWeight.fromJson(x))),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String? parent;
  final String thumbnailImage;

  Category({
    required this.id,
    required this.name,
    required this.parent,
    required this.thumbnailImage,
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
}
