class Product {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final double price;
  final String image;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.image,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      specs: Map<String, String>.from(json['specs'] as Map),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'price': price,
        'image': image,
        'specs': specs,
      };
}
