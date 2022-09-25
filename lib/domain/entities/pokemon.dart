const nullFieldFromApi = 'unknown';

class Pokemon {
  String? name;
  String? frontImage;
  List<String>? types;
  int? weight;
  int? height;
  bool? isDefault;

  Pokemon({
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
    required this.isDefault,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    final resultList = <String>[];
    if (map['types'] != null) {
      for (final type in map['types']) {
        resultList.add(type['type']['name']);
      }
    }

    return Pokemon(
      name: map['name'] ?? nullFieldFromApi,
      frontImage: map['front_default'] ?? nullFieldFromApi,
      types: resultList,
      weight: map['weight'] ?? nullFieldFromApi,
      height: map['height'] ?? nullFieldFromApi,
      isDefault: map['is_default'] ?? nullFieldFromApi,
    );
  }
}
