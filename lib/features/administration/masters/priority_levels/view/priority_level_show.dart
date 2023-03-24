import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../masters_widgets/master_show_template/master_show_template.dart';
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
        if (state.priorityLevelDeletedStatus == EntityStatus.succuess ||
            state.priorityLevelDeletedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/priority-levels');
        }
      },
      builder: (context, state) {
        return MasterShowTemplate(
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
        );
      },
    );
  }
}
