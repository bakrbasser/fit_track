import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
import 'package:fit_track/presentation/cubits/pages_navigator/pages_navigator_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/list/plans_list_cubit.dart';
import 'package:fit_track/presentation/pages/exercises/exercises_screen.dart';
import 'package:fit_track/presentation/pages/goals/goals_screen.dart';
import 'package:fit_track/presentation/pages/home/home_screen.dart';
import 'package:fit_track/presentation/pages/plans/plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PagesNavigatorCubit()),
        BlocProvider(create: (_) => PlansListCubit()),
        BlocProvider(create: (_) => GoalsListCubit()),
        // BlocProvider(create: (_) => DaysListCubit()),
      ],
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(),
        body: BlocBuilder<PagesNavigatorCubit, PagesNavigatorState>(
          builder: (context, state) {
            final index = _getPageIndex(state);
            return IndexedStack(
              index: index,
              children: const [
                HomeScreen(),
                ExercisesScreen(),
                PlansScreen(),
                GoalsScreen(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagesNavigatorCubit, PagesNavigatorState>(
      builder: (context, state) {
        final currentIndex = _getPageIndex(state);

        return NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            context.read<PagesNavigatorCubit>().navigate(index);
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
            NavigationDestination(
              icon: ImageIcon(AssetImage(AssetsManager.dumbbell)),
              label: 'Exercises',
            ),
            NavigationDestination(icon: Icon(Icons.menu), label: 'Plans'),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_rounded),
              label: 'Goals',
            ),
          ],
        );
      },
    );
  }
}

int _getPageIndex(PagesNavigatorState state) {
  return switch (state) {
    NavigatingHome() => 0,
    NavigatingExercises() => 1,
    NavigatingPlans() => 2,
    NavigatingGoals() => 3,
  };
}
