import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();
  AppDatabase._internal();
  static Database? _database;
  static const int _version = 2;
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
    exercise_id INTEGER REFERENCES exercise (id) ON DELETE CASCADE
                        NOT NULL,
    weight      INTEGER,
    reps        INTEGER,
    isAchieved  INTEGER DEFAULT (0) 
);
    ''');

    await db.execute('''
      CREATE TABLE exercise_log (
    exercise_id INTEGER REFERENCES exercise (id) ON DELETE CASCADE
                        NOT NULL,
    date        TEXT    NOT NULL,
    weight      INTEGER NOT NULL,
    sets        INTEGER NOT NULL,
    reps        INTEGER NOT NULL
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
    trainingDay_id  INTEGER REFERENCES training_day (id) ON DELETE CASCADE
                            NOT NULL,
    trainingPlan_id         REFERENCES training_plan (id) ON DELETE CASCADE
                            NOT NULL
);

    ''');
    await db.execute('''
CREATE TABLE trainingDay_exercise (
    trainingDay_id         REFERENCES training_day (id) 
                           NOT NULL,
    exercise_id    INTEGER REFERENCES exercise (id) ON DELETE CASCADE
                           NOT NULL,
    sets           INTEGER NOT NULL,
    reps           INTEGER NOT NULL
);
    ''');
  }

  //   static Future<void> _onUpgrade(
  //     Database db,
  //     int oldVersion,
  //     int newVersion,
  //   ) async {
  //     if (oldVersion < newVersion) {
  //       try {
  //         await db.execute('''PRAGMA foreign_keys = 0;

  // CREATE TABLE sqlitestudio_temp_table AS SELECT *
  //                                           FROM exercise_log;

  // DROP TABLE exercise_log;

  // CREATE TABLE exercise_log (
  //     exercise_id INTEGER REFERENCES exercise (id) ON DELETE CASCADE
  //                         NOT NULL,
  //     date        TEXT    NOT NULL,
  //     weight      INTEGER NOT NULL,
  //     sets        INTEGER NOT NULL,
  //     reps        INTEGER NOT NULL
  // );

  // INSERT INTO exercise_log (
  //                              exercise_id,
  //                              date,
  //                              weight,
  //                              sets,
  //                              reps
  //                          )
  //                          SELECT exercise_id,
  //                                 date,
  //                                 weight,
  //                                 sets,
  //                                 reps
  //                            FROM sqlitestudio_temp_table;

  // DROP TABLE sqlitestudio_temp_table;

  // PRAGMA foreign_keys = 1;
  // ''');
  //         print('Success 1');
  //       } catch (e) {
  //         print('Failed 1');
  //       }

  //       try {
  //         await db.execute('''PRAGMA foreign_keys = 0;

  // CREATE TABLE sqlitestudio_temp_table AS SELECT *
  //                                           FROM goal;

  // DROP TABLE goal;

  // CREATE TABLE goal (
  //     id          INTEGER PRIMARY KEY AUTOINCREMENT,
  //     exercise_id INTEGER REFERENCES exercise (id) ON DELETE CASCADE
  //                         NOT NULL,
  //     weight      INTEGER,
  //     reps        INTEGER,
  //     isAchieved  INTEGER DEFAULT (0)
  // );

  // INSERT INTO goal (
  //                      id,
  //                      exercise_id,
  //                      weight,
  //                      reps,
  //                      isAchieved
  //                  )
  //                  SELECT id,
  //                         exercise_id,
  //                         weight,
  //                         reps,
  //                         isAchieved
  //                    FROM sqlitestudio_temp_table;

  // DROP TABLE sqlitestudio_temp_table;

  // PRAGMA foreign_keys = 1;

  // ''');
  //         print('Success 2');
  //       } catch (e) {
  //         print('Failed 2');
  //       }

  //       try {
  //         await db.execute('''PRAGMA foreign_keys = 0;

  // CREATE TABLE sqlitestudio_temp_table AS SELECT *
  //                                           FROM trainingDay_exercise;

  // DROP TABLE trainingDay_exercise;

  // CREATE TABLE trainingDay_exercise (
  //     trainingDay_id         REFERENCES training_day (id)
  //                            NOT NULL,
  //     exercise_id    INTEGER REFERENCES exercise (id) ON DELETE CASCADE
  //                            NOT NULL,
  //     sets           INTEGER NOT NULL,
  //     reps           INTEGER NOT NULL
  // );

  // INSERT INTO trainingDay_exercise (
  //                                      trainingDay_id,
  //                                      exercise_id,
  //                                      sets,
  //                                      reps
  //                                  )
  //                                  SELECT trainingDay_id,
  //                                         exercise_id,
  //                                         sets,
  //                                         reps
  //                                    FROM sqlitestudio_temp_table;

  // DROP TABLE sqlitestudio_temp_table;

  // PRAGMA foreign_keys = 1;

  // ''');
  //         print('Success 3');
  //       } catch (e) {
  //         print('Failed 3');
  //       }

  //       try {
  //         await db.execute('''PRAGMA foreign_keys = 0;

  // CREATE TABLE sqlitestudio_temp_table AS SELECT *
  //                                           FROM trainingPlan_trainingDay;

  // DROP TABLE trainingPlan_trainingDay;

  // CREATE TABLE trainingPlan_trainingDay (
  //     trainingDay_id  INTEGER REFERENCES training_day (id) ON DELETE CASCADE
  //                             NOT NULL,
  //     trainingPlan_id         REFERENCES training_plan (id) ON DELETE CASCADE
  //                             NOT NULL
  // );

  // INSERT INTO trainingPlan_trainingDay (
  //                                          trainingDay_id,
  //                                          trainingPlan_id
  //                                      )
  //                                      SELECT trainingDay_id,
  //                                             trainingPlan_id
  //                                        FROM sqlitestudio_temp_table;

  // DROP TABLE sqlitestudio_temp_table;

  // PRAGMA foreign_keys = 1;

  // ''');
  //         print('Success 4');
  //       } catch (e) {
  //         print('Failed 4');
  //       }
  //     }
  //   }

  Future<void> close() async {
    final db = _database;
    if (db != null) await db.close();
  }
}
