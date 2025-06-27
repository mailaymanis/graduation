class ProductModel {
  String? productId;
  DateTime? createdAt;
  String? productName;
  String? price;
  String? productDetails;
  String? productImage;

  ProductModel({
    this.productId,
    this.createdAt,
    this.productName,
    this.price,
    this.productDetails,
    this.productImage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: json['product_id'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    productName: json['product_name'] as String?,
    price: json['price'] as String?,
    productDetails: json['product_details'] as String?,
    productImage: json['product_image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'created_at': createdAt?.toIso8601String(),
    'product_name': productName,
    'price': price,
    'product_details': productDetails,
    'product_image': productImage,
  };
}
