import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class PriorityLevels extends StatefulWidget {
  const PriorityLevels({super.key});

  @override
  State<PriorityLevels> createState() => _PriorityLevelsState();
}

class _PriorityLevelsState extends State<PriorityLevels> {
  @override
  void initState() {
    super.initState();
    context.read<PriorityLevelsBloc>().add(PriorityLevelsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriorityLevelsBloc, PriorityLevelsState>(
      builder: (context, state) {
        return MasterTable(
          description:
              'List of defined Priority Levels. Types can be added or current ones edited from this screen.',
          entities: state.priorityLevels,
          title: 'Priority Levels',
          label: 'priority level',
        );
      },
    );
  }
}
