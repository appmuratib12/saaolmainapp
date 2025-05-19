import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'PatientAppointmentModel.dart';


class AppointmentDatabaseHelper {
  static final AppointmentDatabaseHelper _instance = AppointmentDatabaseHelper._internal();
  static Database? _database;

  factory AppointmentDatabaseHelper() {
    return _instance;
  }

  AppointmentDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializedDB();
    return _database!;
  }

  Future<Database> initializedDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'appointments.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE appointments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            time TEXT,
            mode TEXT,
            centerLocation TEXT,
            totalAmount TEXT,
            paymentID TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertAppointment(PatientAppointmentModel appointment) async {
    final db = await database;
    await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PatientAppointmentModel>> getAppointments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('appointments');

    return List.generate(maps.length, (i) {
      return PatientAppointmentModel.fromMap(maps[i]);
    });
  }
}
