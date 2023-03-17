import 'package:flutter/material.dart';
import '../../masters_widgets/masters_template/masters_template.dart';
import '../../masters_widgets/masters_template/widgets/crud_view/widgets/widgets.dart';
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
        return MastersTemplate(
          description:
              'List of defined awareness groups. These will show only while assessing an observation. Types can be added or current ones edited from this screen.',
          entities: state.awarenessGroups,
          title: 'Awareness Groups',
          label: 'awareness group',
          note:
              'This awareness group has 7 awareness categories. Deletion is allowed for groups that have no awareness categories associated with them.',
          addEntity: () {},
          editEntity: () {},
          deleteEntity: () {},
          onRowClick: (value) {},
          crudItems: [
            CrudItem(
              label: 'Awareness Group Name (*)',
              content: CustomTextField(
                hintText: 'e.g. Environmental',
                onChanged: (value) {},
              ),
            ),
          ],
        );
      },
    );
  }
}
