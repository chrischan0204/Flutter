import 'package:flutter/material.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class PriorityLevelsListView extends StatefulWidget {
  const PriorityLevelsListView({super.key});

  @override
  State<PriorityLevelsListView> createState() => _PriorityLevelsListViewState();
}

class _PriorityLevelsListViewState extends State<PriorityLevelsListView> {
  late PriorityLevelsBloc priorityLevelsBloc;
  @override
  void initState() {
    super.initState();
    priorityLevelsBloc = context.read<PriorityLevelsBloc>()
      ..add(PriorityLevelsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriorityLevelsBloc, PriorityLevelsState>(
      builder: (context, state) {
        return EntityListTemplate(
          description:
              'List of defined Priority Levels. Types can be added or current ones edited from this screen.',
          entities: state.priorityLevels,
          title: 'Priority Levels List',
          label: 'priority level',
          onRowClick: (priorityLevel) {
            priorityLevelsBloc.add(PriorityLevelSelected(
              priorityLevel: priorityLevel as PriorityLevel,
            ));
          },
          entityRetrievedStatus: state.priorityLevelsRetrievedStatus,
          selectedEntity: state.selectedPriorityLevel,
        );
      },
    );
  }
}
