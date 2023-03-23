import 'package:flutter/material.dart';
import '../../masters_widgets/widgets.dart';
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
        return MastersListTemplate(
          description:
              'List of defined Priority Levels. Types can be added or current ones edited from this screen.',
          entities: state.priorityLevels,
          title: 'Priority Levels',
          label: 'priority level',
          note:
              'This Priority Level is in use on 21 observations. An priority level can be removed from future use by deactivating. It will preserve all past data as is.',
          onRowClick: (value) {},
        );
      },
    );
  }
}
