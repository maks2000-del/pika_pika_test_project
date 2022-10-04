import '../../core_ui/converters/string_formatter.dart';

const nullFieldFromApi = 'unknown';

class Pokemon {
  String name;
  String frontImage;
  List<String> types;
  int weight;
  int height;

  Pokemon({
    required this.name,
    required this.frontImage,
    required this.types,
    required this.weight,
    required this.height,
  });

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
    );
  }

  factory Pokemon.fromDBMap(Map<String, dynamic> map) => Pokemon(
        name: map['name'] ?? '',
        frontImage: map['front_default'] ?? '',
        types: StringFormatter.convertStringDBToList(map['types']),
        height: map['height'] ?? '',
        weight: map['weight'] ?? '',
      );

  Map<String, dynamic> toDBMap(int id) {
    return {
      'id': id,
      'name': name,
      'front_default': frontImage,
      'types': StringFormatter.convertListToDBString(types),
      'weight': weight,
      'height': height,
    };
  }
}
