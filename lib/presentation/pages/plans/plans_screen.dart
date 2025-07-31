import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/plans/list/plans_list_cubit.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlansListCubit>().loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Training Plans'), actions: [AddPlanButton()]),
      body: BlocBuilder<PlansListCubit, PlansListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FullList) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: CardList(
                items: state.plans,
                builder: (item) => PlanCard(plan: item),
              ),
            );
          } else {
            return NoElements(message: StringManager.noPlanFound);
          }
        },
      ),
    );
  }
}

class AddPlanButton extends StatelessWidget {
  const AddPlanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final nav = Navigator.of(context);
        final cub = context.read<PlansListCubit>();

        final isAdded = await nav.pushNamed(Routes.addPlan) as bool?;
        if (isAdded != null && isAdded) {
          cub.loadList();
        }
      },
      icon: Icon(Icons.add, size: 30),
    );
  }
}
