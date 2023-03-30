class FoodRequestModel {
  FoodRequestModel({
    required this.name,
    required this.description,
    required this.type,
    required this.image,
  });

  final String name;
  final String description;
  final int type;
  final String image;

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'image': image
    };
  }
}

class FoodModel {
  final int? id;
  final String name;
  final String description;
  final int type;
  final String image;
  final List<String>? foodextra_id;

  FoodModel({
    this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.image,
    this.foodextra_id,
  });

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        type: map['type'],
        image: map['image'],
        foodextra_id: map['foodextra_id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'image': image,
      'foodextra_id': foodextra_id
    };
  }
}
