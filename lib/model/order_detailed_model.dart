class OrderDetailedModel {
  String fullName;
  String contact;
  String postalCode;
  String address;
  String city;
  String state;
  String country;
  double total; // Change type to double
  double serviceCharges; // Change type to double
  double shippingCharges; // Change type to double
  double subTotal; // Change type to double
  String paymentType;
  String orderStatus;
  String paymentStatus;
  bool isActive;
  DateTime createdOn;
  List<OrderItem> orderItems;

  OrderDetailedModel({
    required this.fullName,
    required this.contact,
    required this.postalCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.total,
    required this.serviceCharges,
    required this.shippingCharges,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.paymentStatus,
    required this.isActive,
    required this.createdOn,
    required this.orderItems,
  });

  factory OrderDetailedModel.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];
    if (json['order_items'] != null) {
      json['order_items'].forEach((item) {
        orderItems.add(OrderItem.fromJson(item));
      });
    }
    return OrderDetailedModel(
      fullName: json['full_name'],
      contact: json['contact'],
      postalCode: json['postal_code'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      total: json['total'].toDouble(), // Convert to double
      serviceCharges: json['service_charges'].toDouble(), // Convert to double
      shippingCharges: json['shipping_charges'].toDouble(), // Convert to double
      subTotal: json['sub_total'].toDouble(), // Convert to double
      paymentType: json['payment_type'],
      orderStatus: json['order_status'],
      paymentStatus: json['payment_status'],
      isActive: json['is_active'],
      createdOn: DateTime.parse(json['created_on']),
      orderItems: orderItems,
    );
  }
}

class OrderItem {
  Product product;
  ProductWeight? productWeight;
  int qty;

  OrderItem({
    required this.product,
    required this.qty,
    this.productWeight,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: Product.fromJson(json['product']),
      qty: json['qty'],
      productWeight: json['product_weight'] != null
          ? ProductWeight.fromJson(json['product_weight'])
          : null,
    );
  }
}

class Product {
  String id;
  String sku;
  String title;
  String slug;
  String description;
  String thumbnailImage;
  double price; // Changed to double
  int discount;
  dynamic promotional;
  int totalReviews;
  int averageReview;

  Product({
    required this.id,
    required this.sku,
    required this.title,
    required this.slug,
    required this.description,
    required this.thumbnailImage,
    required this.price,
    required this.discount,
    required this.promotional,
    required this.totalReviews,
    required this.averageReview,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Extract price string and remove extra characters
    String priceString = json['price'].toString();
    priceString = priceString.replaceAll(
        RegExp(r'[^0-9.]'), ''); // Remove non-numeric characters

    // Convert price string to double
    double price = double.tryParse(priceString) ?? 0.0;

    return Product(
      id: json["id"],
      sku: json["sku"],
      title: json["title"],
      slug: json["slug"],
      description: json["description"],
      thumbnailImage: json["thumbnail_image"],
      price: price, // Assign the processed price
      discount: json["discount"],
      promotional: json["promotional"],
      totalReviews: json["total_reviews"],
      averageReview: json["average_review"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "title": title,
        "slug": slug,
        "description": description,
        "thumbnail_image": thumbnailImage,
        "price": price,
        "discount": discount,
        "promotional": promotional,
        "total_reviews": totalReviews,
        "average_review": averageReview,
      };
}

class ProductWeight {
  int id;
  double price; // Changed to double
  Weight weight;

  ProductWeight({
    required this.id,
    required this.price,
    required this.weight,
  });

  factory ProductWeight.fromJson(Map<String, dynamic> json) {
    // Extract price string and remove extra characters
    String priceString = json['price'].toString();
    priceString = priceString.replaceAll(
        RegExp(r'[^0-9.]'), ''); // Remove non-numeric characters

    // Convert price string to double
    double price = double.tryParse(priceString) ?? 0.0;

    return ProductWeight(
      id: json["id"],
      price: price, // Assign the processed price
      weight: Weight.fromJson(json["weight"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "weight": weight.toJson(),
      };
}

class Weight {
  int id;
  String name;

  Weight({
    required this.id,
    required this.name,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
