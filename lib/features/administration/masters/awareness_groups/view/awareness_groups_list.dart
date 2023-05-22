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

  static String pageDescription =
      'List of defined awareness groups. These will show only while assessing an observation. Types can be added or current ones edited from this screen.';
  static String pageTitle = 'Awareness Groups';
  static String pageLabel = 'awareness group';
  static String emtptyMessage =
      'There are no awareness groups. Please click on New Awareness Group to add new awareness group.';
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
          description: pageDescription,
          entities: state.awarenessGroups,
          title: pageTitle,
          label: pageLabel,
          emptyMessage: emtptyMessage,
          entityListLoadStatusLoading: state.awarenessGroupsRetrievedStatus.isLoading,
          onRowClick: (awarenessGroup) =>
              _selectAwarenessGroup(awarenessGroup as AwarenessGroup),
          selectedEntity: state.selectedAwarenessGroup,
        );
      },
    );
  }

  void _selectAwarenessGroup(AwarenessGroup awarenessGroup) {
    awarenessGroupsBloc.add(AwarenessGroupSelected(
      awarenessGroup: awarenessGroup,
    ));
  }
}
