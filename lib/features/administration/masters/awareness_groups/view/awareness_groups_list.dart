import 'package:flutter/material.dart';
import '../../masters_widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class AwarenessGroupsListView extends StatefulWidget {
  const AwarenessGroupsListView({super.key});

  @override
  State<AwarenessGroupsListView> createState() => _AwarenessGroupsState();
}

class _AwarenessGroupsState extends State<AwarenessGroupsListView> {
  @override
  void initState() {
    super.initState();
    context.read<AwarenessGroupsBloc>().add(AwarenessGroupsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwarenessGroupsBloc, AwarenessGroupsState>(
      builder: (context, state) {
        return MastersListTemplate(
          description:
              'List of defined awareness groups. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessGroups,
          title: 'Awareness Groups',
          label: 'awareness group',
          note:
              'This awareness group has 7 awareness categories. Deletion is allowed for groups that have no awareness categories associated with them.',
          onRowClick: (value) {},
        );
      },
    );
  }
}
