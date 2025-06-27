import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;
  static const int _version = 1;
  static const String _dbName = "gym_tracker.db";

  static Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(path, version: _version, onCreate: _onCreate);
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
    exercise_id INTEGER REFERENCES exercise (id) 
                        NOT NULL,
    date        TEXT    NOT NULL,
    weight      INTEGER NOT NULL,
    sets                NOT NULL
)

    ''');

    await db.execute('''
      CREATE TABLE exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        instructions TEXT
      )
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

  static Future<void> close() async {
    final db = _db;
    if (db != null) await db.close();
  }
}
