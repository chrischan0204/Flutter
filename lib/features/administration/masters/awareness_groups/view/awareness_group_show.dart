import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/data/bloc/bloc.dart';
import '/data/model/model.dart';
import '/global_widgets/global_widget.dart';

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
        if (state.awarenessGroupCrudStatus == EntityStatus.success) {
          awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/awareness-groups');
        }
        if (state.awarenessGroupCrudStatus == EntityStatus.failure) {
          awarenessGroupsBloc.add(const AwarenessGroupsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return EntityShowTemplate(
          title: 'Awareness Group',
          label: 'awareness group',
          entity: state.selectedAwarenessGroup,
          deletable: state.selectedAwarenessGroup != null &&
              state.selectedAwarenessGroup!.deletable,
          deleteEntity: () {
            awarenessGroupsBloc.add(
              AwarenessGroupDeleted(
                awarenessGroupId: state.selectedAwarenessGroup!.id!,
              ),
            );
          },
          descriptionForDelete:
              'It can\'t be deleted, it has awareness categories attached to it.',
          crudStatus: state.awarenessGroupCrudStatus,
        );
      },
    );
  }
}
