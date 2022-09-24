class Pokemon {
  String name;
  String frontImage;
  List<String> types;
  int weight;
  int height;
  bool isDefault;

  List<Object> get props =>
      [name, frontImage, types, weight, height, isDefault];

  Pokemon({
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
    required this.isDefault,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      name: map['name'] ?? '',
      name: map['name'] ?? '',
      name: map['name'] ?? '',
      name: map['name'] ?? '',
      name: map['name'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
