import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/data/bloc/bloc.dart';
import '/data/model/model.dart';
import '../../masters_widgets/master_show_template/master_show_template.dart';

class AwarenessGroupShowView extends StatefulWidget {
  final String awarenessGroupId;
  const AwarenessGroupShowView({
    super.key,
    required this.awarenessGroupId,
  });

  @override
  State<AwarenessGroupShowView> createState() => _AwarenessGroupShowViewState();
}

class _AwarenessGroupShowViewState extends State<AwarenessGroupShowView> {
  late AwarenessGroupsBloc awarenessGroupsBloc;

  @override
  void initState() {
    awarenessGroupsBloc = context.read<AwarenessGroupsBloc>();
    awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
    awarenessGroupsBloc.add(AwarenessGroupSelectedById(
      awarenessGroupId: widget.awarenessGroupId,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessGroupsBloc, AwarenessGroupsState>(
      listener: (context, state) {
        if (state.awarenessGroupDeletedStatus == EntityStatus.succuess ||
            state.awarenessGroupDeletedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/awareness-groups');
        }
      },
      builder: (context, state) {
        return MasterShowTemplate(
          title: 'Awareness Group',
          label: 'awareness group',
          entity: state.selectedAwarenessGroup,
          deletable: state.selectedAwarenessGroup != null &&
              state.selectedAwarenessGroup!.categoryCount == 0,
          deleteEntity: () {
            awarenessGroupsBloc.add(
              AwarenessGroupDeleted(
                awarenessGroupId: state.selectedAwarenessGroup!.id!,
              ),
            );
          },
        );
      },
    );
  }
}
