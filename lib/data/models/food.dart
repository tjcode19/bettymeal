class Food {
  final int id;
  final String name;
  final String description;
  final String image;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.image
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        image: map['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image
    };
  }
}
