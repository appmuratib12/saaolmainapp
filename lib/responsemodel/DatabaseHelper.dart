import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Medicine.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'medicine_reminder.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE medicines(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, time TEXT, schedule TEXT)',
        );
      },
    );
  }

  Future<int> insertMedicine(MedicineModel medicine) async {
    Database db = await database;
    return await db.insert('medicines', medicine.toMap());
  }

  Future<List<MedicineModel>> getMedicines() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('medicines');
    return List.generate(maps.length, (i) {
      return MedicineModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteMedicine(int id) async {
    Database db = await database;
    await db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }
}
