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
      parent: json['parent'],
      thumbnailImage: json['thumbnail_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent': parent,
      'thumbnail_image': thumbnailImage,
    };
  }
}

class Product {
  final String id;
  final String title;
  final String slug;
  final String thumbnailImage;
  final String price;
  final double discount;
  final ProductCategory category;
  final double averageReview;
  final int totalReviews;
  final double? priceWithTax;
  final double? discountedPriceWithTax;

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
    this.priceWithTax,
    this.discountedPriceWithTax,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      thumbnailImage: json['thumbnail_image'],
      price: json['price'],
      discount: json['discount'].toDouble(),
      category: ProductCategory.fromJson(json['category']),
      averageReview: json['average_review'].toDouble(),
      totalReviews: json['total_reviews'],
      priceWithTax: json['price_with_tax'] != null
          ? json['price_with_tax'].toDouble()
          : null,
      discountedPriceWithTax: json['discounted_price_with_tax'] != null
          ? json['discounted_price_with_tax'].toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'thumbnail_image': thumbnailImage,
      'price': price,
      'discount': discount,
      'category': category.toJson(),
      'average_review': averageReview,
      'total_reviews': totalReviews,
      'price_with_tax': priceWithTax,
      'discounted_price_with_tax': discountedPriceWithTax,
    };
  }
}

class ProductWeight {
  final int id;
  final String name;
  final double price;
  final double? priceWithTax;
  final double? discountedPriceWithTax;

  ProductWeight({
    required this.id,
    required this.name,
    required this.price,
    this.priceWithTax,
    this.discountedPriceWithTax,
  });

  factory ProductWeight.fromJson(Map<String, dynamic> json) {
    return ProductWeight(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      priceWithTax: json['price_with_tax'] != null
          ? json['price_with_tax'].toDouble()
          : null,
      discountedPriceWithTax: json['discounted_price_with_tax'] != null
          ? json['discounted_price_with_tax'].toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'price_with_tax': priceWithTax,
      'discounted_price_with_tax': discountedPriceWithTax,
    };
  }
}

class CartItem {
  final int id;
  final Product product;
  final int quantity;
  final ProductWeight productWeight;

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
      productWeight: ProductWeight.fromJson(json['product_weight']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'product_weight': productWeight.toJson(),
    };
  }
}

class Cart {
  final List<CartItem> cartItems;
  final double totalPrice;
  final double discountPrice;
  final double shiprocketShippingCharges;
  final double subTotal;
  final double customShippingCharge;

  Cart({
    required this.cartItems,
    required this.totalPrice,
    required this.discountPrice,
    required this.shiprocketShippingCharges,
    required this.subTotal,
    required this.customShippingCharge,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartItems: (json['cart_items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalPrice: json['total_price'].toDouble(),
      discountPrice: json['discount_price'].toDouble(),
      shiprocketShippingCharges: json['shiprocket_shipping_charges'].toDouble(),
      subTotal: json['sub_total'].toDouble(),
      customShippingCharge: json['custom_shipping_charges'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_items': cartItems.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
      'discount_price': discountPrice,
      'shiprocket_shipping_charges': shiprocketShippingCharges,
      'sub_total': subTotal,
      'custom_shipping_charges': customShippingCharge,
    };
  }
}
