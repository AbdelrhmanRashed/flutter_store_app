class ProductsModel {
  final int? id;
  final String? title;
  final num? price;
  final String? image;
  final String? description;
  final String? category;

  ProductsModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'],
      description: json['description'],
      category: json['category'],
    );
  }
}
