import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/entity.dart';
import '/data/bloc/bloc.dart';

class PriorityLevelShowView extends StatefulWidget {
  final String priorityLevelId;
  const PriorityLevelShowView({
    super.key,
    required this.priorityLevelId,
  });

  @override
  State<PriorityLevelShowView> createState() => _PriorityLevelShowViewState();
}

class _PriorityLevelShowViewState extends State<PriorityLevelShowView> {
  late PriorityLevelsBloc priorityLevelsBloc;

  @override
  void initState() {
    priorityLevelsBloc = context.read<PriorityLevelsBloc>();
    priorityLevelsBloc.add(const PriorityLevelsStatusInited());
    priorityLevelsBloc.add(PriorityLevelSelectedById(
      priorityLevelId: widget.priorityLevelId,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriorityLevelsBloc, PriorityLevelsState>(
      listener: (context, state) {
        if (state.priorityLevelCrudStatus == EntityStatus.success) {
          priorityLevelsBloc.add(const PriorityLevelsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/priority-levels');
        }
        if (state.priorityLevelCrudStatus == EntityStatus.failure) {
          priorityLevelsBloc.add(const PriorityLevelsStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return EntityShowTemplate(
          title: 'Priority Level',
          label: 'priority level',
          entity: state.selectedPriorityLevel,
          deleteEntity: () {
            priorityLevelsBloc.add(
              PriorityLevelDeleted(
                priorityLevelId: state.selectedPriorityLevel!.id!,
              ),
            );
          },
          crudStatus: state.priorityLevelCrudStatus,
        );
      },
    );
  }
}
