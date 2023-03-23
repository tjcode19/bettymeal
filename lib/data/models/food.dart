class FoodModel {
  final int? id;
  final String name;
  final String description;
  final String image;

  FoodModel(
      {this.id,
      required this.name,
      required this.description,
      required this.image});

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        image: map['image']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description, 'image': image};
  }
}
