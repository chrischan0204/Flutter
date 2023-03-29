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
    return BlocBuilder<AwarenessGroupsBloc, AwarenessGroupsState>(
      builder: (context, state) {
        return EntityListTemplate(
          description:
              'List of defined awareness groups. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessGroups,
          title: 'Awareness Groups List',
          label: 'awareness group',
          emptyMessage:
              'There are no awareness groups. Please click on New Awareness Group to add new awareness group.',
          entityRetrievedStatus: state.awarenessGroupsRetrievedStatus,
          onRowClick: (awarenessGroup) {
            awarenessGroupsBloc.add(AwarenessGroupSelected(
              awarenessGroup: awarenessGroup as AwarenessGroup,
            ));
          },
          selectedEntity: state.selectedAwarenessGroup,
        );
      },
    );
  }
}
