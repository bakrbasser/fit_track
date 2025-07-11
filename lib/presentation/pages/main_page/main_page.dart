import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
import 'package:fit_track/presentation/cubits/pages_navigator/pages_navigator_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/list/plans_list_cubit.dart';
import 'package:fit_track/presentation/pages/exercises/exercises_screen.dart';
import 'package:fit_track/presentation/pages/goals/goals_screen.dart';
import 'package:fit_track/presentation/pages/plans/plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('FitTrack'),
      //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      // ),
      bottomNavigationBar: MainNavigationBar(),
      body: BlocBuilder<PagesNavigatorCubit, PagesNavigatorState>(
        builder: (context, state) {
          // if (state is NavigatingHome) {

          // }
          if (state is NavigatingExercises) {
            return ExercisesScreen();
          }
          if (state is NavigatingPlans) {
            return BlocProvider(
              create: (context) => PlansListCubit(),
              child: PlansScreen(),
            );
          }
          if (state is NavigatingGoals) {
            return BlocProvider(
              create: (context) => GoalsListCubit(),
              child: GoalsScreen(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});
  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _selectedIndex = 0;
  void _onDestinationSelected(int value) {
    setState(() {
      _selectedIndex = value;
    });
    context.read<PagesNavigatorCubit>().navigate(value);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: _onDestinationSelected,
      selectedIndex: _selectedIndex,
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
  }
}
