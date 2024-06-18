class ProductDetail {
  final String id;
  final String sku;
  final String title;
  final String slug;
  final String manufacturerBrand;
  final String shortDescription;
  final Category category;
  final List<String> images;
  final String description;
  final String thumbnailImage;
  final double averageReview;
  final String? videoLink;
  final int quantity;
  final String price;
  final int discount;
  final String? promotional;
  final int? totalReviews;
  final List<ProductWeight> productWeight;
  final List<ProductReview> productReview;
  final double priceWithTax;
  final double discountedPriceWithTax;

  ProductDetail({
    required this.id,
    required this.sku,
    required this.title,
    required this.slug,
    required this.manufacturerBrand,
    required this.shortDescription,
    required this.category,
    required this.images,
    required this.description,
    required this.thumbnailImage,
    required this.averageReview,
    this.videoLink,
    required this.quantity,
    required this.price,
    required this.discount,
    this.promotional,
    this.totalReviews,
    required this.productWeight,
    required this.productReview,
    required this.priceWithTax,
    required this.discountedPriceWithTax,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'] ?? "",
      sku: json['sku'] ?? "",
      title: json['title'] ?? "",
      slug: json['slug'] ?? "",
      manufacturerBrand: json['manufacturer_brand'] ?? "",
      shortDescription: json['short_description'] ?? "",
      category: Category.fromJson(json['category'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? "",
      thumbnailImage: json['thumbnail_image'] ?? "",
      averageReview: (json['average_review'] as num?)?.toDouble() ?? 0.0,
      videoLink: json['video_link'],
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? "",
      discount: json['discount'] ?? 0,
      promotional: json['promotional'],
      totalReviews: json['total_reviews'],
      productWeight: List<ProductWeight>.from(
          (json['product_weight'] ?? []).map((x) => ProductWeight.fromJson(x))),
      productReview: List<ProductReview>.from(
          (json['product_review'] ?? []).map((x) => ProductReview.fromJson(x))),
      priceWithTax: (json['price_with_tax'] as num?)?.toDouble() ?? 0.0,
      discountedPriceWithTax:
          (json['discounted_price_with_tax'] as num?)?.toDouble() ?? 0.0,
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
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      parent: json['parent'],
      thumbnailImage: json['thumbnail_image'],
    );
  }
}

class ProductWeight {
  final int id;
  final String price;
  final Weight weight;
  final double priceWithTax;
  final double discountedPriceWithTax;

  ProductWeight({
    required this.id,
    required this.price,
    required this.weight,
    required this.priceWithTax,
    required this.discountedPriceWithTax,
  });

  factory ProductWeight.fromJson(Map<String, dynamic> json) {
    return ProductWeight(
      id: json['id'] ?? 0,
      price: json['price'] ?? "",
      weight: Weight.fromJson(json['weight'] ?? {}),
      priceWithTax: (json['price_with_tax'] as num?)?.toDouble() ?? 0.0,
      discountedPriceWithTax:
          (json['discounted_price_with_tax'] as num?)?.toDouble() ?? 0.0,
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
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }
}

class ProductReview {
  final Client client;
  final int rate;
  final String comment;
  final DateTime createdOn;

  ProductReview({
    required this.client,
    required this.rate,
    required this.comment,
    required this.createdOn,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      client: Client.fromJson(json['client'] ?? {}),
      rate: json['rate'] ?? 0,
      comment: json['comment'] ?? "",
      createdOn: DateTime.parse(json['created_on'] ?? ""),
    );
  }
}

class Client {
  final int id;
  final String username;
  final String email;
  final String? profileImage;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;

  Client({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? 0,
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      profileImage: json['profile_image'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
    );
  }
}
