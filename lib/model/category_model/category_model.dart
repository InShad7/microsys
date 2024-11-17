class CategoryModel {
  final String id;
  final String categoryName;
  final String description;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      categoryName: json['categoryName'] as String,
      description: json['description'] as String,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'description': description,
      'isActive': isActive,
    };
  }
}
