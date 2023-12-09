import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/field_of_science.dart';
import 'models/participation_in_scientific_event.dart';
import 'models/scientific_publication.dart';
import 'models/scientist.dart';
import 'models/user.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._privateConstructor();
  static Database? _database;

  DatabaseService._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'research_activity_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE FieldsOfScience(
        id INTEGER PRIMARY KEY,
        field_name TEXT NOT NULL
      );
      CREATE TABLE ScientificPublications(
        id INTEGER PRIMARY KEY,
        publication_title TEXT NOT NULL,
        publication_year INTEGER NOT NULL,
        author_id INTEGER NOT NULL,
        field_id INTEGER NOT NULL,
        file_path TEXT NOT NULL
      );
      CREATE TABLE ParticipationInScientificEvents(
        id INTEGER PRIMARY KEY,
        event_name TEXT NOT NULL,
        date TEXT NOT NULL,
        author_id INTEGER NOT NULL
      );
      CREATE TABLE Scientists(
        id INTEGER PRIMARY KEY,
        position TEXT NOT NULL,
        educational_institution TEXT NOT NULL,
        academic_degree TEXT NOT NULL
      );
      CREATE TABLE Users(
        id INTEGER PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT NOT NULL,
        role TEXT NOT NULL
      );
      ''');
  }

  Future<int> insertFieldOfScience(FieldOfScience field) async {
    Database db = await instance.database;
    return await db.insert('FieldsOfScience', field.toMap());
  }

  Future<int> insertScientificPublication(ScientificPublication publication) async {
    Database db = await instance.database;
    return await db.insert('ScientificPublications', publication.toMap());
  }

  Future<int> insertParticipationInScientificEvent(ParticipationInScientificEvent event) async {
    Database db = await instance.database;
    return await db.insert('ParticipationInScientificEvents', event.toMap());
  }

  Future<int> insertScientist(Scientist scientist) async {
    Database db = await instance.database;
    return await db.insert('Scientists', scientist.toMap());
  }

  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert('Users', user.toMap());
  }

  Future<List<FieldOfScience>> getAllFieldsOfScience() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('FieldsOfScience');
    return List.generate(maps.length, (i) {
      return FieldOfScience(
        id: maps[i]['id'],
        fieldName: maps[i]['field_name'],
      );
    });
  }

  // Добавьте методы для получения, обновления и удаления других таблиц

  Future<void> closeDatabase() async {
    Database db = await instance.database;
    await db.close();
  }
}