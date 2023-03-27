import 'package:flutter/material.dart';
import '/data/model/model.dart';
import '../../masters_widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class PriorityLevelsListView extends StatefulWidget {
  const PriorityLevelsListView({super.key});

  @override
  State<PriorityLevelsListView> createState() => _PriorityLevelsListViewState();
}

class _PriorityLevelsListViewState extends State<PriorityLevelsListView> {
  late PriorityLevelsBloc priorityLevelsBloc;
  late String successType = 'none';
  @override
  void initState() {
    super.initState();
    priorityLevelsBloc = context.read<PriorityLevelsBloc>()
      ..add(PriorityLevelsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriorityLevelsBloc, PriorityLevelsState>(
      listener: (context, state) => _displayNofitication(state),
      builder: (context, state) {
        return MastersListTemplate(
          description:
              'List of defined Priority Levels. Types can be added or current ones edited from this screen.',
          entities: state.priorityLevels,
          title: 'Priority Levels List',
          label: 'priority level',
          note:
              'This Priority Level is in use on 21 observations. An priority level can be removed from future use by deactivating. It will preserve all past data as is.',
          onRowClick: (priorityLevel) {
            priorityLevelsBloc.add(PriorityLevelSelected(
              priorityLevel: priorityLevel as PriorityLevel,
            ));
          },
          selectedEntity: state.selectedPriorityLevel,
          successType: successType,
        );
      },
    );
  }

  void _displayNofitication(PriorityLevelsState state) {
    bool success = false, failed = false;
    if (state.priorityLevelAddedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'add';
      });
      success = true;
    }
    if (state.priorityLevelEditedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'edit';
      });
      success = true;
    }
    if (state.priorityLevelDeletedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'delete';
      });
      success = true;
    }
    if (state.priorityLevelAddedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'add-fail';
      });
      failed = true;
    }
    if (state.priorityLevelEditedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'edit-fail';
      });
      failed = true;
    }
    if (state.priorityLevelDeletedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'delete-fail';
      });
      failed = true;
    }
    if (success || failed) {
      priorityLevelsBloc.add(const PriorityLevelsStatusInited());
    }
  }
}
