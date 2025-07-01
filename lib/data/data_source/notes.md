Absolutely! Here’s a clear and simple summary of what goes in your /data/datasources/ folder in a Clean Architecture Flutter project:

⸻

✅ What Goes in /data/datasources/ Folder

Your Data Source classes are responsible for direct, low-level data access to your external sources — in your case, Sqflite (a local database).

⸻

🔧 Responsibilities of Data Sources
	•	Write and execute raw SQL queries or use Sqflite’s query, insert, update, delete methods
	•	Interact directly with the database (not with entities or models)
	•	Return raw data (e.g., Map<String, dynamic>) or optionally model objects
	•	Handle only 1 table or 1 source per method — no business logic

⸻

🧱 Example Structure

/data/
  /datasources/
    app_database.dart              // Initializes the database and creates tables
    training_local_data_source.dart  // TrainingDay + Exercises queries
    exercise_local_data_source.dart  // Exercise table CRUD


⸻

📌 Example: training_local_data_source.dart

class TrainingLocalDataSource {
  final Database db;

  TrainingLocalDataSource(this.db);

  Future<List<Map<String, dynamic>>> getTrainingDayExercises(int trainingDayId) async {
    return await db.rawQuery('''
      SELECT e.*, tde.sets, tde.reps
      FROM exercises e
      JOIN training_day_exercise tde ON e.id = tde.exercise_id
      WHERE tde.training_day_id = ?
    ''', [trainingDayId]);
  }

  Future<Map<String, dynamic>> getTrainingDayById(int id) async {
    final result = await db.query('training_days', where: 'id = ?', whereArgs: [id]);
    return result.first;
  }

  Future<void> insertTrainingDay(Map<String, dynamic> data) async {
    await db.insert('training_days', data);
  }

  // etc.
}


⸻

✅ So, in summary:

Concept	Goes in datasources?	Example
Database initialization	✅	app_database.dart
Table CRUD	✅	insert, update, delete, query
Raw SQL / JOIN queries	✅	rawQuery() for custom joined data
JSON → Map conversion	❌	Handled in models, not in data sources
Mapping to app models	❌	Done in repository, not data sources
Combining multiple queries	❌	Repositories or use cases handle this


⸻

Let me know if you’d like:
	•	An example for initializing your app_database.dart
	•	Help structuring training_local_data_source.dart fully
	•	Or a code template for one of your actual use cases