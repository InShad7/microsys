class ItemModel {
  final String id;
  final String itemName;
  final String description;
  final String price;
  final String unit;
  final String category;

  ItemModel({
    required this.id,
    required this.itemName,
    required this.description,
    required this.price,
    required this.unit,
    required this.category,
  });

  // Convert a JSON object into an ItemModel
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String,
      itemName: json['itemName'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      unit: json['unit'] as String,
      category: json['category'] as String,
    );
  }

  // Convert an ItemModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'description': description,
      'price': price,
      'unit': unit,
      'category': category,
    };
  }
}
