import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/widgets/exercise_card.dart';
import 'package:flutter/material.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30),
        child: Column(
          children: [
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
            ExerciseCard(
              exercise: Exercise(
                id: 1,
                name: 'Barbell Squats',
                instructions: '3 sets 10 reps',
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
