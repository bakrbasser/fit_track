
### Cubit Structure Notes

In this project, I followed a feature-based Cubit structure:
	•	Created one Cubit per screen or UI feature, not per operation or entity.
	•	Used separate Cubits for forms (e.g. ExerciseFormCubit) to manage input, validation, and submission.
	•	Used list/display Cubits (e.g. ExerciseListCubit) to manage data fetching and state updates.

I avoided splitting Cubits by individual operations or create a god cubit (like insert/delete), as it leads to unnecessary complexity. This approach keeps logic focused, aligns with clean architecture, and improves scalability and maintainability.
