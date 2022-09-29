import 'package:pika_pika_test_project/presentation/utils/string_formatter.dart';

const nullFieldFromApi = 'unknown';

class Pokemon {
  String name;
  String frontImage;
  List<String> types;
  int weight;
  int height;
  bool isDefault;

  Pokemon({
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
    required this.isDefault,
  });

  @override
  List<Object> get props =>
      [name, frontImage, types, weight, height, isDefault];

  factory Pokemon.fromApiMap(Map<String, dynamic> map) {
    final resultList = <String>[];
    if (map['types'] != null) {
      for (final type in map['types']) {
        resultList.add(type['type']['name']);
      }
    }

    return Pokemon(
      name: map['name'] ?? nullFieldFromApi,
      frontImage: map['sprites']['front_default'] ?? nullFieldFromApi,
      types: resultList,
      weight: map['weight'] ?? nullFieldFromApi,
      height: map['height'] ?? nullFieldFromApi,
      isDefault: map['is_default'] ?? nullFieldFromApi,
    );
  }

  factory Pokemon.fromDBMap(Map<String, dynamic> map) {
    return Pokemon(
      name: map['name'] ?? nullFieldFromApi,
      frontImage: map['front_default'] ?? nullFieldFromApi,
      types: StringFormatter.convertStringDBToList(map['types']),
      weight: map['weight'] ?? nullFieldFromApi,
      height: map['height'] ?? nullFieldFromApi,
      isDefault: map['is_default'] ?? nullFieldFromApi,
    );
  }

  Map<String, dynamic> toDBMap() {
    return {
      'name': name,
      'front_default': frontImage,
      'types': StringFormatter.convertListToDBString(types),
      'weight': weight,
      'height': height,
      'is_default': isDefault,
    };
  }
}
