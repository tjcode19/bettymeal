class FoodExtraModel {
  final int? id;
  final String name;

  FoodExtraModel({
    this.id,
    required this.name,
  });

  factory FoodExtraModel.fromMap(Map<String, dynamic> map) {
    return FoodExtraModel(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
