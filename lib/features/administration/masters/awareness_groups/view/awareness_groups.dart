import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class AwarenessGroups extends StatefulWidget {
  const AwarenessGroups({super.key});

  @override
  State<AwarenessGroups> createState() => _AwarenessGroupsState();
}

class _AwarenessGroupsState extends State<AwarenessGroups> {
  @override
  void initState() {
    super.initState();
    context.read<AwarenessGroupsBloc>().add(AwarenessGroupsRetrieved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwarenessGroupsBloc, AwarenessGroupsState>(
      builder: (context, state) {
        return MasterTable(
          description:
              'List of defined awareness groups. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessGroups,
          title: 'Awareness Groups',
          label: 'awareness group',
        );
      },
    );
  }
}
