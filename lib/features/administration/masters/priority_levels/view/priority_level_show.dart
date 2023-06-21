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

  static String pageTitle = 'Priority Level';
  static String pageLabel = 'priority level';

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
      listener: (context, state) => _checkDeletePriorityLevel(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          entity: state.selectedPriorityLevel,
          deleteEntity: () => _deletePriorityLevel(state),
          crudStatus: state.priorityLevelCrudStatus,
        );
      },
    );
  }

  void _deletePriorityLevel(PriorityLevelsState state) {
    priorityLevelsBloc.add(
      PriorityLevelDeleted(
        priorityLevelId: state.selectedPriorityLevel!.id!,
      ),
    );
  }

  void _checkDeletePriorityLevel(
      PriorityLevelsState state, BuildContext context) {
    if (state.priorityLevelCrudStatus.isSuccess) {
      priorityLevelsBloc.add(const PriorityLevelsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/priority-levels');
    }
    if (state.priorityLevelCrudStatus .isFailure) {
      priorityLevelsBloc.add(const PriorityLevelsStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }
}
