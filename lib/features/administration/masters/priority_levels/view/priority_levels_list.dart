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

  static String emptyMessage =
      'There are no priority levels. Please click on New Priority Level to assign new priority level.';
  static String title = 'Priority Levels';
  static String label = 'priority level';
  static String description =
      'List of defined Priority Levels. Types can be added or current ones edited from this screen.';

  @override
  void initState() {
    super.initState();
    priorityLevelsBloc = context.read<PriorityLevelsBloc>()
      ..add(PriorityLevelsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriorityLevelsBloc, PriorityLevelsState>(
      builder: (context, state) {
        return EntityListTemplate(
          description: description,
          entities: state.priorityLevels,
          title: title,
          label: label,
          emptyMessage: emptyMessage,
          onRowClick: (priorityLevel) {
            priorityLevelsBloc.add(PriorityLevelSelected(
              priorityLevel: priorityLevel as PriorityLevel,
            ));
          },
          entityListLoadStatusLoading:
              state.priorityLevelsLoadedStatus.isLoading,
          selectedEntity: state.selectedPriorityLevel,
        );
      },
    );
  }
}
