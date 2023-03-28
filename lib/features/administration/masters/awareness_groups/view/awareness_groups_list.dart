import 'package:flutter/material.dart';
import 'package:safety_eta/data/model/model.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AwarenessGroupsListView extends StatefulWidget {
  const AwarenessGroupsListView({super.key});

  @override
  State<AwarenessGroupsListView> createState() => _AwarenessGroupsState();
}

class _AwarenessGroupsState extends State<AwarenessGroupsListView> {
  late AwarenessGroupsBloc awarenessGroupsBloc;
  late String successType = 'none';
  @override
  void initState() {
    awarenessGroupsBloc = context.read<AwarenessGroupsBloc>()
      ..add(AwarenessGroupsRetrieved());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessGroupsBloc, AwarenessGroupsState>(
      listener: (context, state) => _displayNofitication(state),
      builder: (context, state) {
        return EntityListTemplate(
          description:
              'List of defined awareness groups. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessGroups,
          title: 'Awareness Groups List',
          label: 'awareness group',
          note:
              'This awareness group has 7 awareness categories. Deletion is allowed for groups that have no awareness categories associated with them.',
          onRowClick: (awarenessGroup) {
            awarenessGroupsBloc.add(AwarenessGroupSelected(
              awarenessGroup: awarenessGroup as AwarenessGroup,
            ));
          },
          selectedEntity: state.selectedAwarenessGroup,
          successType: successType,
        );
      },
    );
  }

  void _displayNofitication(AwarenessGroupsState state) {
    bool success = false, failed = false;
    if (state.awarenessGroupAddedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'add';
      });
      success = true;
    }
    if (state.awarenessGroupEditedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'edit';
      });
      success = true;
    }
    if (state.awarenessGroupDeletedStatus == EntityStatus.succuess) {
      setState(() {
        successType = 'delete';
      });
      success = true;
    }
    if (state.awarenessGroupAddedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'add-fail';
      });
      failed = true;
    }
    if (state.awarenessGroupEditedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'edit-fail';
      });
      failed = true;
    }
    if (state.awarenessGroupDeletedStatus == EntityStatus.failure) {
      setState(() {
        successType = 'delete-fail';
      });
      failed = true;
    }
    if (success || failed) {
      awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
    }
  }
}
