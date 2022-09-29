import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tablePokemonItems = 'pokemon_items';
const String columnPokemonItemId = 'id';
const String columnPokemonItemName = 'name';
const String columnPokemonItemUrl = 'url';

const String tablePokemons = 'pokemons';
const String columnPokemonId = 'id';
const String columnPokemonName = 'name';
const String columnPokemonPhoto = 'front_default';
const String columnPokemonTypes = 'types';
const String columnPokemonHeight = 'weight';
const String columnPokemonWeight = 'height';
const String columnPokemonIsDefault = 'is_default';

class SqliteDataBaseOpenHelper {
  static late final Database _database;

  static Future<void> initialize() async => _database = await initDatabase();

  static Database get database {
    return _database;
  }

  static Future<Database> initDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'appdb.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
         create table $tablePokemonItems(
        $columnPokemonItemId integer primary key autoincrement,  
        $columnPokemonItemName text,
        $columnPokemonItemUrl text not null)
       ''');
        db.execute('''
         create table $tablePokemons(
        $columnPokemonId integer primary key autoincrement,  
        $columnPokemonName text,
        $columnPokemonPhoto text,
        $columnPokemonTypes text,
        $columnPokemonWeight integer,
        $columnPokemonHeight integer,
        $columnPokemonIsDefault text) 
       ''');
      },
    );
    return database;
  }
}
