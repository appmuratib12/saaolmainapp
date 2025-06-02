import 'package:path/path.dart';
import 'package:saaolapp/data/network/NotificationNotifier.dart';
import 'package:sqflite/sqflite.dart';
import '../data/model/NotificationData.dart';


class NotificationDatabase {
  static final NotificationDatabase instance = NotificationDatabase._init();
  static Database? _database;

  NotificationDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notifications.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notifications (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body TEXT,
            imageUrl TEXT,
            date TEXT,
            isRead TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertNotification(NotificationData notification) async {
    final db = await instance.database;
    await db.insert(
      'notifications',
      notification.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _updateUnreadCount(); // 🔔 notify listeners
  }

  Future<void> markAllAsRead() async {
    final db = await instance.database;
    await db.update('notifications', {'isRead': 1});
    _updateUnreadCount(); // 🔔 notify listeners
  }

  Future<void> _updateUnreadCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM notifications WHERE isRead = 0');
    final count = Sqflite.firstIntValue(result) ?? 0;
    NotificationNotifier.unreadCountNotifier.value = count;
  }
  /*Future<void> insertNotification(NotificationData notification) async {
    final db = await instance.database;
    await db.insert(
      'notifications',
      notification.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }*/

  Future<List<NotificationData>> fetchNotifications() async {
    final db = await instance.database;
    final result = await db.query(
      'notifications',
      orderBy: 'date DESC',
    );
    return result.map((e) => NotificationData.fromMap(e)).toList();
  }

  Future<void> close() async {
    final db = await _database;
    db?.close();
  }
  Future<int> getUnreadCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM notifications WHERE isRead = 0');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /*Future<void> markAllAsRead() async {
    final db = await instance.database;
    await db.update('notifications', {'isRead': 1});
  }*/
}
