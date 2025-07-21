import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();
  AppDatabase._internal();
  static Database? _database;
  static const int _version = 1;
  static const String _dbName = "fit_tracker.db";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      // onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercise (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    name         TEXT    NOT NULL,
    instructions TEXT
)
    ''');

    await db.execute('''
      CREATE TABLE goal (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    exercise_id INTEGER REFERENCES exercise (id) 
                        NOT NULL,
    weight      INTEGER,
    reps        INTEGER,
    isAchieved  INTEGER DEFAULT (0) 
)
    ''');

    await db.execute('''
      CREATE TABLE exercise_log (
        exercise_id INTEGER NOT NULL REFERENCES exercise(id),
        date        TEXT    NOT NULL,
        volume      INTEGER NOT NULL,
        maxWeight   INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE training_day (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    description TEXT
)
    ''');

    await db.execute('''
      CREATE TABLE training_plan (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    description  TEXT,
    icon        TEXT,
    isActivated INTEGER NOT NULL
                        DEFAULT (0) 
)

    ''');
    await db.execute('''
CREATE TABLE trainingPlan_trainingDay (
    trainingDay_id   INTEGER REFERENCES training_day (id) 
                            NOT NULL,
    trainingPlan_id         REFERENCES training_plan (id) 
                            NOT NULL
)

    ''');
    await db.execute('''
CREATE TABLE trainingDay_exercise (
    trainingDay_id         REFERENCES training_day (id) 
                          NOT NULL,
    exercise_id   INTEGER REFERENCES exercise (id) 
                          NOT NULL,
    sets          INTEGER NOT NULL,
    reps          INTEGER NOT NULL
)
    ''');
  }

  // static Future<void> _onUpgrade(
  //   Database db,
  //   int oldVersion,
  //   int newVersion,
  // ) async {
  //   if (oldVersion < newVersion) {
  //     await db.execute('ALTER TABLE exercise_log RENAME TO exercise_log_old;');

  //     await db.execute('DROP TABLE exercise_log_old;');
  //     print(
  //       'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH',
  //     );
  //   }
  // }

  Future<void> close() async {
    final db = _database;
    if (db != null) await db.close();
  }
}
